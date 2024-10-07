import 'package:carcare/Pages/car_not_selected_page.dart';
import 'package:flutter/material.dart';
import '../Pages/car_selected_page.dart';

class MainPageService extends StatelessWidget {
  final bool isCarSelected;
  final String userName;
  final int currentIndex;
  const MainPageService(
      {required this.isCarSelected,
      required this.userName,
      required this.currentIndex,
      super.key});

  @override
  Widget build(BuildContext context) => !isCarSelected
      ? CarNotSelectedPage(userName: userName, currentIndex: currentIndex)
      : CarSelectedPage(currentIndex: currentIndex, userName: userName);
}
