import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PassGeneration extends StatefulWidget {
  const PassGeneration({Key? key}) : super(key: key);

  @override
  State<PassGeneration> createState() => _PassGenerationState();
}

class _PassGenerationState extends State<PassGeneration> {
  bool powerOn1 = false;

  bool powerOn2 = false;

  double sliderValue = 6.0; // Default length

  TextEditingController lengthController = TextEditingController();

  String linerandomText = '';

  String line1Text = 'Length (6 - 32): 6';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      
      //Thanh tiêu đề 
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: const Icon(Icons.close),
        //   color: Colors.white,
        //   iconSize: 30,
        //   tooltip: 'Close Icon',
        //   onPressed: () {},
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.check),
        //     color: Colors.white,
        //     iconSize: 30,
        //     tooltip: 'Check Icon',
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => AddScreen(),
        //         ),
        //       );
        //     },
        //   ),
        // ],
        centerTitle: true,
        title: Text(
          "Tools",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      // Phần Body
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(

          // Hàng thứ nhất
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              line1Text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),

          // Hàng thứ hai
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Slider(
                    value: sliderValue,
                    min: 6,
                    max: 32,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                        line1Text = 'Length (6 - 32): ${sliderValue.toInt()}';
                      });
                    },
                    activeColor: Colors.red, // Set the desired color
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),


          // Hàng thứ ba
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Avoid Ambiguous',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(height: 20.0),
                CupertinoSwitch(
                  value: powerOn1,
                  onChanged: (value) {
                    setState(() {
                      powerOn1 = value;
                      if (powerOn1) 
                      {
                        print('Switch 1 turned ON');
                      } 
                      else 
                      {
                        print('Switch 1 turned OFF');
                      }
                    });
                  },
                  activeColor: Colors.blueGrey,
                ),
              ],
            ),
            SizedBox(height: 20.0),

          // Hàng thứ tư
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Special Characters',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(height: 20.0),
                CupertinoSwitch(
                  value: powerOn2,
                  onChanged: (value) {
                    setState(() {
                      powerOn2 = value;
                      if (powerOn2) 
                      {
                        print('Switch 2 turned ON');
                      } 
                      else 
                      {
                        print('Switch 2 turned OFF');
                      }
                    });
                  },
                  activeColor: Colors.blueGrey,
                ),
              ],
            ),
            SizedBox(height: 20.0),

          // Hàng thứ năm
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    linerandomText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.content_copy,
                    color: Colors.blue,
                  ),    
                  onPressed: () {
                    copyToClipboard(linerandomText);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                      content: Text('Text copied to clipboard'),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),

          // Hàng thứ sáu
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()), // Empty space to the left
                ElevatedButton(
                  onPressed: () {
                    // Add your button functionality here
                    print('Button pressed');
                    regeneratePassword();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.blueAccent, width: 2.0), // Border color and width
                    ),
                    primary: Colors.white, // Transparent background color
                  ),
                  child: Text(
                    'Generate Password',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: Container()), // Empty space to the right
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }


  void regeneratePassword() 
  {
    // Get the length entered by the user
    int passwordLength = int.tryParse(lengthController.text) ?? 0;

    // Generate a random password
    String newPassword = generateRandomPassword(sliderValue.toInt());

    // Now you can use the newPassword variable or incorporate it into your logic
    print('Random Password Generated: $newPassword');

    // Update the "Line 1" text
    setState(() 
    {
      linerandomText = newPassword;
    });
  }

  String generateRandomPassword(int length) 
  {
    const String validChars1 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_-+=<>?/[]{},.:;|';

    const String validChars2 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    final Random random = Random();
    StringBuffer buffer = StringBuffer();

    if (powerOn2) 
    {
      for (int i = 0; i < length; i++) 
      {
        int randomIndex = random.nextInt(validChars1.length);
        buffer.write(validChars1[randomIndex]);
      }
    }
    else if (powerOn1)
    {
      for (int i = 0; i < length; i++) 
      {
        int randomIndex = random.nextInt(validChars2.length);
        buffer.write(validChars2[randomIndex]);
      }
    }
    else
    {
      for (int i = 0; i < length; i++) 
      {
        int randomIndex = random.nextInt(validChars2.length);
        buffer.write(validChars2[randomIndex]);
      }
    }

    return buffer.toString();
  }
}
