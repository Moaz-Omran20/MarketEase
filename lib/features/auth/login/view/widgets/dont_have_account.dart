import 'package:flutter/material.dart';

import '../../../signup/view/signup_view.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupView()),
            );
          },
          child: Text("Sign Up Now"),
        ),
      ],
    );
  }
}
