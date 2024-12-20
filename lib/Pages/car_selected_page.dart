import 'package:carcare/Pages/car_repair_page.dart';
import 'package:carcare/Pages/settings_page.dart';
import 'package:carcare/PopUps/record_odometer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/nav_button.dart';
import '../Config/constants.dart';
import '../Config/repair_list_data.dart';
import '../PopUps/edit_current_car.dart';
import '../Services/car_api.dart';
import '../Services/repair_api.dart';
import 'car_list_page.dart';
import 'gas_tracking_page.dart';

class CarSelectedPage extends StatefulWidget {
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
  const CarSelectedPage(
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
        super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarSelectedPage();
  }
}

class _CarSelectedPage extends State<CarSelectedPage> {
  final bool _isSub = false;

  final List<String> imagesPath = List<String>.empty(growable: true);
  late final PageController _pageController;
  int carIndex = 0;
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  List<RepairItem> repairDataList = [];
  double itemIndex = 50;
  int pressedIndex = 0;

  void addRepairColumn() {
    setState(() {
      for(int i = 0 ; i < widget.upComingChecks.length; i++)
      {
        itemIndex += 28;
        repairDataList.add(
          RepairItem(
            name: widget.upComingChecks[i].name,
            id:  widget.upComingChecks[i].id,
            profileId: widget.profileID,
            reminderKm:  widget.upComingChecks[i].reminderKm,
          ),
        );
      }
      _isExpanded1 = repairDataList.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    carIndex = widget.currentIndex;
    _pageController =
        PageController(viewportFraction: 2.0, initialPage: widget.currentIndex);
    loadMyCars();
    addRepairColumn();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
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
    Screen.setSize(context);
    return Scaffold(
      body: Flexible(
          flex:  10,
          fit: FlexFit.loose,
          child: SingleChildScrollView(
          physics: (_isExpanded1 || _isExpanded2)
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Column(children: [
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
                !_isSub
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
                  car: widget.myCars[carIndex],
                  carName: widget.myCars[carIndex].make,
                  carModel: widget.myCars[carIndex].model,
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
                          Text(widget.myCars[carIndex].make,
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
                          Text("${widget.myCars[carIndex].movedDistance} KM",
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
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: imagesPath.length,
                        onPageChanged: (index) {
                          setState(() {
                            carIndex =
                                index; // Update carIndex when page changes
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
                )),
            const SizedBox(height: 360),
            Transform.translate(
                offset:  Offset(Width.sm(), -Height.lg()),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => print("i am in online repo"),
                      child: Text(
                        "View online reports",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: MainColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: MainColors.primary,
                          fontSize: Fonts.sm(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 100),
                    GestureDetector(
                      onTap: () {
                        print("i am in check log");
                      },
                      child: Text(
                        "View check log",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: MainColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: MainColors.primary,
                          fontSize: Fonts.sm(),
                        ),
                      ),
                    ),
                  ],
                )),
            Transform.translate(
                offset: const Offset(20, -360),
                child: Row(
                  children: [
                    Container(
                      width: ButtonWidth.x4l(),
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
                            image: const AssetImage("assets/fuelMeter.png"),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Record Odometer",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    color: MainColors.white,
                                    fontSize: Fonts.sm())),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        RecordOdometer(
                                          repairItems: [],
                                          upComingChecks: widget.upComingChecks,
                                          profileID: widget.profileID,
                                          myCars: widget.myCars,
                                          userEmail: widget.userEmail ,
                                          userLastName: widget.userLastName ,
                                          userName: widget.userName,
                                          costs: widget.costs,
                                          date: widget.date,
                                          itemsNumber:
                                          widget.itemsNumber,
                                          liters: widget.liters,
                                          petrolName:
                                          widget.petrolName,
                                          carIndex: widget.currentIndex,
                                          addNewRecord: true,
                                          hasLowerImage: false,
                                          hasLowerText: false,
                                          lowerText:  "",
                                          hasUpperImage: true,
                                          headerText: "Add kilometers",
                                          hasTextField: true,
                                          leftButtonText: "Skip",
                                          lowerImage: "assets/manWithCar.png",
                                          numberOfTextFields: 0,
                                          rightButtonText: "Submit",
                                          upperImage: "assets/whiteCar.png",
                                        )
                                    ),
                                  );
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
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarRepairPage(
                                repairItems: const [],
                                upComingChecks: widget.upComingChecks,
                                profileID: widget.profileID,
                                myCars: widget.myCars,
                                userEmail: widget.userEmail ,
                                userLastName: widget.userLastName ,
                                carIndex: carIndex,
                                costs: widget.costs,
                                date:widget.date ,
                                itemsNumber: widget.itemsNumber,
                                liters: widget.liters,
                                petrolName: widget.petrolName,
                                userName: widget.userName,
                              )),
                        );
                      },
                      child: Container(
                        width: ButtonWidth.x3_1l(),
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
                              image: const AssetImage("assets/repair.png"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                MainColors.primaryDark.withOpacity(0.9),
                                // Apply the same color as the container
                                BlendMode
                                    .srcATop, // Blends the color with the image
                              ),
                            )),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("New car repair",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.bold,
                                      color: MainColors.white,
                                      fontSize: Fonts.sm())),
                              const SizedBox(width: 20),
                              Container(
                                width: ButtonWidth.s3m(),
                                height: ButtonWidth.s3m(),
                                decoration: BoxDecoration(
                                    color: MainColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.handyman_rounded,
                                    color: MainColors.primaryDark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Transform.translate(
              offset:  Offset(Width.x7s(), -Height.m4d()),
              child: Container(
                width: Screen.size.width * 0.9,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: MainColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          width: ButtonWidth.s3m(),
                          height: ButtonHeights.s3m(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 12, 21, 52)),
                          child: const Icon(
                            Icons.handyman_rounded,
                            color: MainColors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("Upcoming Checks",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 12, 21, 52),
                                fontSize: Fonts.sm())),
                        const SizedBox(width: 106),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded1 = !_isExpanded1;
                            });
                          },
                          icon: Icon(
                            !_isExpanded1
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_up_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        height: _isExpanded1 ? (repairDataList.isEmpty ? 0 : itemIndex) : 0,
                        child: ListView.builder(
                          itemCount: repairDataList.length,
                          itemBuilder: (context, index) {
                            RepairItem item = repairDataList[index];
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
                                  child:  Column(children: [
                                    Container(
                                        width: Screen.size.width,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: MainColors.primary.withOpacity(0.7)), // Red border
                                          borderRadius: BorderRadius.circular(CustomRadius.xl()),
                                        ),
                                        child: Column(children: [
                                          const SizedBox(height: 10),
                                          Icon(Icons.handyman_rounded,size: 50,color: MainColors.primary.withOpacity(0.7)),
                                          const Text(""),
                                          const Text(""),
                                          const Text(" Km Left")
                                        ],)
                                    ),
                                  ],),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset:  Offset(Width.x7s(), -Height.m3_1d()),
              child: Container(
                width: Screen.size.width * 0.9,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: MainColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          width: ButtonWidth.s3m(),
                          height: ButtonHeights.s3m(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 12, 21, 52)),
                          child: const Icon(
                            Icons.calendar_month_rounded,
                            color: MainColors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("Upcoming Events",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 12, 21, 52),
                                fontSize: Fonts.sm())),
                        const SizedBox(width: 108),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded2 = !_isExpanded2;
                            });
                          },
                          icon: Icon(
                            !_isExpanded2
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_up_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      height: _isExpanded2 ? (250) : 0,
                      // Adjust the height as needed
                      child: ListView(
                        children: List.generate(5, (index) {
                          return ListTile(
                            title: Text("Item ${index + 1}"),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]))),
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
                      onPressed: () {},
                      title: "Dashboard",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.directions_car_filled,
                      currentColor: const Color.fromARGB(255, 42, 87, 208),
                      currentBorderColor:
                      const Color.fromARGB(255, 42, 87, 208),
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
                                    isSub: _isSub,
                                    carIndex: carIndex,
                                    costs: widget.costs,
                                    date:widget.date ,
                                    itemsNumber: 0,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName, currentIndex: widget.currentIndex,
                                  )),
                        );
                      },
                      title: "Car List",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.ac_unit_outlined,
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
                                  CarGasPage(
                                    upComingChecks: widget.upComingChecks,
                                    profileID: widget.profileID,
                                    myCars: widget.myCars,
                                    userLastName: widget.userLastName,
                                    userEmail: widget.userEmail,
                                    userName:widget.userName,
                                    isSub: _isSub,
                                    carIndex: carIndex,
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
                                      isSub: _isSub,
                                      carIndex: carIndex,
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
