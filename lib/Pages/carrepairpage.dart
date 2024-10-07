import 'package:carcare/Components/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Config/constants.dart';
import '../Services/mainpageservice.dart';

class CarRepairPage extends StatefulWidget {
  final int carIndex;

  const CarRepairPage({required this.carIndex, super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarRepairPage();
  }
}

class _CarRepairPage extends State<CarRepairPage> {
  final List<String> imagesPath = List<String>.empty(growable: true);
  late final PageController _pageController;
  bool _isExpanded1 = false;
  DateTime? _selectedDate;
  final TextEditingController _setDate = TextEditingController();
  final TextEditingController _kmRepair = TextEditingController();
  final TextEditingController _repairCost = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedValue;
  final List<String> _items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

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
        _setDate.text = DateFormat('dd-MM-yyy').format(_selectedDate!);
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
                          builder: (context) => MainPageService(
                                isCarSelected: true,
                                userName: "Mazen",
                                currentIndex: widget.carIndex,
                              )),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              SizedBox(width: Width.md()),
              Text(
                "Add A Car Repair",
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.sm,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            physics: _isExpanded1
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  Opacity(
                      opacity: 1,
                      child: SizedBox(
                          width: Width.xxl,
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
                                fontSize: Fonts.md,
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
                          size: Width.xs,
                        ),
                        const SizedBox(width: 10),
                        Text("Data",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: MainColors.white,
                                fontSize: Fonts.sm,
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: Screen.size.width,
                            // Adjust width to your preference
                            child: Transform.translate(
                              offset: const Offset(0, 50),
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
              const SizedBox(height: 350),
              Transform.translate(
                  offset: const Offset(3, -370),
                  child: Container(
                    width: Screen.size.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
                                    color:
                                        const Color.fromARGB(255, 12, 21, 52)),
                                child: const Icon(
                                  Icons.handyman_rounded,
                                  color: MainColors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text("Repair List",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 12, 21, 52),
                                      fontSize: Fonts.xs)),
                              const SizedBox(width: 200),
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
                            height: _isExpanded1 ? 150 : 0,
                            // Adjust the height as needed
                            child: ListView(
                              children: List.generate(5, (index) {
                                return ListTile(
                                  title: Text("Item ${index + 1}"),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 13),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: Screen.size.width * 0.98,
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      style: GoogleFonts.mada(
                                        color: Colors.black,
                                        fontSize: Width.xs,
                                      ),
                                      controller: _setDate,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.calendar_today),
                                        labelText: 'Date',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                        hintStyle: GoogleFonts.mada(
                                          color: Colors.black,
                                          fontSize: Width.xs,
                                        ),
                                        hintText: 'Select Date',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFF34313),
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
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
                                  const SizedBox(
                                      height:
                                          13), // Required for input formatting

                                  SizedBox(
                                    width: Screen.size.width * 0.98,
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      style: GoogleFonts.mada(
                                        color: Colors.black,
                                        fontSize: Width.xs,
                                      ),
                                      controller: _kmRepair,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d*')),
                                      ],
                                      decoration: InputDecoration(
                                        label: const Text("KM Of Repair"),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                        hintStyle: GoogleFonts.mada(
                                          color: Colors.black,
                                          fontSize: Width.xs,
                                        ),
                                        hintText: '0',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFF34313),
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2.0),
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
                                  const SizedBox(
                                      height:
                                          13), // Required for input formatting
                                  SizedBox(
                                    width: Screen.size.width * 0.98,
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      style: GoogleFonts.mada(
                                        color: Colors.black,
                                        fontSize: Width.xs,
                                      ),
                                      controller: _repairCost,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d*')),
                                      ],
                                      decoration: InputDecoration(
                                        label:
                                            const Text("Repair Cost *Optional"),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                        hintStyle: GoogleFonts.mada(
                                          color: Colors.black,
                                          fontSize: Width.xs,
                                        ),
                                        hintText: 'Cost',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFF34313),
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 13),
                                  SizedBox(
                                    width: Screen.size.width *
                                        0.98, // Adjust the width to your preference
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        label: const Text("Selected Repair"),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 2),
                                        ),
                                      ),
                                      hint: const Text('Select Repair'),
                                      value: _selectedValue,
                                      items: _items.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedValue =
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
                                      offset: const Offset(2, 0),
                                      child: Row(
                                        children: [
                                          Text("Cant find your repair",
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.bold,
                                                  color: MainColors.black,
                                                  fontSize: Fonts.xs)),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                  "Add new repair part"))
                                        ],
                                      )),
                                  Transform.translate(
                                      offset: const Offset(2, -20),
                                      child: Row(
                                        children: [
                                          Text("Want to configure car repair",
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.bold,
                                                  color: MainColors.black,
                                                  fontSize: Fonts.xs)),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                  "Change Repair Milestone"))
                                        ],
                                      )),
                                  Transform.translate(
                                      offset: const Offset(-20, -5),
                                      child: Row(
                                        children: [
                                          ButtonClass(
                                              width: 180,
                                              height: 50,
                                              hasGradient: true,
                                              gradientColors: const [
                                                Color.fromARGB(
                                                    255, 48, 95, 215),
                                                Color.fromARGB(255, 48, 95, 215)
                                              ],
                                              hasImage: true,
                                              imagePath:
                                                  "assets/image/loginBackground.png",
                                              imageOpacity: 0.1,
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              normalColor: Colors.transparent,
                                              borderRadius: CustomRadius.sm,
                                              leftPadding: 20,
                                              rightPadding: 20,
                                              topPadding: 5,
                                              bottomPadding: 15,
                                              label: "Save",
                                              fontSize: Fonts.xs,
                                              textColor: Colors.white,
                                              onPressed: () {}),
                                          Transform.translate(
                                            offset: const Offset(-3, 0),
                                            child: ButtonClass(
                                                width: 180,
                                                height: 50,
                                                hasGradient: true,
                                                gradientColors: const [
                                                  Color.fromARGB(
                                                      255, 180, 74, 80),
                                                  Color.fromARGB(
                                                      255, 181, 74, 80)
                                                ],
                                                hasImage: true,
                                                imagePath:
                                                    "assets/image/loginBackground.png",
                                                imageOpacity: 0.1,
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                normalColor: Colors.transparent,
                                                borderRadius: CustomRadius.sm,
                                                leftPadding: 0,
                                                rightPadding: 20,
                                                topPadding: 5,
                                                bottomPadding: 15,
                                                label: "Cancel",
                                                fontSize: Fonts.xs,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainPageService(
                                                              isCarSelected:
                                                                  true,
                                                              userName: "Mazen",
                                                              currentIndex:
                                                                  widget
                                                                      .carIndex,
                                                            )),
                                                  );
                                                }),
                                          )
                                        ],
                                      ))
                                ],
                              )),
                        ]),
                  ))
            ])));
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
