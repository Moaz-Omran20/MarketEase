import 'package:flutter/material.dart';

class OrLoginWith extends StatelessWidget {
  const OrLoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: .5,
            color: Color(0xFF94A3B8),
          ),
        ),
        Text(
          "  OR Log in with  ",
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Color(0xFF94A3B8)),
        ),
        Expanded(
          child: Container(
            height: .5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
