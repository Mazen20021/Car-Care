import 'package:carcare/Pages/carnotselectedpage.dart';
import 'package:flutter/material.dart';
import '../Pages/carselectedpage.dart';

class MainPageService extends StatelessWidget
{
  final bool isCarSelected;
  final String userName;
  final int currentIndex;
  const MainPageService({required this.isCarSelected, required this.userName , required this.currentIndex,super.key});

  @override
  Widget build(BuildContext context) {
    return !isCarSelected? CarNotSelectedPage(userName: userName, currentIndex: currentIndex) : CarSelectedPage(currentIndex: currentIndex,userName: userName);
  }
}