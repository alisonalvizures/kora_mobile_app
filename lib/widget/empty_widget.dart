import 'package:flutter/material.dart';
import 'package:kora_app/views/colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 200, color: darkpurple,),
            Text(
              text,
              style: const TextStyle(fontSize: 30, color: darkpurple),
            ),
          ],
        ),
      );
}
