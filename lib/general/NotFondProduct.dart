import 'package:flutter/material.dart';
import 'package:task_flutter/utils/themeColor.dart';

class NotFoundPrduct extends StatelessWidget {
  Function pres;

  NotFoundPrduct({required this.pres});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.hourglass_empty,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('Add task please',
              style: TextStyle(fontSize: 25, color: ColorsFave.primaryColor)),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsFave.primaryColor,
                  elevation: 0,
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {pres();},
                child: const Icon(
                  Icons.refresh,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
