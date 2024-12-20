import 'package:carcare/Pages/add_gas_page.dart';
import 'package:carcare/Pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/nav_button.dart';
import '../Config/constants.dart';
import '../Config/repair_list_data.dart';
import '../Services/car_api.dart';
import '../Services/repair_api.dart';
import 'car_list_page.dart';
import 'car_selected_page.dart';

class CarGasPage extends StatefulWidget {
  final int carIndex;
  final String userName;
  final bool isSub;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final String userLastName;
  final String userEmail;
  final VoidCallback onPressed;
  final List<Cars> myCars;
  final String profileID;
  final List<RepairType> upComingChecks;
  const CarGasPage({
    required this.carIndex ,
    required this.userName ,
    required this.isSub,
    required this.costs,
    required this.date,
    required this.liters,
    required this.petrolName,
    required this.itemsNumber,
    required this.onPressed,
    required this.userEmail , required this.userLastName,
    required this.myCars,
    required this.profileID,
    required this.upComingChecks,
    super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarRepairPage();
  }
}

class _CarRepairPage extends State<CarGasPage> {
  final List<String> imagesPath = List<String>.empty(growable: true);
  late final PageController _pageController;
  bool _isExpanded1 = false;
  List<GasItem> gasDataList = [];
  double itemIndex = 50;
  int pressedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(viewportFraction: 2.0, initialPage: widget.carIndex);
    addRepairRow();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void addRepairRow() {
    setState(() {
      for(int i =0 ; i<widget.itemsNumber;i++)
        {
          itemIndex += 28;
          gasDataList.add(
            GasItem(
              name: widget.petrolName,
              date: widget.date,
              km: widget.liters,
              cost: widget.costs,
            ),
          );
        }
      _isExpanded1 = gasDataList.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    imagesPath.add("assets/cars/Coupe.png");
    imagesPath.add("assets/cars/Hatchback.png");
    imagesPath.add("assets/cars/Sedan.png");
    imagesPath.add("assets/cars/SUV.png");
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CarSelectedPage(
                                upComingChecks: widget.upComingChecks,
                                profileID: widget.profileID,
                                myCars: widget.myCars,
                                userEmail: widget.userEmail ,
                                userLastName: widget.userLastName ,
                                userName:widget.userName,
                                currentIndex: widget.carIndex,
                                costs: widget.costs,
                                date:widget.date ,
                                itemsNumber: widget.itemsNumber,
                                liters: widget.liters,
                                petrolName: widget.petrolName,
                              )),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              SizedBox(width: Width.s7m()),
              Text(
                "Gas Tracker",
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.xl(),
                ),
              ),
            ],
          ),
        ),
        body: Column(children: [
              Stack(
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
                        Text("Name",
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
                        Text("Data",
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
                    height: 185,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: imagesPath.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: Screen.size.width,
                            // Adjust width to your preference
                            child: Transform.translate(
                              offset: const Offset(0, 43),
                              child: Transform.scale(
                                  scale: 0.65,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    // Adjust how the image fits in the box
                                    child: Image.asset(
                                        imagesPath[widget.carIndex]),
                                  )),
                            ));
                      },
                    ),
                  ),
                ],
              ),
              Transform.translate(
                  offset:  Offset(0, Height.x2s()),
                  child: Container(
                    width: Screen.size.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: MainColors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      Container(
                      width: Width.x3xl(),
                      height: ButtonHeights.md(),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: MainColors.grey,
                                blurRadius: 20,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: MainColors.primarySemiLight,
                          image: DecorationImage(
                            image: const AssetImage("assets/gasPic.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              MainColors.primary.withOpacity(0.9),
                              // Apply the same color as the container
                              BlendMode.srcATop, // Blends the color with the image
                            ),
                          )),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Add New Gas Record",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    color: MainColors.white,
                                    fontSize: Fonts.md())),
                             SizedBox(width:Width.m2d()),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: ButtonWidth.s2m(),
                                  height: ButtonHeights.s2m(),
                                  decoration: BoxDecoration(
                                      color: MainColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.add,
                                      color: MainColors.primary),
                                )),
                          ],
                        ),
                      ),
                    ), SizedBox(width: Width.x2s()),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  CarADDGasPage(
                                  upComingChecks: widget.upComingChecks,
                                  profileID: widget.profileID,
                                  myCars: widget.myCars,
                                  userEmail: widget.userEmail ,
                                  userLastName: widget.userLastName ,
                                  carIndex: widget.carIndex,
                                  userName: "Mazen",
                                  costs: widget.costs,
                                  date:widget.date,
                                  itemsNumber: widget.itemsNumber,
                                  liters: widget.liters,
                                  petrolName: widget.petrolName,
                                  onPressed: (){},
                                  isSub: widget.isSub,
                                )),
                          );
                        }
                    ),
                          Transform.translate(offset:  Offset(-Width.x3s(), Height.s2m()),
                              child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("Gas History",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.bold,
                                      color: MainColors.listBackground,
                                      fontSize: Fonts.m2d())),
                            ],
                          )),
                        Transform.translate(offset:  Offset(-Width.x3s(), Height.s3_1m()),
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              height: _isExpanded1 ? (gasDataList.isEmpty ? 0 : itemIndex) : 0,
                              child: ListView.builder(
                                itemCount: gasDataList.length,
                                itemBuilder: (context, index) {
                                  GasItem item = gasDataList[index];
                                  return ListTile(
                                    title: Container(
                                      decoration:  const BoxDecoration(
                                        color: MainColors.listBackground,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(3, 0),
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  padding: const EdgeInsets.all(0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: MainColors.borderLight,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(width: 5),
                                                      Text(item.name, style: GoogleFonts.rubik(fontSize: Fonts.sm())),
                                                      const SizedBox(width: 10),
                                                      const Icon(Icons.calendar_month, size: 15),
                                                      const SizedBox(width: 5),
                                                      Text(item.date, style: GoogleFonts.rubik(fontSize: Fonts.sm())),
                                                      const SizedBox(width: 10),
                                                      const Icon(Icons.speed_rounded, size: 15),
                                                      const SizedBox(width: 5),
                                                      Text(item.km, style: GoogleFonts.rubik(fontSize: Fonts.sm())),
                                                      const SizedBox(width: 10),
                                                      const Icon(Icons.monetization_on_rounded, size: 15),
                                                      const SizedBox(width: 5),
                                                      Text(item.cost, style: GoogleFonts.rubik(fontSize: Fonts.sm())),
                                                      Transform.translate(offset: const Offset(-8, 0),child:
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.delete_forever,
                                                          size: 15,
                                                          color: MainColors.danger,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            gasDataList.removeAt(index);
                                                          });
                                                        },
                                                      ),
                                                      )],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                )]),
                  )
              )
            ]),
      bottomSheet: Container(
        width: Screen.size.width,
        height: Screen.size.height * 0.1,
        decoration: BoxDecoration(
          color: MainColors.navShadow,
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
                              builder: (context) =>
                                  CarSelectedPage(
                                    upComingChecks: widget.upComingChecks,
                                    profileID: widget.profileID,
                                    myCars: widget.myCars,
                                    userEmail: widget.userEmail ,
                                    userLastName: widget.userLastName ,
                                    userName:widget.userName,
                                    currentIndex: widget.carIndex,
                                    costs: widget.costs,
                                    date:widget.date ,
                                    itemsNumber: widget.itemsNumber,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                  )),
                        );
                      },
                      title: "Dashboard",
                      width: ButtonWidth.m2d(),
                      height: ButtonHeights.s3_1m(),
                      buttonIcon: Icons.directions_car_filled,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: NavButton(
                      hasIcon: false,
                      buttonImage: "assets/customIcons/garage.png",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarList(
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
                                    itemsNumber: 0,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                    currentIndex: widget.carIndex,
                                  )),
                        );
                      },
                      title: "Car List",
                      width: ButtonWidth.m2d(),
                      height: ButtonHeights.s3_1m(),
                      buttonIcon: Icons.ac_unit_outlined,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: NavButton(
                      buttonImage: "",
                      hasIcon: true,
                      onPressed: () {},
                      title: "Add Gas",
                      width: ButtonWidth.m2d(),
                      height: ButtonHeights.s3_1m(),
                      buttonIcon: Icons.local_gas_station_rounded,
                      currentColor: const Color.fromARGB(255, 42, 87, 208),
                      currentBorderColor: const Color.fromARGB(255, 42, 87, 208),
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
                                    userEmail: widget.userEmail ,
                                    userLastName: widget.userLastName ,
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
                      width: ButtonWidth.m2d(),
                      height: ButtonHeights.s3_1m(),
                      buttonIcon: Icons.settings,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
