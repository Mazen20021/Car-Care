
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';
import '../Pages/car_not_selected_page.dart';
import '../Pages/car_selected_page.dart';
import '../Services/car_api.dart';

class EditCars extends StatefulWidget {
  final String profileID;
  final String carName;
  final String carModel;
  final Cars car;
  final List<Cars> myCars;
  final String userName;
  final int currentIndex;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final String userLastName;
  final String userEmail;

  const EditCars(
      {required this.car,
      required this.profileID,
      required this.carModel,
      required this.carName,
      required this.myCars,
      required this.userName,
      required this.currentIndex,
      required this.costs,
      required this.date,
      required this.liters,
      required this.petrolName,
      required this.itemsNumber,
      required this.userEmail,
      required this.userLastName,
      super.key});

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
  final List<String> _classList = ['SUV', 'Sedan', 'Coupe', 'Hatchback'];
  final List<String> _notifyList = ['daily', 'weekly', 'monthly'];
  final int currentYear = DateTime.now().year;
  DateTime? _selectedExaminationDate;
  String? _selectedYear;
  String? _selectedClass;
  String? _selectedNotify;
  DateTime? _selectedLicenseDate;
  final TextEditingController _setLicenseDate = TextEditingController();
  late CarAPI carApi;
  bool _isLoading = false;
  bool _isLoading2 = false;

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
        _setLicenseDate.text = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .format(_selectedLicenseDate!); // Display format
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
        _setExaminationDate.text = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .format(_selectedExaminationDate!); // Display format
      });
    }
  }

  @override
  void initState() {
    carApi = CarAPI(context);
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
                  Text(
                    widget.carName,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        color: MainColors.white,
                        fontSize: Fonts.xl(),
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.carModel,
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
                                      userLastName: widget.userLastName,
                                      userEmail: widget.userEmail,
                                      userName: widget.userName,
                                      petrolName: widget.petrolName,
                                      liters: widget.liters,
                                      itemsNumber: widget.itemsNumber,
                                      date: widget.date,
                                      costs: widget.costs,
                                      currentIndex: widget.currentIndex,
                                      myCars: widget.myCars,
                                      profileID: widget.profileID,
                                    )),
                          );
                        }),
                  )
                ],
              ),
              const SizedBox(height: 120),
            SizedBox(
                width: Screen.size.width * 0.88,
                height: Screen.size.height * 0.686,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: MainColors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: SingleChildScrollView(child:
                        Column(
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
                            !_isLoading
                                ? SizedBox(
                                    width: Screen.size.width * 0.8,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        try {
                                          await carApi.deleteCars(
                                              carID: widget.car.id);
                                          int index = widget.myCars.indexWhere(
                                              (c) => c.id == widget.car.id);
                                          widget.myCars.removeAt(index);
                                          if (widget.myCars.isEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CarNotSelectedPage(
                                                        userLastName:
                                                            widget.userLastName,
                                                        userEmail:
                                                            widget.userEmail,
                                                        userName:
                                                            widget.userName,
                                                        currentIndex:
                                                            widget.currentIndex,
                                                        profileID:
                                                            widget.profileID,
                                                      )),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CarSelectedPage(
                                                        userLastName:
                                                            widget.userLastName,
                                                        userEmail:
                                                            widget.userEmail,
                                                        userName:
                                                            widget.userName,
                                                        petrolName:
                                                            widget.petrolName,
                                                        liters: widget.liters,
                                                        itemsNumber:
                                                            widget.itemsNumber,
                                                        date: widget.date,
                                                        costs: widget.costs,
                                                        currentIndex:
                                                            widget.currentIndex,
                                                        myCars: widget.myCars,
                                                        profileID:
                                                            widget.profileID,
                                                      )),
                                            );
                                          }
                                        } catch (e) {
                                        } finally {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 181, 74, 80),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Delete Car',
                                                  style: GoogleFonts.rubik(
                                                    fontWeight: FontWeight.bold,
                                                    color: MainColors.white,
                                                    fontSize: Fonts.md(),
                                                  ),
                                                ),
                                              ])),
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: MainColors.danger,
                                    backgroundColor: MainColors.background,
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CarSelectedPage(
                                                        userLastName:
                                                            widget.userLastName,
                                                        userEmail:
                                                            widget.userEmail,
                                                        userName:
                                                            widget.userName,
                                                        petrolName:
                                                            widget.petrolName,
                                                        liters: widget.liters,
                                                        itemsNumber:
                                                            widget.itemsNumber,
                                                        date: widget.date,
                                                        costs: widget.costs,
                                                        currentIndex:
                                                            widget.currentIndex,
                                                        myCars: widget.myCars,
                                                        profileID:
                                                            widget.profileID,
                                                      )),
                                            );
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
                                    !_isLoading2
                                        ? SizedBox(
                                            width: Screen.size.width * 0.412,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isLoading2 = true;
                                                });
                                                try {
                                                  Cars car = Cars(
                                                    make: _carMake.text,
                                                    model: _carModel.text,
                                                    year: _selectedYear
                                                        .toString(),
                                                    carClass: (_classList.indexOf(
                                                                _selectedClass
                                                                    .toString()) +
                                                            1)
                                                        .toString(),
                                                    notifyme: _selectedNotify
                                                        .toString(),
                                                    profileID: widget.profileID,
                                                    ed: _setExaminationDate
                                                        .text,
                                                    led: _setLicenseDate.text,
                                                    movedDistance: 0,
                                                  );
                                                  await carApi.updateCars(
                                                      car: car,
                                                      carID: widget.car.id);
                                                  int index = widget.myCars
                                                      .indexWhere((c) =>
                                                          c.id ==
                                                          widget.car.id);
                                                  if (index != -1) {
                                                    // Replace the car at the found index
                                                    widget.myCars[index] = car;
                                                  } else {
                                                    // If the car is not found in the list, you could add it if needed
                                                    widget.myCars.add(car);
                                                  }
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CarSelectedPage(
                                                              userLastName: widget
                                                                  .userLastName,
                                                              userEmail: widget
                                                                  .userEmail,
                                                              userName: widget
                                                                  .userName,
                                                              petrolName: widget
                                                                  .petrolName,
                                                              liters:
                                                                  widget.liters,
                                                              itemsNumber: widget
                                                                  .itemsNumber,
                                                              date: widget.date,
                                                              costs:
                                                                  widget.costs,
                                                              currentIndex: widget
                                                                  .currentIndex,
                                                              myCars:
                                                                  widget.myCars,
                                                              profileID: widget
                                                                  .profileID,
                                                            )),
                                                  );
                                                } catch (e) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Failed To Update"),
                                                        content: const Text(
                                                            "Could not Update this car"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                                setState(() {
                                                  _isLoading2 = false;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 12, 21, 52),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Update',
                                                        style:
                                                            GoogleFonts.rubik(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              MainColors.white,
                                                          fontSize: Fonts.md(),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Icon(
                                                          Icons.update_rounded,
                                                          color:
                                                              MainColors.white),
                                                    ],
                                                  )),
                                            ),
                                          )
                                        : const CircularProgressIndicator(
                                            color: MainColors.primary,
                                            backgroundColor:
                                                MainColors.background,
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
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
              )
            ])));
  }
}
