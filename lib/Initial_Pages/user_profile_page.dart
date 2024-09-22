import 'package:flutter/material.dart';

class NewUserProfilePage extends StatefulWidget {
  const NewUserProfilePage({super.key});

  @override
  State<NewUserProfilePage> createState() => _NewUserProfilePageState();
}

class _NewUserProfilePageState extends State<NewUserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
    );
  }
}
