import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_flutter/model/Home/home.dart';
import 'package:task_flutter/utils/images.dart';
import 'package:task_flutter/utils/themeColor.dart';

class TaskItem extends StatelessWidget {
  Task item;

  TaskItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
          color: ColorsFave.backgroundPages,
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: imageProvider,
                    ),
                  ),
                )),
            imageUrl:
                'https://info.cegedim-healthcare.co.uk/hubfs/CHS_Tasks%20logo.png',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsFave.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.fill, image: AssetImage(Images.logo)),
                      ),
                    )),
            errorWidget: (context, url, error) => AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsFave.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(Images.logo)),
                  ),
                )),
          ),
          const SizedBox(height: 10),
          Text(
            item.taskName,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              item.taskDescription,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: item.assignedTo.map((label) {
              return Chip(
                padding: const EdgeInsets.symmetric(horizontal:20),
                label: Text(
                  label.name,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsFave.primaryColor,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
