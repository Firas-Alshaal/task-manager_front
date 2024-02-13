import 'package:flutter/material.dart';
import 'package:task_flutter/utils/themeColor.dart';
import 'package:task_flutter/widget/Home/button.dart';

class NotFoundPage extends StatelessWidget {
  Function onPressed;

  NotFoundPage({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Page not found',
            style: TextStyle(fontSize: 17, color: ColorsFave.primaryColor)),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ButtonWidget(
            text: 'Try again',
            onPressed: () {
              onPressed();
            },
          ),
        )
      ],
    );
  }
}
