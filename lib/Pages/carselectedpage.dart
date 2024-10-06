import 'package:carcare/Pages/carrepairpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/BottomButtons.dart';
import '../Config/constants.dart';

class CarSelectedPage extends StatefulWidget {
  final String userName;
  final int currentIndex;

  const CarSelectedPage(
      {required this.userName, required this.currentIndex, super.key});

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

  @override
  void initState() {
    super.initState();
    carIndex = widget.currentIndex;
    _pageController = PageController(viewportFraction: 2.0, initialPage: widget.currentIndex);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imagesPath.add("assets/cars/Coupe.png");
    imagesPath.add("assets/cars/Hatchback.png");
    imagesPath.add("assets/cars/Sedan.png");
    imagesPath.add("assets/cars/SUV.png");
    Screen.setSize(context);
    return Scaffold(
      body: SingleChildScrollView(
         physics: (_isExpanded1||_isExpanded2) ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: Column(children: [
          const SizedBox(height: 48),
          Row(
          children: [
            const SizedBox(width: 20),
            Text(
              "Welcome Back,",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontSize: Fonts.sm(),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.userName,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: MainColors.primary,
                fontSize: Fonts.sm(),
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
               onTap: (){print("j");},
               child:
           Stack(
              children: [
                Opacity(
                    opacity: 1,
                    child: SizedBox(
                        width: Screen.size.width * 0.9,
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
                              fontSize: Fonts.md(),
                              shadows: [
                                const Shadow(
                                    color: MainColors.black,
                                    blurRadius: 25,
                                    offset: Offset(0, 2))
                              ])),
                      const SizedBox(width: 25),
                      Icon(
                        Icons.error_rounded,
                        color: MainColors.white,
                        size: Width.xs(),
                      ),
                      const SizedBox(width: 10),
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
                  height: 225,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: imagesPath.length,
                    onPageChanged: (index) {
                      setState(() {
                        carIndex = index; // Update carIndex when page changes
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: Screen.size.width, // Adjust width to your preference
                        child:Transform.translate(offset: Offset(0, 50),child:
                        Transform.scale(
                            scale: 0.65,
                            child:
                        FittedBox(
                          fit: BoxFit.cover, // Adjust how the image fits in the box
                          child: Image.asset(imagesPath[index]),
                        )),
                      ));
                    },
                  ),
                ),
              ],
            )),
        const SizedBox(height: 380),
            Transform.translate(offset: Offset(20, -370),child:
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("i am in online repo");
                  },
                    child: Text(
                      "View online reports",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        color: MainColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: MainColors.primary,
                        fontSize: Fonts.xs(),
                      ),
                    ),
                ),
                const SizedBox(width: 65),
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
                        fontSize: Fonts.xs(),
                      ),
                    ),
                  ),

              ],
            )),
          Transform.translate(
              offset: const Offset(15, -360),
              child:
            Row(
          children: [
            Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: MainColors.black ,blurRadius: 10,offset: Offset(0, 2))],
                    borderRadius: BorderRadius.circular(10),
                    color: MainColors.primary,
                    image: DecorationImage(
                      image: const AssetImage("assets/fuelMeter.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        MainColors.primary.withOpacity(0.8),
                        // Apply the same color as the container
                        BlendMode.srcATop, // Blends the color with the image
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
                              fontSize: Fonts.x2s())),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            width: 30,
                            height: 30,
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
            const SizedBox(width: 25),
             InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CarRepairPage(carIndex: carIndex)),
                  );
                },

                child: Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: MainColors.black ,blurRadius: 10,offset: Offset(0, 2))],
                      borderRadius: BorderRadius.circular(10),
                      color: MainColors.primary,
                      image: DecorationImage(
                        image: const AssetImage("assets/repair.png"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          MainColors.primary.withOpacity(0.8),
                          // Apply the same color as the container
                          BlendMode.srcATop, // Blends the color with the image
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
                                fontSize: Fonts.x2s())),
                        const SizedBox(width: 20),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: MainColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.handyman_rounded,
                              color: MainColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
            )
          ],
        )),
        Transform.translate(
          offset: const Offset(3, -340),
          child: Container(
            width: Screen.size.width * 0.94,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 12, 21, 52)),
                      child: const Icon(
                        Icons.handyman_rounded,
                        color: MainColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Upcoming Checks",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 12, 21, 52),
                            fontSize: Fonts.xs())),
                    const SizedBox(width: 100),
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
                  height: _isExpanded1 ? 250 : 0,
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
        Transform.translate(
          offset: const Offset(5, -320),
          child: Container(
            width: Screen.size.width * 0.94,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 12, 21, 52)),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color: MainColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Upcoming Events",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 12, 21, 52),
                            fontSize: Fonts.xs())),
                    const SizedBox(width: 100),
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
                  height: _isExpanded2 ? ( 250) : 0,
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
      ])),
      bottomSheet: Container(
        width: Screen.size.width,
        height: Screen.size.height * 0.1,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 251, 252),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, -2), // Shadow direction: towards the top
            ),
          ],
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // Center the content vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: BottomButtonsClass(
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
                    child: BottomButtonsClass(
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
                    child: BottomButtonsClass(
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
                    child: BottomButtonsClass(
                      buttonImage: "",
                      hasIcon: true,
                      onPressed: () {},
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

  // Helper method to build each car image
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
