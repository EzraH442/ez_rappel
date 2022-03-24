import 'package:flutter/material.dart';
import 'package:ez_rappel/page_components.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: const Center(
          child: Text('data'),
        ),
        drawer: mainDrawer(context));
  }
}
