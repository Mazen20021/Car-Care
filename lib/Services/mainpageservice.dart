import 'package:carcare/Config/constants.dart';
import 'package:carcare/Pages/car_not_selected_page.dart';
import 'package:carcare/Services/APIs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Pages/car_selected_page.dart';

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
  MainPageService({
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
    // TODO: implement createState
   return _MainPageService();
  }

}
class _MainPageService extends State<MainPageService> {
  Future<FetchCarsResult>? _fetchCarsResult;

  @override
  void initState() {
    super.initState();
    // Start fetching cars when the widget is initialized
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
              color: MainColors.primary,
              backgroundColor: MainColors.background,
            )
          ],)
          ));
        } else if (snapshot.hasError) {
          // If an error occurred, handle it
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          // Once the data is fetched, check the result
          final result = snapshot.data!;
          if (result.success) {
            print("Fetched cars successfully: ${result.cars.length} items");
            // Return the CarSelectedPage with the data
            return CarSelectedPage(
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
          } else {
            print("Failed to fetch cars: ${result.error}");
            return CarNotSelectedPage(
              userEmail: widget.userEmail ,
              userLastName: widget.userLastName ,
              userName: widget.userName,
              currentIndex: widget.currentIndex,
              profileID: widget.profileID,
            );
          }
        }
      },
    );
  }
}

