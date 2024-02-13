import 'package:flutter/material.dart';
import 'package:task_flutter/utils/themeColor.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  Function onPressed;
  double? width;

  ButtonWidget(
      {Key? key, required this.text, required this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsFave.primaryColor,
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.5)),
        ),
        onPressed: () {
          onPressed();
        },
        child: FittedBox(
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily:'PoppinsBold',
                  fontSize: 16)),
        ),
      ),
    );
  }
}
