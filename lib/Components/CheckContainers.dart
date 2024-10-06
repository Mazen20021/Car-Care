import 'package:flutter/material.dart';

class ChecksChildren extends StatelessWidget
{
  final IconData containerIcon;
  final String containerTitle;
  final String kmLeft;
  final Color containerBorderColor;

  const ChecksChildren({required this.containerIcon , required this.containerTitle , required this.kmLeft , required this.containerBorderColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
      color: containerBorderColor,
      ),
      padding: const EdgeInsets.all(16.0),
      child:Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
        Icon(containerIcon),
            const SizedBox(height: 10),
            Text(containerTitle),
            const SizedBox(height: 5),
            Text(kmLeft),
      ])),
    );
  }

}