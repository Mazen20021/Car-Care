import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/custom_button.dart';
import '../Config/constants.dart';
import '../Pages/car_selected_page.dart';
import '../Services/car_api.dart';
import '../Services/repair_api.dart';


class RecordOdometer extends StatefulWidget {
  final String userName;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final int carIndex;
  final String headerText;
  final String upperImage;
  final String lowerImage;
  final String lowerText;
  final bool hasUpperImage;
  final bool hasLowerImage;
  final bool hasTextField;
  final bool hasLowerText;
  final bool addNewRecord;
  final int numberOfTextFields;
  final String rightButtonText;
  final String leftButtonText;
  final String userLastName;
  final String userEmail;
  final List<Cars> myCars;
  final String profileID;
  final List<RepairType> upComingChecks;
  final List<String> repairItems;
  const RecordOdometer(
      {required this.userName,
        required this.profileID,
        required this.carIndex,
        required this.costs,
        required this.date,
        required this.liters,
        required this.petrolName,
        required this.itemsNumber,
        this.headerText = "",
        this.upperImage = "",
        this.lowerImage = "",
        this.addNewRecord = false,
        this.hasLowerImage = false,
        this.hasLowerText = false,
        this.hasTextField = false,
        this.hasUpperImage = false,
        this.lowerText = "",
        this.numberOfTextFields = 0,
        this.leftButtonText = "Cancel",
        this.rightButtonText = "Submit",
        required this.userEmail , required this.userLastName,
        required this.myCars,
        required this.upComingChecks,
        required this.repairItems,
        super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopUpDialogs();
  }
}

class _PopUpDialogs extends State<RecordOdometer> {
  static final TextEditingController _carMake = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _selectedCar;
  late final List<Cars> _carList;

  @override
  void initState() {
    _carList = widget.myCars;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
                child:Container(
                    width: Screen.size.width,
                    height: Screen.size.height,
                    decoration: BoxDecoration(
                      color: MainColors.primary.withOpacity(0.8),
                    ),
                    child: Column(children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            widget.headerText,
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: MainColors.white,
                                fontSize: Fonts.xl(),
                                decoration: TextDecoration.none),
                          ),
                          const Spacer(flex: 5),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomButton(
                                width: ButtonWidth.s2m(),
                                height: ButtonHeights.s2m(),
                                hasGradient: true,
                                gradientColors: const [
                                  MainColors.white,
                                  MainColors.white,
                                ],
                                hasImage: false,
                                imagePath: "",
                                imageOpacity: 0.1,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                normalColor: MainColors.transparent,
                                borderRadius: CustomRadius.sm(),
                                leftPadding: 0,
                                rightPadding: 0,
                                topPadding: 0,
                                bottomPadding: 0,
                                label: "",
                                fontSize: 0,
                                textColor: MainColors.white,
                                hasIcon: true,
                                buttonIcon: Icons.close_rounded,
                                iconColor: MainColors.primary,
                                iconSize: 30,
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
                                          costs: widget.costs,
                                          date: widget.date,
                                          itemsNumber: widget.itemsNumber,
                                          liters: widget.liters,
                                          petrolName: widget.petrolName,
                                          currentIndex: widget.carIndex,
                                        )),
                                  );
                                }),
                          )
                        ],
                      ),
                          SizedBox(height: Height.s4m()),
                            Container(
                                  width: Screen.size.width * 0.88,
                                  height: Screen.size.height * 0.35,
                                  decoration: BoxDecoration(
                                      color: MainColors.white,
                                      borderRadius: BorderRadius.circular(28)),
                                  child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 60),
                                          SizedBox(
                                            width: Screen.size.width * 0.8,
                                            child: TextFormField(
                                              textAlign: TextAlign.left,
                                              cursorColor: MainColors.black,
                                              style: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.x3s(),
                                              ),
                                              controller: _carMake,
                                              decoration: InputDecoration(
                                                label:
                                                const Text("Current KM"),
                                                contentPadding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    vertical: 0,
                                                    horizontal: 20),
                                                hintStyle: GoogleFonts.mada(
                                                  color: MainColors.black,
                                                  fontSize: Fonts.x3s(),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: MainColors
                                                          .deepPurple,
                                                      width: 2.0),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: MainColors
                                                          .black,
                                                      width: 1),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: MainColors
                                                          .deepPurple,
                                                      width: 2.0),
                                                ),
                                                errorBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: MainColors
                                                          .redAccent,
                                                      width: 2.0),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: MainColors
                                                          .redAccent,
                                                      width: 2.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: Screen.size.width * 0.8,
                                            // Adjust the width to your preference
                                            child: DropdownButtonFormField<
                                                String>(
                                              decoration: InputDecoration(
                                                label:
                                                const Text("Select Car"),
                                                contentPadding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 20,
                                                    vertical: 0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: MainColors
                                                          .deepPurple,
                                                      width: 2),
                                                ),
                                              ),
                                              value: _selectedCar,
                                              items:
                                              _carList.map((Cars item) {
                                                return DropdownMenuItem<
                                                    String>(
                                                    value: item.make,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(30)),
                                                      child: Text(item.make),
                                                    ));
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedCar =
                                                      newValue; // Update the selected value
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
                                          Transform.translate(
                                            offset: const Offset(-0.08, 21),
                                            child: Center(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: Screen.size.width * 0.465,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    CarSelectedPage(
                                                                      upComingChecks: widget.upComingChecks,
                                                                      profileID: widget.profileID,
                                                                      myCars: widget.myCars,
                                                                      userEmail: widget.userEmail ,
                                                                      userLastName: widget.userLastName ,
                                                                      userName:
                                                                      widget.userName,
                                                                      costs:
                                                                      widget.costs,
                                                                      date:
                                                                      widget.date,
                                                                      itemsNumber:
                                                                      widget.itemsNumber,
                                                                      liters:
                                                                      widget.liters,
                                                                      petrolName:
                                                                      widget.petrolName,
                                                                      currentIndex:
                                                                      widget.carIndex,
                                                                    )),
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                          const Color
                                                              .fromARGB(
                                                              255,
                                                              244,
                                                              244,
                                                              244),
                                                          shape:
                                                          const RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.only(
                                                              topLeft: Radius.circular(0),
                                                              bottomLeft: Radius.circular(28),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(16),
                                                          child: Text(
                                                            widget
                                                                .leftButtonText,
                                                            style: GoogleFonts
                                                                .rubik(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  133,
                                                                  133,
                                                                  133),
                                                              fontSize:
                                                              Fonts.md(),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(0),
                                                    child: Container(
                                                      width: 0.8,
                                                      color: Colors.black, // Color of the divider
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Screen.size.width * 0.412,
                                                    child: ElevatedButton(
                                                      onPressed: () {

                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                        const Color
                                                            .fromARGB(255,
                                                            12, 21, 52),
                                                        shape:
                                                        const RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.only(
                                                            topRight: Radius.circular(0),
                                                            bottomRight: Radius.circular(28),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(16),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .min,
                                                            children: [
                                                              Text(
                                                                widget
                                                                    .rightButtonText,
                                                                style:
                                                                GoogleFonts
                                                                    .rubik(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: MainColors
                                                                      .white,
                                                                  fontSize:
                                                                  Fonts
                                                                      .md(),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                               Transform.translate(offset: Offset(0, -Height.lg()),child:
                               Transform.scale(
                                scale: 0.85,
                                child: Image(
                                  image: AssetImage(widget.upperImage),
                                  fit: BoxFit.cover,
                          ),))
                    ]))
        )]));
  }
}
