import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !isHidden,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration (
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(onPressed: togglePasswordVisibility, icon: isHidden?Icon(Icons.visibility): Icon(Icons.visibility_off))
      ),

    );
  }
  void togglePasswordVisibility()=> setState(()=>isHidden = !isHidden);
}