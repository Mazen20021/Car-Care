import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';
import '../Pages/car_repair_page.dart';
import '../Pages/car_selected_page.dart';

class PopUpDialogs extends StatefulWidget {
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
  final bool addNewCar;
  final bool addNewRepair;
  final bool addNewRecord;
  final int numberOfTextFields;
  final String rightButtonText;
  final String leftButtonText;

  const PopUpDialogs(
      {required this.userName,
      required this.carIndex,
      required this.costs,
      required this.date,
      required this.liters,
      required this.petrolName,
      required this.itemsNumber,
      this.headerText = "",
      this.upperImage = "",
      this.lowerImage = "",
      this.addNewCar = false,
      this.addNewRecord = false,
      this.addNewRepair = false,
      this.hasLowerImage = false,
      this.hasLowerText = false,
      this.hasTextField = false,
      this.hasUpperImage = false,
      this.lowerText = "",
      this.numberOfTextFields = 0,
      this.leftButtonText = "Cancel",
      this.rightButtonText = "Submit",
      super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopUpDialogs();
  }
}

class _PopUpDialogs extends State<PopUpDialogs> {
  final TextEditingController _setExaminationDate = TextEditingController();
  static final TextEditingController _repairName = TextEditingController();
  static final TextEditingController _repairKM = TextEditingController();
  static final TextEditingController _carMake = TextEditingController();
  static final TextEditingController _carModel = TextEditingController();
  final TextEditingController _setLicenseDate = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? _selectedExaminationDate;
  String? _selectedYear;
  String? _selectedClass;
  String? _selectedCar;
  String? _selectedNotify;
  DateTime? _selectedLicenseDate;
  late final List<String> _years;
  late final List<String> _classList;
  late final List<String> _carList;
  late final List<String> _notifyList;
  final int currentYear = DateTime.now().year;
  Future<void> _selectLicenseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedLicenseDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedLicenseDate) {
      setState(() {
        _selectedLicenseDate = picked;
        _setLicenseDate.text =
            DateFormat('dd-MM-yyyy').format(_selectedLicenseDate!);
      });
    }
  }

  Future<void> _selectExaminationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedExaminationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedExaminationDate) {
      setState(() {
        _selectedExaminationDate = picked;
        _setExaminationDate.text =
            DateFormat('dd-MM-yyy').format(_selectedExaminationDate!);
      });
    }
  }

  @override
  void initState() {
    if (widget.addNewCar) {
      _selectLicenseDate(context);
      _classList = ['option 1', 'option 2'];
      _notifyList = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
      _years = List<String>.generate(
        currentYear - 1899,
        (index) => (currentYear - index).toString(),
      );
    } else {
      _classList = [];
      _notifyList = [];
      _years = [];
      if (widget.addNewRecord) {
        _carList = ['option 1', 'option 2'];
      } else {
        _carList = [];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SingleChildScrollView(
            child: Container(
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
                              widget.addNewRepair
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CarRepairPage(
                                                userName: widget.userName,
                                                costs: widget.costs,
                                                date: widget.date,
                                                itemsNumber: widget.itemsNumber,
                                                liters: widget.liters,
                                                petrolName: widget.petrolName,
                                                carIndex: widget.carIndex,
                                              )),
                                    )
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CarSelectedPage(
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
                  widget.addNewRepair
                      ? Column(children: [
                          const SizedBox(height: 80),
                          SizedBox(
                              width: Screen.size.width * 0.85,
                              height: Screen.size.height * 0.6,
                              child: Center(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: MainColors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        widget.hasLowerImage ?
                                        Transform.scale(
                                                scale: 0.8,
                                                child: Image(
                                                  image: AssetImage(
                                                      widget.lowerImage),
                                                  fit: BoxFit.cover,
                                                )
                                        ):
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.sm(),
                                            ),
                                            controller: _repairName,
                                            decoration: InputDecoration(
                                              label: const Text("Repair Name"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.sm(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 13),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.sm(),
                                            ),
                                            controller: _repairKM,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d*')),
                                            ],
                                            decoration: InputDecoration(
                                              label: const Text(
                                                  "Remind you every (KM)"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.sm(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          widget.lowerText,
                                          style: GoogleFonts.rubik(
                                              fontSize: Fonts.sm()),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(-15, 17),
                                          child: Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      Screen.size.width * 0.43,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                244, 244, 244),
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Text(
                                                          widget.leftButtonText,
                                                          style:
                                                              GoogleFonts.rubik(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                133, 133, 133),
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
                                                    width: 2,
                                                    color: Colors
                                                        .black, // Color of the divider
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Screen.size.width * 0.413,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Add your action for the second button
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 12, 21, 52),
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Row(children: [
                                                          Text(
                                                            widget
                                                                .rightButtonText,
                                                            style: GoogleFonts
                                                                .rubik(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: MainColors
                                                                  .white,
                                                              fontSize:
                                                                  Fonts.md(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          const Icon(Icons.add,
                                                              color: MainColors
                                                                  .white,
                                                              size: 18)
                                                        ])),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )))
                        ])
                      : Stack(
                          children: [
                            widget.addNewRecord
                                ? Transform.translate(
                                    offset:
                                        Offset(25, Screen.size.height * 0.3),
                                    child: Container(
                                        width: Screen.size.width * 0.88,
                                        height: Screen.size.height * 0.3,
                                        decoration: BoxDecoration(
                                            color: MainColors.white,
                                            borderRadius:
                                                BorderRadius.circular(28)),
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
                                                    _carList.map((String item) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: item,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(30)),
                                                        child: Text(item),
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
                                              offset: const Offset(-0.08, 20),
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: Screen.size.width *
                                                          0.465,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CarSelectedPage(
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
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Container(
                                                        width: 1,
                                                        color: Colors
                                                            .black, // Color of the divider
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Screen.size.width *
                                                          0.412,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Add your action for the second button
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
                                        ))))
                                : Container(
                                    decoration: BoxDecoration(
                                        color: MainColors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 40),
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
                                              label: const Text("Car Make"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.x3s(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.x3s(),
                                            ),
                                            controller: _carModel,
                                            decoration: InputDecoration(
                                              label: const Text("Car Model"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.x3s(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          // Adjust the width to your preference
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              label: const Text(
                                                  "Select Creation Year"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2),
                                              ),
                                            ),
                                            hint: const Text('Year'),
                                            value: _selectedYear,
                                            items: _years.map((String item) {
                                              return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Text(item),
                                                  ));
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedYear =
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
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          // Adjust the width to your preference
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              label: const Text(
                                                  "Select Car Class"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2),
                                              ),
                                            ),
                                            hint: const Text('Car Class'),
                                            value: _selectedClass,
                                            items:
                                                _classList.map((String item) {
                                              return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Text(item),
                                                  ));
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedClass =
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
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          // Adjust the width to your preference
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              label: const Text(
                                                  "Notification Types"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2),
                                              ),
                                            ),
                                            hint: const Text('Notify Me'),
                                            value: _selectedNotify,
                                            items:
                                                _notifyList.map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Text(item)),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedNotify =
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
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              _selectLicenseDate(context);
                                            },
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.x3s(),
                                            ),
                                            controller: _setLicenseDate,
                                            decoration: InputDecoration(
                                              suffixIcon: const Icon(
                                                Icons.calendar_month_rounded,
                                              ),
                                              labelText:
                                                  'License expiration date',
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.x3s(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Choose a date';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              _selectExaminationDate(context);
                                            },
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.x3s(),
                                            ),
                                            controller: _setExaminationDate,
                                            decoration: InputDecoration(
                                              suffixIcon: const Icon(
                                                Icons.calendar_month_rounded,
                                              ),
                                              labelText: 'Examination date',
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.x3s(),
                                              ),
                                              hintText: 'Examination date...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Choose a date';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 13),
                                        Transform.translate(
                                          offset: const Offset(-0.08, 0),
                                          child: Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      Screen.size.width * 0.465,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CarSelectedPage(
                                                                    userName: widget
                                                                        .userName,
                                                                    costs: widget
                                                                        .costs,
                                                                    date: widget
                                                                        .date,
                                                                    itemsNumber:
                                                                        widget
                                                                            .itemsNumber,
                                                                    liters: widget
                                                                        .liters,
                                                                    petrolName:
                                                                        widget
                                                                            .petrolName,
                                                                    currentIndex:
                                                                        widget
                                                                            .carIndex,
                                                                  )),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                244, 244, 244),
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Text(
                                                          widget.leftButtonText,
                                                          style:
                                                              GoogleFonts.rubik(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                133, 133, 133),
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
                                                    width: 2,
                                                    color: Colors
                                                        .black, // Color of the divider
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Screen.size.width * 0.412,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Add your action for the second button
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 12, 21, 52),
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              widget
                                                                  .rightButtonText,
                                                              style: GoogleFonts
                                                                  .rubik(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    MainColors
                                                                        .white,
                                                                fontSize:
                                                                    Fonts.md(),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            const Icon(
                                                                Icons.add,
                                                                color:
                                                                    MainColors
                                                                        .white),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            Transform.translate(
                              offset: widget.addNewRecord
                                  ? Offset(5, Height.s3m())
                                  : Offset(0, -Height.s3_3m()),
                              child: widget.addNewRecord
                                  ? Transform.scale(
                                      scale: 0.85,
                                      child: Image(
                                        image: AssetImage(widget.upperImage),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image(
                                      image: AssetImage(widget.upperImage),
                                      fit: BoxFit.cover,
                                    ),
                            )
                          ],
                        ),
                ])))
      ],
    ));
  }
}
