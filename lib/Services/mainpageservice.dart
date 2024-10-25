import 'package:carcare/Pages/car_not_selected_page.dart';
import 'package:flutter/material.dart';
import '../Pages/car_selected_page.dart';

class MainPageService extends StatelessWidget {
  final bool isCarSelected;
  final String userName;
  final int currentIndex;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  const MainPageService(
      {required this.isCarSelected,
        required this.userName,
        required this.currentIndex,
        required this.costs,
        required this.date,
        required this.liters,
        required this.petrolName,
        required this.itemsNumber,
      super.key});

  @override
  Widget build(BuildContext context) => !isCarSelected
      ? CarNotSelectedPage(userName: userName, currentIndex: currentIndex)
      : CarSelectedPage(currentIndex: currentIndex,
                        userName: userName,
                        costs: costs,
                        date:date ,
                        itemsNumber: itemsNumber,
                        liters: liters,
                        petrolName: petrolName);
}
