import 'package:flutter/material.dart';
import 'package:task_flutter/utils/themeColor.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintTitle,
      this.onChanged,
      required this.errorTitle})
      : super(key: key);

  TextEditingController controller;

  ValueChanged<String>? onChanged;
  String? errorVariable;
  String? errorTitle;
  String hintTitle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      cursorColor: ColorsFave.primaryColor,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: hintTitle,
        hintStyle: TextStyle(
          color: Colors.grey[500], // Hint text color
        ),
        // hintStyle: TextStyle(color: ColorsFave.blackProductText, fontSize: 12),
        filled: true,
        errorText: errorVariable,
        fillColor: Colors.grey[200],
        // fillColor: ColorsFave.genderColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return errorVariable = errorTitle;
        } else {
          errorVariable = null;
        }
        return errorVariable;
      },
    );
  }
}
