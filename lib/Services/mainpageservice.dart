import 'package:carcare/Config/constants.dart';
import 'package:carcare/Pages/car_not_selected_page.dart';
import 'package:carcare/Pages/login_page.dart';
import 'package:carcare/Services/repair_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Pages/car_selected_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'car_api.dart';

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
  Future<FetchRepairsResult>? _fetchRepairsResult;
  @override
  void initState() {
    super.initState();
    _fetchCarsResult = getCars();
    _fetchRepairsResult = getRepairs();
  }

  Future<FetchCarsResult> getCars() async {
    CarAPI carApi = CarAPI(context);
    return await carApi.fetchCars();
  }
  Future<FetchRepairsResult> getRepairs() async {
    RepairApi repairApi = RepairApi(context);
    return await repairApi.fetchRepairs();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_fetchCarsResult!, _fetchRepairsResult!]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(color: MainColors.primary),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Please Wait While Loading Your Data",
                    style: GoogleFonts.rubik(
                      color: MainColors.white,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const CircularProgressIndicator(
                    color: Color.fromARGB(255, 42, 87, 208),
                    backgroundColor: MainColors.background,
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final FetchCarsResult carsResult = snapshot.data![0];
          final FetchRepairsResult repairsResult = snapshot.data![1];
          if (carsResult.success && repairsResult.success) {
            return CarSelectedPage(
              upComingChecks: repairsResult.repairs,
              profileID: widget.profileID,
              myCars: carsResult.cars,
              userEmail: widget.userEmail,
              userLastName: widget.userLastName,
              currentIndex: widget.currentIndex,
              userName: widget.userName,
              costs: widget.costs,
              date: widget.date,
              itemsNumber: widget.itemsNumber,
              liters: widget.liters,
              petrolName: widget.petrolName,
            );
          } else if (!carsResult.success && !repairsResult.success) {
            print("Failed to fetch cars: ${carsResult.error}");
            return CarNotSelectedPage(
              userEmail: widget.userEmail,
              userLastName: widget.userLastName,
              userName: widget.userName,
              currentIndex: widget.currentIndex,
              profileID: widget.profileID,
            );
          } else if(carsResult.success && !repairsResult.success)
            {
              return CarSelectedPage(
                upComingChecks: const [],
                profileID: widget.profileID,
                myCars: carsResult.cars,
                userEmail: widget.userEmail,
                userLastName: widget.userLastName,
                currentIndex: widget.currentIndex,
                userName: widget.userName,
                costs: widget.costs,
                date: widget.date,
                itemsNumber: widget.itemsNumber,
                liters: widget.liters,
                petrolName: widget.petrolName,
              );
            }
          else {
            return const Login();
          }
        }
      },
    );
  }
}

