import 'package:carcare/Services/APIs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';

class EditCars extends StatefulWidget {
  final String profileID;
  final String carName;
  final String carModel;
  final Cars car;
  const EditCars({required this.car,required this.profileID,required this.carModel,required this.carName, super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditCars();
  }
}

class _EditCars extends State<EditCars> {
  final TextEditingController _setExaminationDate = TextEditingController();
  final TextEditingController _carMake = TextEditingController();
  final TextEditingController _carModel = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> _years = [];
  final List<String> _classList = ['SUV', 'Sedan','Coupe','Hatchback'];
  final List<String> _notifyList = ['daily', 'weekly', 'monthly'];
  final int currentYear = DateTime.now().year;
  DateTime? _selectedExaminationDate;
  String? _selectedYear;
  String? _selectedClass;
  String? _selectedNotify;
  DateTime? _selectedLicenseDate;
  final TextEditingController _setLicenseDate = TextEditingController();
  late AuthActions aa;

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
        _setLicenseDate.text = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(_selectedLicenseDate!);  // Display format
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
        _setExaminationDate.text = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(_selectedExaminationDate!);  // Display format
      });
    }
  }



  @override
  void initState() {
    aa = AuthActions(context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _years = List<String>.generate(
      currentYear - 1899,
          (index) => (currentYear - index).toString(),
    );
    return Scaffold(
        body: Container(
            width: Screen.size.width,
            height: Screen.size.height,
            decoration: BoxDecoration(
              color: MainColors.primary.withOpacity(0.8),
            ),
            child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        "Edit",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: MainColors.white,
                            fontSize: Fonts.xl(),
                            decoration: TextDecoration.none),
                      ),
                      const SizedBox(width: 5),
                      Text(widget.carName, style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: MainColors.white,
                          fontSize: Fonts.xl(),
                          decoration: TextDecoration.none),),
                      const SizedBox(width: 5),
                      Text(widget.carModel, style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: MainColors.white,
                          fontSize: Fonts.xl(),
                          decoration: TextDecoration.none),),
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
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  ),
                  const SizedBox(height: 120),
                  SingleChildScrollView(
                      child: SizedBox(
                        width: Screen.size.width * 0.88,
                        height: Screen.size.height * 0.686,
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: MainColors.white,
                                    borderRadius: BorderRadius.circular(15)),
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
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          hintStyle: GoogleFonts.mada(
                                            color: MainColors.black,
                                            fontSize: Fonts.x3s(),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.black, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.redAccent,
                                                width: 2.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
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
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          hintStyle: GoogleFonts.mada(
                                            color: MainColors.black,
                                            fontSize: Fonts.x3s(),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.black, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.redAccent,
                                                width: 2.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
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
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          label: const Text("Select Creation Year"),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple, width: 2),
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
                                                    BorderRadius.circular(30)),
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
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          label: const Text("Select Car Class"),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple, width: 2),
                                          ),
                                        ),
                                        hint: const Text('Car Class'),
                                        value: _selectedClass,
                                        items: _classList.map((String item) {
                                          return DropdownMenuItem<String>(
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
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          label: const Text("Notification Types"),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple, width: 2),
                                          ),
                                        ),
                                        hint: const Text('Notify Me'),
                                        value: _selectedNotify,
                                        items: _notifyList.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(30)),
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
                                          labelText: 'License expiration date',
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          hintStyle: GoogleFonts.mada(
                                            color: MainColors.black,
                                            fontSize: Fonts.x3s(),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.black, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.redAccent,
                                                width: 2.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.redAccent,
                                                width: 2.0),
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
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          hintStyle: GoogleFonts.mada(
                                            color: MainColors.black,
                                            fontSize: Fonts.x3s(),
                                          ),
                                          hintText: 'Examination date...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.black, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.deepPurple,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.redAccent,
                                                width: 2.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: MainColors.redAccent,
                                                width: 2.0),
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
                                    const SizedBox(height: 13),
                                    Transform.translate(
                                      offset: const Offset(-0.08, 0),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: Screen.size.width * 0.465,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 244, 244, 244),
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        bottomLeft: Radius.circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: Text(
                                                      'Cancel',
                                                      style: GoogleFonts.rubik(
                                                        fontWeight: FontWeight.bold,
                                                        color: const Color.fromARGB(
                                                            255, 133, 133, 133),
                                                        fontSize: Fonts.md(),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                width: 2,
                                                color: Colors
                                                    .black, // Color of the divider
                                              ),
                                            ),
                                            SizedBox(
                                              width: Screen.size.width * 0.412,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Cars car = Cars(
                                                    make: _carMake.text,
                                                    model: _carModel.text,
                                                    year: _selectedYear.toString(),
                                                    carClass: (_classList.indexOf(_selectedClass.toString())+1).toString(),
                                                    notifyme: _selectedNotify.toString(),
                                                    profileID: widget.profileID,
                                                    ed: _setExaminationDate.text,
                                                    led:_setLicenseDate.text,
                                                    movedDistance: 0,
                                                  );
                                                  aa.updateCars(car: car,carID: widget.car.id);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color.fromARGB(
                                                      255, 12, 21, 52),
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(0),
                                                      bottomRight: Radius.circular(15),
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Create',
                                                          style: GoogleFonts.rubik(
                                                            fontWeight: FontWeight.bold,
                                                            color: MainColors.white,
                                                            fontSize: Fonts.md(),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        const Icon(Icons.add,
                                                            color: MainColors.white),
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
                                offset: Offset(0, -Height.s3_3m()),
                                child: const Image(
                                  image: AssetImage("assets/whiteCar.png"),
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ]))));
  }
}
