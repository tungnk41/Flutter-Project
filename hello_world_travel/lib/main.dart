import 'package:flutter/material.dart';

void main() {
  runApp(const HelloWorldTravel());
}

class HelloWorldTravel extends StatelessWidget {
  const HelloWorldTravel({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello World Travel',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(title: 'Hello World Travel App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Hello World Travel",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Discovery the World",
                      style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 10,
                              spreadRadius: 2)
                        ]),
                        child: Image.network(
                            "https://images.freeimages.com/images/large-previews/eaa/the-beach-1464354.jpg",
                            height: 350),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                        onPressed: () => onContactButtonClicked(context),
                        child: const Text("Contact us")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void onContactButtonClicked(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Contact Us"),
            content: const Text(" Content Dialog"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"))
            ],
          ));
}
