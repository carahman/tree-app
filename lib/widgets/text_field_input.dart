import 'package:flutter/material.dart';
// import 'package:tree_app/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final bool isRead;
  final String label;
  final String prefix;

  const TextFieldInput(
      {Key? key,
      required this.textEditingController,
      this.isPass = false,
      this.isRead = false,
      this.label = '',
      this.prefix = '',
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // inputBorder variable
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        //labelText: label,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        prefixText: prefix,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 85, 85, 85),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      readOnly: isRead,
    );
  }
}
