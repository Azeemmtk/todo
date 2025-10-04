import 'package:flutter/material.dart';

import '../../../../core/color.dart';

class PendingCompleteWidget extends StatelessWidget {
  const PendingCompleteWidget({
    super.key, required this.title, required this.count, this.isCompleted= false,
  });

  final String title;
  final String count;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(title,style: TextStyle(
              color: primary,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(width: 5),
          Container(
            height: 20,
            width: isCompleted ? 35 :25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: boxColor,
            ),
            child: Center(child: Text(count)),
          ),
        ],
      ),
    );
  }
}
