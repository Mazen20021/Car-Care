import 'package:carcare/Pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/nav_button.dart';
import '../Config/constants.dart';
import 'add_new_car.dart';

class CarNotSelectedPage extends StatefulWidget {
  final String userName;
  final int currentIndex;
  const CarNotSelectedPage(
      {required this.userName, required this.currentIndex, super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarNotSelectedPage();
  }
}

class _CarNotSelectedPage extends State<CarNotSelectedPage> {
  final bool _isSub = false;
  final List<String> imagesPath = List<String>.empty(growable: true);

  int carIndex = 0;
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imagesPath.add("assets/cars/Coupe.png");
    imagesPath.add("assets/cars/Hatchback.png");
    imagesPath.add("assets/cars/Sedan.png");
    imagesPath.add("assets/cars/SUV.png");
    setState(() {
      _isExpanded1 = true;
      _isExpanded2 = true;
    });
    Screen.setSize(context);
    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const AddNewCar()),
                  );
                },
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.30,
                      child: SizedBox(
                          width: Width.xxl(),
                          height: Screen.size.height * 0.25,
                          child: Transform.translate(
                            offset: const Offset(75, 0),
                            child: const Image(
                              image: AssetImage("assets/cover.png"),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                            offset: const Offset(50, 30),
                            child: Text("Click To Add Car",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    color: MainColors.white,
                                    fontSize: Fonts.xl(),
                                    shadows: [
                                      const Shadow(
                                          color: MainColors.black,
                                          blurRadius: 25,
                                          offset: Offset(0, 2))
                                    ]))),
                        Container(
                          width: Screen.size.width,
                          height: Screen.size.height * 0.5,
                          alignment: Alignment.centerLeft,
                          child: Transform.translate(
                            offset:  Offset(Width.x2s(), -Height.s2m()),
                            child: Transform.scale(
                              scale: 1.25, // Zoom in the image by 1.5x
                              child: const Image(
                                image: AssetImage("assets/cars/NoCar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            GestureDetector(
                                child: Transform.translate(
                                    offset:  Offset(Width.s2m(), -Height.md()),
                                    child: Text("View online reports",
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold,
                                            color: MainColors.primary
                                                .withOpacity(0.5),
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: MainColors.primary,
                                            fontSize: Fonts.sm())))),
                            GestureDetector(
                                child: Transform.translate(
                                    offset:  Offset(Width.m2d(), -Height.md()),
                                    child: Text("View check log",
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold,
                                            color: MainColors.primary
                                                .withOpacity(0.5),
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: MainColors.primary,
                                            fontSize: Fonts.sm())))),
                          ],
                        ),
                        const SizedBox(height: 2,),
                        Row(
                          children: [
                            Transform.translate(
                              offset:  Offset(Width.xs(), -Height.md()),
                              child: Container(
                                width: Width.m4d(),
                                height: ButtonHeights.s2m(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: const AssetImage(
                                        "assets/fuelMeter.png"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      MainColors.primary.withOpacity(0.85), // Apply the same color as the container
                                      BlendMode.srcATop, // Blends the color with the image
                                    ),
                                  ),
                                ),
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
                                          child: Container(
                                        width: ButtonWidth.s3m(),
                                        height: ButtonHeights.s3m(),
                                        decoration: BoxDecoration(
                                          color: MainColors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.add,
                                            color: MainColors.primary.withOpacity(0.5)),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset:  Offset(Width.xs_2(), -Height.md()),
                              child: Container(
                                width: ButtonWidth.x3_1l(),
                                height: ButtonHeights.s2m(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image:
                                        const AssetImage("assets/repair.png"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      MainColors.primary.withOpacity(
                                          0.85), // Apply the same color as the container
                                      BlendMode
                                          .srcATop, // Blends the color with the image
                                    ),
                                  ),
                                ),
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
                                      GestureDetector(
                                          child: Container(
                                            width: ButtonWidth.s3m(),
                                            height: ButtonHeights.s3m(),
                                        decoration: BoxDecoration(
                                            color: MainColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(Icons.handyman_rounded,
                                            color: MainColors.primary
                                                .withOpacity(0.5)),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset:  Offset(Width.x4s(), -Height.s8m()),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 12, 21, 52)),
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
                                            color: const Color.fromARGB(
                                                255, 12, 21, 52),
                                            fontSize: Fonts.sm())),
                                     SizedBox(width: Width.md()),
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
                                  height: _isExpanded1 ? (60) : 0,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: List.generate(1, (index) {
                                      return ListTile(
                                          title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Row(children: [
                                              Transform.translate(
                                                  offset: const Offset(0, -30),
                                                  child: Text(
                                                      "Add car to see upcoming checks",
                                                      style: GoogleFonts.rubik(
                                                          fontWeight: FontWeight.bold,
                                                          color: MainColors.black,
                                                          fontSize: Fonts.sm()))),
                                              const SizedBox(width: 5),
                                              Transform.translate(
                                                  offset: const Offset(0, -30),
                                                  child: GestureDetector(
                                                      child: Text("Add Car",
                                                          style: GoogleFonts.rubik(
                                                              fontWeight: FontWeight.bold,
                                                              color: MainColors.primary,
                                                              fontSize: Fonts.sm()))))
                                            ])
                                          ]));
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset:  Offset(Width.x4s(), -Height.s7m()),
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
                                      height: ButtonWidth.s3m(),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 12, 21, 52)),
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
                                            color: const Color.fromARGB(
                                                255, 12, 21, 52),
                                            fontSize: Fonts.sm())),
                                    SizedBox(width: Width.md()),
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
                                  height: _isExpanded2
                                      ? (60)
                                      : 0, // Adjust the height as needed
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: List.generate(1, (index) {
                                      return ListTile(
                                        title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [
                                                Transform.translate(
                                                    offset:
                                                        const Offset(0, -30),
                                                    child: Text(
                                                        "Add car to see upcoming events",
                                                        style:
                                                            GoogleFonts.rubik(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    MainColors
                                                                        .black,
                                                                fontSize:
                                                                    Fonts.sm()))),
                                                const SizedBox(width: 5),
                                                Transform.translate(
                                                    offset:
                                                        const Offset(0, -30),
                                                    child: GestureDetector(
                                                        child: Text("Add Car",
                                                            style: GoogleFonts.rubik(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: MainColors
                                                                    .primary,
                                                                fontSize:
                                                                    Fonts.sm()))))
                                              ])
                                            ]),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ])),
      bottomSheet: Container(
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                                 userName:widget.userName,
                                isSub: _isSub
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
    );
  }
}
