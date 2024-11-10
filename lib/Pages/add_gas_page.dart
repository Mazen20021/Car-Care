import 'package:carcare/Components/custom_button.dart';
import 'package:carcare/Pages/gas_tracking_page.dart';
import 'package:carcare/Pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Components/nav_button.dart';
import '../Config/constants.dart';
import '../Config/repair_list_data.dart';
import '../Services/car_api.dart';
import '../Services/repair_api.dart';
import 'car_selected_page.dart';

class CarADDGasPage extends StatefulWidget {
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
  const CarADDGasPage(
      {required this.carIndex,
      required this.userName,
      required this.isSub,
      required this.costs,
      required this.date,
      required this.liters,
      required this.petrolName,
      required this.itemsNumber,
      required this.onPressed,
        required this.myCars,
        required this.userEmail , required this.userLastName,
        required this.profileID,
        required this.upComingChecks,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarRepairPage();
  }
}

class _CarRepairPage extends State<CarADDGasPage> {
  final List<String> imagesPath = List<String>.empty(growable: true);
  late final PageController _pageController;
  List<GasItem> repairDataList = [];
  DateTime? _selectedDate;
  final TextEditingController _setDate = TextEditingController();
  final TextEditingController _gasLiter = TextEditingController();
  final TextEditingController _gasCost = TextEditingController();
  final TextEditingController _currentKM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedValue;
  final List<String> _items = ['95 Petrol', '92 Petrol', '80 Petrol', 'Gas Car'];

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(viewportFraction: 2.0, initialPage: widget.carIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _setDate.text = DateFormat('dd/MM/yyy').format(_selectedDate!);
      });
    }
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
                        builder: (context) => CarGasPage(
                          upComingChecks: widget.upComingChecks,
                          profileID: widget.profileID,
                          myCars: widget.myCars,
                          userEmail: widget.userEmail ,
                          userLastName: widget.userLastName ,
                              userName: widget.userName,
                              isSub: widget.isSub,
                              onPressed: (){},
                              carIndex: widget.carIndex,
                              costs: widget.costs,
                              date: widget.date,
                              itemsNumber: widget.itemsNumber,
                              liters: widget.liters,
                              petrolName: widget.petrolName,
                            )),
                  );
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            SizedBox(width: Width.m4d()),
            Text(
              "Add Gas",
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
                              child: Image.asset(imagesPath[widget.carIndex]),
                            )),
                      ));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        SingleChildScrollView(
          child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              width: Screen.size.width * 0.93,
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                textAlign: TextAlign.left,
                cursorColor: MainColors.black,
                style: GoogleFonts.mada(
                  color: MainColors.black,
                  fontSize: Width.x2s(),
                ),
                controller: _setDate,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month_rounded),
                  labelText: 'Date',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: MainColors.black,
                    fontSize: Width.x2s(),
                  ),
                  hintText: 'Date Of The Gas Supplied',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: MainColors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Choose a date';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 13), // Required for input formatting
            SizedBox(
              width: Screen.size.width * 0.93,
              child: TextFormField(
                textAlign: TextAlign.left,
                cursorColor: MainColors.black,
                style: GoogleFonts.mada(
                  color: MainColors.black,
                  fontSize: Width.x2s(),
                ),
                controller: _gasLiter,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  label: const Text("Gas Liters"),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: MainColors.black,
                    fontSize: Width.x2s(),
                  ),
                  hintText: '0',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: MainColors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the KM Of Repair';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 13), // Required for input formatting
            SizedBox(
              width: Screen.size.width * 0.93,
              child: TextFormField(
                textAlign: TextAlign.left,
                cursorColor: MainColors.black,
                style: GoogleFonts.mada(
                  color: MainColors.black,
                  fontSize: Width.x2s(),
                ),
                controller: _currentKM,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  label: const Text("Current KM"),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: MainColors.black,
                    fontSize: Width.x2s(),
                  ),
                  hintText: 'KM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: MainColors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 13),
            SizedBox(
              width: Screen.size.width * 0.93,
              child: TextFormField(
                textAlign: TextAlign.left,
                cursorColor: MainColors.black,
                style: GoogleFonts.mada(
                  color: MainColors.black,
                  fontSize: Width.x2s(),
                ),
                controller: _gasCost,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  label: const Text("Gas Cost *Optional"),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: MainColors.black,
                    fontSize: Width.x2s(),
                  ),
                  hintText: 'Enter Gas Cost',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: MainColors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.redAccent, width: 2.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 13),
            SizedBox(
              width: Screen.size.width * 0.93,
              // Adjust the width to your preference
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  label: const Text("Gas Model"),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: MainColors.deepPurple, width: 2),
                  ),
                ),
                hint: const Text('Select Gas Model'),
                value: _selectedValue,
                items: _items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Width.x2s(),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue; // Update the selected value
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 5),
            Transform.translate(offset: const Offset(-7, 0),child:
            Row(
              children: [
                CustomButton(
                  width: 160,
                  height: 45,
                  hasGradient: true,
                  gradientColors: const [
                    Color.fromARGB(255, 48, 95, 215),
                    Color.fromARGB(255, 48, 95, 215)
                  ],
                  hasImage: true,
                  imagePath: "assets/image/loginBackground.png",
                  imageOpacity: 0.1,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  normalColor: MainColors.transparent,
                  borderRadius: CustomRadius.sm(),
                  leftPadding: 20,
                  rightPadding: 20,
                  topPadding: 5,
                  bottomPadding: 15,
                  label: "Save",
                  fontSize: Fonts.sm(),
                  textColor: MainColors.white,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CarGasPage(
                                upComingChecks: widget.upComingChecks,
                                profileID: widget.profileID,
                                myCars: widget.myCars,
                                userEmail: widget.userEmail ,
                                userLastName: widget.userLastName ,
                                userName: widget.userName,
                                isSub: widget.isSub,
                                onPressed: (){},
                                carIndex: widget.carIndex,
                                costs: _gasCost.text,
                                date: _setDate.text,
                                itemsNumber: (widget.itemsNumber + 1),
                                liters: _gasLiter.text,
                                petrolName: _selectedValue.toString(),
                              )),
                    );
                  },
                ),
                Transform.translate(
                  offset: const Offset(5, 0),
                  child: CustomButton(
                      width: 150,
                      height: 45,
                      hasGradient: true,
                      gradientColors: const [
                        Color.fromARGB(255, 180, 74, 80),
                        Color.fromARGB(255, 181, 74, 80)
                      ],
                      hasImage: true,
                      imagePath:
                      "assets/image/loginBackground.png",
                      imageOpacity: 0.1,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      normalColor: MainColors.transparent,
                      borderRadius: CustomRadius.sm(),
                      leftPadding: 0,
                      rightPadding: 20,
                      topPadding: 5,
                      bottomPadding: 15,
                      label: "Cancel",
                      fontSize: Fonts.sm(),
                      textColor: MainColors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarGasPage(
                                    upComingChecks: widget.upComingChecks,
                                    profileID: widget.profileID,
                                    myCars: widget.myCars,
                                    userEmail: widget.userEmail ,
                                    userLastName: widget.userLastName ,
                                    userName: widget.userName,
                                    carIndex: widget.carIndex,
                                    onPressed: (){},
                                    isSub: widget.isSub,
                                    costs: widget.costs,
                                    date: widget.date,
                                    itemsNumber: widget.itemsNumber,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                  )),
                        );
                      }),
                )
              ],
            )
            )]),
        ),
        )]),
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
            padding: const EdgeInsets.fromLTRB(3, 10, 20, 10),
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
                      onPressed: () {},
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
                              builder: (context) => Settings(
                                upComingChecks: widget.upComingChecks,
                                profileID: widget.profileID,
                                myCars: widget.myCars,
                                userEmail: widget.userEmail ,
                                userLastName: widget.userLastName ,
                                    userName: widget.userName,
                                    isSub: widget.isSub,
                                    carIndex: widget.carIndex,
                                    costs: widget.costs,
                                    date: widget.date,
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
