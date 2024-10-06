import 'package:flutter/material.dart';

class CheckContainer extends StatelessWidget
{
  final IconData containerIcon;
  final String containerTitle;
  final String kmLeft;
  final Color containerBorderColor;

  const CheckContainer({required this.containerIcon , required this.containerTitle , required this.kmLeft , required this.containerBorderColor,super.key});

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
            SizedBox(height: 10),
            Text(containerTitle),
            SizedBox(height: 5),
            Text(kmLeft),
      ])),
    );
  }

}