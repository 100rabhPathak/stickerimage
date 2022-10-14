import 'package:flutter/material.dart';
import 'package:testdemocamera/emoji.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Emoji(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 50),
            child: Image.asset(
              "assets/img/new.png",
              width: 60,
            ),
          ),
          const SizedBox(
            height: 600,
          ),
          Center(
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/img/icon.png",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () async {},
                label: const Text('Choose Image'),
                icon: const Icon(Icons.image),
              ),
              ElevatedButton.icon(
                onPressed: () async {},
                label: const Text('Take Photo'),
                icon: const Icon(Icons.camera_alt_outlined),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
