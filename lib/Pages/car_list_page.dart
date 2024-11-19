import 'package:carcare/Pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/custom_button.dart';
import '../Components/nav_button.dart';
import '../Config/constants.dart';
import '../PopUps/edit_current_car.dart';
import '../Services/car_api.dart';
import '../Services/repair_api.dart';
import 'car_selected_page.dart';
import 'gas_tracking_page.dart';

class CarList extends StatefulWidget{
  final String userName;
  final int currentIndex;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final String userLastName;
  final String userEmail;
  final List<Cars> myCars;
  final String profileID;
  final List<RepairType> upComingChecks;
  final bool isSub ;
  final int carIndex;
  const CarList(
      {required this.userName,
        required this.currentIndex,
        required this.costs,
        required this.date,
        required this.liters,
        required this.petrolName,
        required this.itemsNumber,
        required this.userEmail,
        required this.userLastName,
        required this.myCars,
        required this.profileID,
        required this.upComingChecks,
        required this.isSub,
        required this.carIndex,
        super.key});

  @override
  State<StatefulWidget> createState() {
   return _CarList();
  }

}
class _CarList extends State<CarList>
{
  final List<String> imagesPath = List<String>.empty(growable: true);
  void loadMyCars()
  {
    if (widget.myCars.isNotEmpty) {
      for (int i = 0; i < widget.myCars.length; i++) {
        if (widget.myCars[i].carClass == "1") {
          imagesPath.add("assets/cars/SUV.png");
        } else if (widget.myCars[i].carClass == "2") {
          imagesPath.add("assets/cars/Sedan.png");
        } else if (widget.myCars[i].carClass == "3") {
          imagesPath.add("assets/cars/Coupe.png");
        } else {
          imagesPath.add("assets/cars/Hatchback.png");
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
          const SizedBox(height: 48),
        Row(
          children: [
            const SizedBox(width: 20),
            Text(
              "Welcome Back,",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontSize: Fonts.lg(),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.userName,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: MainColors.primary,
                fontSize: Fonts.lg(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 20),
            !widget.isSub
                ? Text(
              "Free Trial Plan",
              style: GoogleFonts.rubik(
                color: const Color.fromARGB(255, 182, 182, 182),
                fontSize: Fonts.sm(),
              ),
            )
                : const Text("")
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Width.xxl(),
              height: ButtonHeights.sm(),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: MainColors.grey,
                        blurRadius: 20,
                        offset: Offset(0, 0))
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: MainColors.primary,
                  image: DecorationImage(
                    image: const AssetImage("assets/cover.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      MainColors.primary.withOpacity(0.95),
                      // Apply the same color as the container
                      BlendMode
                          .srcATop, // Blends the color with the image
                    ),
                  )),
              child: Center(
                child: Row(
                  children: [
                    Column(children: [
                      SizedBox(height: 10),
                      Text("Add New Car",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              color: MainColors.white,
                              fontSize: Fonts.sm())),
                      Text("lets add a new car to your collection",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              color: MainColors.white,
                              fontSize: Fonts.sm())),
                    ],),

                     SizedBox(width: Width.l1_2g()),
                    GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          width: ButtonWidth.s3m(),
                          height: ButtonHeights.s3m(),
                          decoration: BoxDecoration(
                              color: MainColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.add,
                              color: MainColors.primary),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditCars(
                          upComingChecks: widget.upComingChecks,
                          currentIndex: widget.currentIndex,
                          costs: widget.costs,
                          date: widget.date,
                          itemsNumber: widget.itemsNumber,
                          liters: widget.liters,
                          petrolName: widget.petrolName,
                          userName: widget.userName,
                          userEmail: widget.userEmail,
                          userLastName: widget.userLastName,
                          myCars: widget.myCars,
                          car: widget.myCars[widget.carIndex],
                          carName: widget.myCars[widget.carIndex].make,
                          carModel: widget.myCars[widget.carIndex].model,
                          profileID: widget.profileID,
                        )
                ),
              )
            },
            child: Stack(
              children: [
                Opacity(
                    opacity: 1,
                    child: SizedBox(
                        width: Width.xxl(),
                        height: Screen.size.height * 0.25,
                        child: Transform.translate(
                          offset: const Offset(75, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: MainColors.primary,
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image: AssetImage("assets/cover.png"),
                                opacity: 0.1,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ))),
                Transform.translate(
                  offset: const Offset(180, 20),
                  child: Row(
                    children: [
                      Text(widget.myCars[widget.carIndex].make,
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              color: MainColors.white,
                              fontSize: Fonts.xl(),
                              shadows: [
                                const Shadow(
                                    color: MainColors.black,
                                    blurRadius: 25,
                                    offset: Offset(0, 2))
                              ])),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.error_rounded,
                        color: MainColors.white,
                        size: Width.xs(),
                      ),
                      const SizedBox(width: 5),
                      Text("${widget.myCars[widget.carIndex].movedDistance} KM",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              color: MainColors.white,
                              fontSize: Fonts.sm(),
                              shadows: [
                                const Shadow(
                                    color: MainColors.black,
                                    blurRadius: 25,
                                    offset: Offset(0, 2))
                              ]))
                    ],
                  ),
                ),
                SizedBox(
                  height: Height.s7m(),
                  child: PageView.builder(
                   // controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: imagesPath.length,
                    onPageChanged: (index) {
                      setState(() {
                       // carIndex =index; // Update carIndex when page changes
                      });
                    },
                    itemBuilder: (context, index) => SizedBox(
                      width: Screen.size.width, // Adjust width to your preference
                      child: Transform.translate(
                        offset:  Offset(0, Height.x2_2s()),
                        child: Transform.scale(
                          scale: 0.7,
                          child: FittedBox(
                            fit: BoxFit.cover, // Adjust how the image fits in the box
                            child: Image.asset(imagesPath[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ))]),
        bottomSheet:Flexible(
          flex:  10,
          fit: FlexFit.loose,
          child:  Container(
            width: Screen.size.width,
            height: Screen.size.height * 0.1,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 250, 251, 252),
              boxShadow: [
                BoxShadow(
                  color: MainColors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, -2), // Shadow direction: towards the top
                ),
              ],
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: MainColors.white,
              title: Padding(
                padding:  const EdgeInsets.fromLTRB(3, 10, 20, 10),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center, // Center the content vertically
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: NavButton(
                          hasIcon: true,
                          buttonImage: "",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarSelectedPage(
                                    upComingChecks: widget.upComingChecks,
                                    profileID: widget.profileID,
                                    myCars: widget.myCars,
                                    userEmail: widget.userEmail ,
                                    userLastName: widget.userLastName ,
                                    userName: widget.userName,
                                    currentIndex: widget.carIndex,
                                    costs: widget.costs,
                                    date: widget.date,
                                    itemsNumber: widget.itemsNumber,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                  )),
                            );
                          },
                          title: "Dashboard",
                          width: 65,
                          height: 45,
                          buttonIcon: Icons.directions_car_filled,
                          currentColor: const Color.fromARGB(255, 12, 21, 52),
                          currentBorderColor: MainColors.white,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: NavButton(
                          hasIcon: false,
                          buttonImage: "assets/customIcons/garage.png",
                          onPressed: () {},
                          title: "Car List",
                          width: 65,
                          height: 45,
                          buttonIcon: Icons.ac_unit_outlined,
                          currentColor: const Color.fromARGB(255, 42, 87, 208),
                          currentBorderColor:
                          const Color.fromARGB(255, 42, 87, 208),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: NavButton(
                          buttonImage: "",
                          hasIcon: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CarGasPage(
                                        upComingChecks: widget.upComingChecks,
                                        profileID: widget.profileID,
                                        myCars: widget.myCars,
                                        userLastName: widget.userLastName,
                                        userEmail: widget.userEmail,
                                        userName:widget.userName,
                                        isSub: widget.isSub,
                                        carIndex: widget.carIndex,
                                        onPressed: (){},
                                        costs: widget.costs,
                                        date:widget.date ,
                                        itemsNumber: 0,
                                        liters: widget.liters,
                                        petrolName: widget.petrolName,
                                      )),
                            );
                          },
                          title: "Add Gas",
                          width: 65,
                          height: 45,
                          buttonIcon: Icons.local_gas_station_rounded,
                          currentColor: const Color.fromARGB(255, 12, 21, 52),
                          currentBorderColor: MainColors.white,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: NavButton(
                          buttonImage: "",
                          hasIcon: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Settings(
                                        upComingChecks: widget.upComingChecks,
                                        profileID: widget.profileID,
                                        myCars: widget.myCars,
                                        userLastName: widget.userLastName,
                                        userEmail: widget.userEmail,
                                        userName:widget.userName,
                                        isSub: widget.isSub,
                                        carIndex: widget.carIndex,
                                        costs: widget.costs,
                                        date:widget.date ,
                                        itemsNumber: widget.itemsNumber,
                                        liters: widget.liters,
                                        petrolName: widget.petrolName,
                                      )),
                            );
                          },
                          title: "Settings",
                          width: 65,
                          height: 45,
                          buttonIcon: Icons.settings,
                          currentColor: const Color.fromARGB(255, 12, 21, 52),
                          currentBorderColor: MainColors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }


Widget buildCarImage(String imagePath, Size screenSize) {
  return Container(
      width: screenSize.width, // Occupy full width
      height: screenSize.height * 0.68, // Adjust to desired height
      alignment: Alignment.center,
      child: Transform.translate(
          offset: const Offset(10, -140),
          child: Transform.scale(
            scale: 0.65,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          )));
}
}
