import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';

class AddNewCar extends StatefulWidget
{
  const AddNewCar({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddCar();
  }

}
class AddCar extends State<AddNewCar>{

  final TextEditingController _setExaminationDate = TextEditingController();
  final TextEditingController _repairName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final List<String> _years ;
  final List<String> _classList  = ['option 1','option 2'];
  final List<String> _notifyList  = ['Daily','Weekly','Monthly','Yearly'];
  final int currentYear = DateTime.now().year;
  DateTime? _selectedExaminationDate;
  String? _selectedYear;
  String? _selectedClass;
  String? _selectedNotify;
  DateTime? _selectedLicenseDate;
  final TextEditingController _setLicenseDate = TextEditingController();

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
        _setLicenseDate.text = DateFormat('dd-MM-yyyy').format(_selectedLicenseDate!);
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
        _setExaminationDate.text = DateFormat('dd-MM-yyy').format(_selectedExaminationDate!);
      });
    }
  }
   void newCar(BuildContext context) {
     _years = List<String>.generate(
     currentYear - 1899,
     (index) => (currentYear - index).toString(),
     );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: Screen.size.width,
            height: Screen.size.height,
            decoration: BoxDecoration(
              color: MainColors.primary.withOpacity(0.8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "Add a new car",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: MainColors.white,
                          fontSize: Fonts.xl,
                          decoration: TextDecoration.none),
                    ),
                    const Spacer(flex: 5),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                          width: 40,
                          height: 40,
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
                          borderRadius: CustomRadius.sm,
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
                const SizedBox(height: 100),
                SizedBox(
                    width: Screen.size.width,
                    height: Screen.size.height * 0.7,
                    child: Dialog(
                      child: Center(
                        child:
                        Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: MainColors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: SingleChildScrollView(child:
                            Column(
                              children: [
                                const SizedBox(height: 60),
                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    cursorColor: MainColors.black,
                                    style: GoogleFonts.mada(
                                      color: MainColors.black,
                                      fontSize: Fonts.sm,
                                    ),
                                    controller: _repairName,
                                    decoration: InputDecoration(
                                      label: const Text("Car Brand"),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      hintStyle: GoogleFonts.mada(
                                        color: MainColors.black,
                                        fontSize: Width.xs,
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
                                const SizedBox(height: 13),
                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    cursorColor: MainColors.black,
                                    style: GoogleFonts.mada(
                                      color: MainColors.black,
                                      fontSize: Fonts.sm,
                                    ),
                                    controller: _repairName,
                                    decoration: InputDecoration(
                                      label: const Text("Car Model"),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      hintStyle: GoogleFonts.mada(
                                        color: MainColors.black,
                                        fontSize: Width.xs,
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
                                const SizedBox(height: 13),
                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  // Adjust the width to your preference
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      label: const Text("Select Creation Year"),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.deepPurple,
                                            width: 2),
                                      ),
                                    ),
                                    hint: const Text('Year'),
                                    value: _selectedYear,
                                    items: _years.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                                const SizedBox(height: 13),
                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  // Adjust the width to your preference
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      label: const Text("Select Car Class"),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.deepPurple,
                                            width: 2),
                                      ),
                                    ),
                                    hint: const Text('Car Class'),
                                    value: _selectedClass,
                                    items: _classList.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                                const SizedBox(height: 13),
                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  // Adjust the width to your preference
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      label: const Text("Notification Types"),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.deepPurple,
                                            width: 2),
                                      ),
                                    ),
                                    hint: const Text('Notify Me'),
                                    value: _selectedNotify,
                                    items: _notifyList.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                            child: Text(item)),
                                      );
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
                                const SizedBox(height: 13),
                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  child: TextFormField(
                                    readOnly: true,
                                    onTap: () {
                                      _selectLicenseDate(context);
                                    },
                                    textAlign: TextAlign.left,
                                    cursorColor: MainColors.black,
                                    style: GoogleFonts.mada(
                                      color: MainColors.black,
                                      fontSize: Width.xs,
                                    ),
                                    controller: _setLicenseDate,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                      const Icon(Icons.calendar_today),
                                      labelText: 'License expiration date',
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      hintStyle: GoogleFonts.mada(
                                        color: MainColors.black,
                                        fontSize: Width.xs,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.deepPurple,
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
                                            color: MainColors.deepPurple,
                                            width: 2.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.redAccent,
                                            width: 2.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
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

                                SizedBox(
                                  width: Screen.size.width * 0.75,
                                  child: TextFormField(
                                    readOnly: true,
                                    onTap: () {

                                      _selectExaminationDate(context);
                                    },
                                    textAlign: TextAlign.left,
                                    cursorColor: MainColors.black,
                                    style: GoogleFonts.mada(
                                      color: MainColors.black,
                                      fontSize: Width.xs,
                                    ),
                                    controller: _setExaminationDate,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                      const Icon(Icons.calendar_today),
                                      labelText: 'Examination date',
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      hintStyle: GoogleFonts.mada(
                                        color: MainColors.black,
                                        fontSize: Width.xs,
                                      ),
                                      hintText: 'Examination date...',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.deepPurple,
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
                                            color: MainColors.deepPurple,
                                            width: 2.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: MainColors.redAccent,
                                            width: 2.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
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
                                  offset: const Offset(-0.37, 0),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: Screen.size.width * 0.4,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                // Add your action for the first button
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                const Color.fromARGB(
                                                    255, 244, 244, 244),
                                                shape:
                                                const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                    Radius.circular(8),
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
                                                    fontSize: Fonts.md,
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
                                          width: Screen.size.width * 0.4,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Add your action for the second button
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color.fromARGB(
                                                  255, 12, 21, 52),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child:Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                Text(
                                                'Create',
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.bold,
                                                  color: MainColors.white,
                                                  fontSize: Fonts.md,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              const Icon(Icons.add , color: MainColors.white),
                                              ],)

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                          Transform.translate(offset: const Offset(0, -130)
                            ,child: const Image(
                            image: AssetImage("assets/whiteCar.png"),
                            fit: BoxFit.cover,
                          ),)

                        ],),
                      ),
                    ))
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
