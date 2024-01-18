import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:password_app/Demo.dart';
import 'dart:convert';
import 'addPassword.dart';

void main() {
  runApp(
    MaterialApp(
      home: PassGeneration(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            tooltip: 'Settings Icon',
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: 'Add Icon',
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
            "Secret Password",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.amber[600],
            ),
          ),
        ),
        body: FutureBuilder<List<MyData>>(
          future: fetchData(), // Replace with your API endpoint
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Loading indicator while data is fetched
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No data available");
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  MyData data = snapshot.data![index];

                  return _buildCard(
                      data.title, data.description, "assets/image1.jpg");
                },
              );
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              icon: Icon(
                Icons.warning,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite, // Using king_bed as a crown icon placeholder
                color: Colors.white,
              ),
              onPressed: () {
                // Add your king crown icon onPressed behavior here
              },
            ),
          ]),
        ));
  }

  Widget _buildCard(String title, String description, String imagePath) {
    String finalImagePath = "assets/locked.png";

    if (imagePath == "0") {
      finalImagePath = "assets/unlock.png";
    } else if (imagePath == "1") {
      finalImagePath = "assets/locked.png";
    }
    return Card(
      elevation: 3.0,
      color: const Color.fromARGB(255, 0, 0, 0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Container(
          width: 80.0, // Adjust the width as needed
          height: 80.0, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(finalImagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.amber[600],
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

Future<List<MyData>> fetchData() async {
  final response = await http.get(Uri.parse("https://vncode.site/0899996922"));
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    print(response.body);
    print("CUC CUT");
    return list.map((model) => MyData.fromJson(model)).toList();
  } else {
    print("CUC CUT2");
    throw Exception("Failed to load data");
  }
}

class MyData {
  final String title;
  final String description;
  final String image;

  MyData({required this.title, required this.description, required this.image});

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        image: json["image"] ?? "");
  }
}
