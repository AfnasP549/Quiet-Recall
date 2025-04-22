import 'package:flutter/material.dart';
import 'package:quiet_recall/core/constants/app_color.dart';

class GameTimer extends StatelessWidget {
  final String time;

  const GameTimer({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.access_time_filled,
            color: AppColor.iconPrimaryColor,
          ),
          SizedBox(width: 10),
          Text(
            time,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
