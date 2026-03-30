import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.maxLines = 1,
    required this.autoValidateMode,
    this.obSecure = false,
    required this.prefixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool obSecure;
  final AutovalidateMode autoValidateMode;
  final Icon prefixIcon;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: const Color(0xFF94A3B8),
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: widget.obSecure && !isActive,
          autovalidateMode: widget.autoValidateMode,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: Theme.of(context).textTheme.labelMedium,
          maxLines: widget.maxLines,
          validator: widget.validator,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            prefixIconColor: const Color(0xFF94A3B8),
            suffixIcon: widget.obSecure
                ? IconButton(
                    onPressed: () {
                      isActive = !isActive;
                      setState(() {});
                    },
                    icon: isActive
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
