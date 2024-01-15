import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Lock",
          style: TextStyle(color: Colors.amber[600], fontSize: 12.0),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: InputForm(),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Input title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Input your password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            UnlockWidget(
              onUnlock: () {
                // Code to execute when unlocking is successful
                print('Unlock successful!');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

class UnlockWidget extends StatefulWidget {
  final VoidCallback onUnlock;

  const UnlockWidget({required this.onUnlock});

  @override
  _UnlockWidgetState createState() => _UnlockWidgetState();
}

class _UnlockWidgetState extends State<UnlockWidget> {
  double slideValue = 0.0;
  bool isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300.0, // Adjust the width as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: RoundedRectSliderTrackShape(),
              thumbColor: Colors.white,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: slideValue,
              onChanged: (value) {
                setState(() {
                  slideValue = value;
                });
              },
              onChangeEnd: (value) {
                if (value >= 1.0) {
                  setState(() {
                    isUnlocked = true;
                  });
                  widget.onUnlock(); // Trigger the unlock callback
                  // Wait for a short duration, then navigate back
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });




                  
                }
              },
            ),
          ),
        ),
        SizedBox(height: 16.0),
        isUnlocked
            ? Icon(
                Icons.check,
                color: Colors.green,
                size: 80.0,
              )
            : Text(
                'Slide to Unlock',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide to Unlock Example'),
      ),
      body: Center(
        child: UnlockWidget(
          onUnlock: () {
            // Code to execute when unlocking is successful
            print('Unlock successful!');
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: MyHomePage(),
    ),
  );
}
