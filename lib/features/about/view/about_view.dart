import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(),
    );
  }
}
