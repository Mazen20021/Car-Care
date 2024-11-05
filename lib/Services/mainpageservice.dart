import 'package:carcare/Config/constants.dart';
import 'package:carcare/Pages/car_not_selected_page.dart';
import 'package:carcare/Pages/login_page.dart';
import 'package:carcare/Services/APIs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Pages/car_selected_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainPageService extends StatefulWidget{
  final String userName;
  final int currentIndex;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final String profileID;
  final String userLastName;
  final String userEmail;
  const MainPageService({
    required this.userName,
    required this.currentIndex,
    required this.costs,
    required this.date,
    required this.liters,
    required this.petrolName,
    required this.itemsNumber,
    required this.profileID,
    required this.userEmail , required this.userLastName,
    super.key});

  @override
  State<StatefulWidget> createState() {
   return _MainPageService();
  }
}
class _MainPageService extends State<MainPageService> {
  Future<FetchCarsResult>? _fetchCarsResult;
  @override
  void initState() {
    super.initState();
    _fetchCarsResult = getCars();
  }

  Future<FetchCarsResult> getCars() async {
    AuthActions aa = AuthActions(context);
    return await aa.fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FetchCarsResult>(
      future: _fetchCarsResult,
      builder: (BuildContext context, AsyncSnapshot<FetchCarsResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the result, show a loading indicator
          return Container(
            decoration: const BoxDecoration(color: MainColors.primary),
              child: Center(child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text("Please Wait While Loading Your Data",style: GoogleFonts.rubik(
              color: MainColors.white ,
              fontSize: 15,
              decoration: TextDecoration.none
            ),),
            const SizedBox(width: 10),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 42, 87, 208),
              backgroundColor: MainColors.background,
            )
          ],)
          ));
        } else if (snapshot.hasError) {
          // If an error occurred, handle it
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final result = snapshot.data!;
          if (result.success) {
            return CarSelectedPage(
              profileID: widget.profileID,
              myCars: result.cars,
              userEmail: widget.userEmail ,
              userLastName: widget.userLastName ,
              currentIndex: widget.currentIndex,
              userName: widget.userName,
              costs: widget.costs,
              date: widget.date,
              itemsNumber: widget.itemsNumber,
              liters: widget.liters,
              petrolName: widget.petrolName,
            );
          } else if(result.error == null){
            print("Failed to fetch cars: ${result.error}");
            return CarNotSelectedPage(
              userEmail: widget.userEmail ,
              userLastName: widget.userLastName ,
              userName: widget.userName,
              currentIndex: widget.currentIndex,
              profileID: widget.profileID,
            );
          }else{
            return const Login();
          }
        }
      },
    );
  }
}

