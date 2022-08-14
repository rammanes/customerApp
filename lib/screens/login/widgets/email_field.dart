import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration (
          hintText: 'Username',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }
}
