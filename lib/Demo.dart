import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_app/addPassword.dart';
import 'package:password_app/main.dart';

class PassGeneration extends StatefulWidget {
  const PassGeneration({Key? key}) : super(key: key);

  @override
  State<PassGeneration> createState() => _PassGenerationState();
}

class _PassGenerationState extends State<PassGeneration> {
  bool powerOn = false;
  TextEditingController lengthController = TextEditingController();

  String line1Text = 'Line 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          iconSize: 30,
          tooltip: 'Close Icon',
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            iconSize: 30,
            tooltip: 'Check Icon',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddScreen(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          "Password",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              line1Text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Memorizable',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 20.0),
                CupertinoSwitch(
                  value: powerOn,
                  onChanged: (value) {
                    setState(() {
                      powerOn = value;
                      if (powerOn) {
                        print('Switch turned ON');
                      } else {
                        print('Switch turned OFF');
                      }
                    });
                  },
                  activeColor: Colors.blueGrey,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: lengthController,
              style: TextStyle(color: Colors.white), // Set the text color
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'LENGTH',
                labelStyle: TextStyle(color: Colors.white), // Set the label color
              ),
            ),
            SizedBox(height: 20.0),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: Colors.grey, // Background color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text(
                    'Regenerate Password',
                    style: TextStyle(
                      color: Colors.white,
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

  void regeneratePassword() 
  {
    // Get the length entered by the user
    int passwordLength = int.tryParse(lengthController.text) ?? 0;

    // Generate a random password
    String newPassword = generateRandomPassword(passwordLength);

    // Now you can use the newPassword variable or incorporate it into your logic
    print('Random Password Generated: $newPassword');

    // Update the "Line 1" text
    setState(() 
    {
      line1Text = newPassword;
    });
  }

  String generateRandomPassword(int length) 
  {
    const String validChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_-+=<>?/[]{},.:;|';

    final Random random = Random();
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < length; i++) 
    {
      int randomIndex = random.nextInt(validChars.length);
      buffer.write(validChars[randomIndex]);
    }

    return buffer.toString();
  }
}
