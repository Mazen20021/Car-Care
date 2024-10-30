import 'package:carcare/Components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Config/constants.dart';
import '../Config/repair_list_data.dart';
import '../PopUps/popUps.dart';
import 'car_selected_page.dart';

class CarRepairPage extends StatefulWidget {
  final int carIndex;
  final String userName;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;

  const CarRepairPage(
      {required this.carIndex,
      required this.userName,
      required this.costs,
      required this.date,
      required this.liters,
      required this.petrolName,
      required this.itemsNumber,
      super.key});

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
  final TextEditingController _repairName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedValue;
  final List<String> _items = ['Gas', 'Fix', 'Dox', 'Lox'];
  List<RepairItem> repairDataList = [];
  int addedItems = 0;
  double itemIndex = 50;
  int pressedIndex = 0;

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

  void addRepairRow() {
    setState(() {
      addedItems++;
      itemIndex += 10;
      repairDataList.add(
        RepairItem(
          name: _selectedValue.toString(),
          date: _setDate.text,
          km: "${_kmRepair.text} KM",
          cost: _repairCost.text,
        ),
      );
    });
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
                          builder: (context) => CarSelectedPage(
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
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              SizedBox(width: Width.s7m()),
              Text(
                "Add A Car Repair",
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.xl(),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            physics: (_isExpanded1 && repairDataList.isNotEmpty)
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(children: [
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
                                    child: Image.asset(
                                        imagesPath[widget.carIndex]),
                                  )),
                            ));
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: Width.x3xl(),
                decoration: BoxDecoration(
                  color: MainColors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Repair List",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 12, 21, 52),
                              fontSize: Fonts.sm())),
                      const SizedBox(width: 219),
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
                  Transform.translate(
                      offset: const Offset(15, 0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        height: _isExpanded1
                            ? (repairDataList.isEmpty ? 0 : itemIndex)
                            : 0,
                        child: ListView.builder(
                          itemCount: repairDataList.length,
                          itemBuilder: (context, index) {
                            RepairItem item = repairDataList[index];
                            return ListTile(
                                title: Transform.translate(
                              offset: const Offset(-16.5, 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 12, 21, 52),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(3, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: MainColors.borderLight,
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 5 ),
                                              Text(item.name,
                                                  style: GoogleFonts.rubik(
                                                      fontSize: Fonts.x2s())),
                                              (item.date.toString().length < 10)? const SizedBox(width: 5 ):
                                              const SizedBox(width: 10 ),
                                              const Icon(Icons.calendar_month,
                                                  size: 15),
                                              const SizedBox(width: 5),
                                              Text(item.date,
                                                  style: GoogleFonts.rubik(
                                                      fontSize: Fonts.x2s())),
                                              (item.km.toString().length < 15)?const SizedBox(width: 15 ):
                                              const SizedBox(width: 5 ),
                                              const Icon(Icons.speed_rounded,
                                                  size: 15),
                                              const SizedBox(width: 5),
                                              Text(item.km,
                                                  style: GoogleFonts.rubik(
                                                      fontSize: Fonts.x2s())),
                                              (item.cost.toString().length < 10)?const SizedBox(width: 20.5 ):
                                              const SizedBox(width: 5 ),
                                              const Icon(
                                                  Icons.monetization_on_rounded,
                                                  size: 15),
                                              const SizedBox(width: 5),
                                              Text(item.cost,
                                                  style: GoogleFonts.rubik(
                                                      fontSize: Fonts.x2s())),
                                              Transform.translate(
                                                offset: const Offset(-8, 0),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete_forever,
                                                    size: 15,
                                                    color: MainColors.danger,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      repairDataList
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          },
                        ),
                      )),
                  SizedBox(height: 5),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                                suffixIcon:
                                    const Icon(Icons.calendar_month_rounded),
                                labelText: 'Date',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                hintStyle: GoogleFonts.mada(
                                  color: MainColors.black,
                                  fontSize: Width.x2s(),
                                ),
                                hintText: 'Select Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: MainColors.deepPurple, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: MainColors.black, width: 1),
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
                          const SizedBox(
                              height: 13), // Required for input formatting
                          SizedBox(
                            width: Screen.size.width * 0.93,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              cursorColor: MainColors.black,
                              style: GoogleFonts.mada(
                                color: MainColors.black,
                                fontSize: Width.x2s(),
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
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
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
                                  borderSide: const BorderSide(
                                      color: MainColors.black, width: 1),
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
                          const SizedBox(
                              height: 13), // Required for input formatting
                          SizedBox(
                            width: Screen.size.width * 0.93,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              cursorColor: MainColors.black,
                              style: GoogleFonts.mada(
                                color: MainColors.black,
                                fontSize: Width.x2s(),
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
                                label: const Text("Repair Cost *Optional"),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                hintStyle: GoogleFonts.mada(
                                  color: MainColors.black,
                                  fontSize: Width.x2s(),
                                ),
                                hintText: 'Cost',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: MainColors.deepPurple, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: MainColors.black, width: 1),
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
                                label: const Text("Selected Repair"),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: MainColors.deepPurple, width: 2),
                                ),
                              ),
                              hint: const Text('Select Repair'),
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
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Text("Cant find your repair",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.bold,
                                      color: MainColors.black,
                                      fontSize: Fonts.sm())),
                              Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  // RepairClass(
                                                  //   userName: widget.userName,
                                                  //   costs: widget.costs,
                                                  //   date: widget.date,
                                                  //   itemsNumber:
                                                  //       widget.itemsNumber,
                                                  //   liters: widget.liters,
                                                  //   petrolName:
                                                  //       widget.petrolName,
                                                  //   carIndex: widget.carIndex,
                                                  // )
                                              PopUpDialogs(
                                                  userName: widget.userName,
                                                  costs: widget.costs,
                                                  date: widget.date,
                                                  itemsNumber:
                                                      widget.itemsNumber,
                                                  liters: widget.liters,
                                                  petrolName:
                                                      widget.petrolName,
                                                  carIndex: widget.carIndex,
                                                addNewCar: false,
                                                addNewRecord: false,
                                                addNewRepair: true,
                                                hasLowerImage: true,
                                                hasLowerText: true,
                                                lowerText:  "The number of km that will make a reminder for you to check",
                                                hasUpperImage: false,
                                                headerText: "Add a new repair part",
                                                hasTextField: true,
                                                leftButtonText: "Cancel",
                                                lowerImage: "assets/manWithCar.png",
                                                numberOfTextFields: 0,
                                                rightButtonText: "Submit",
                                                upperImage: "",
                                              )
                                          ),
                                        );
                                      },
                                      child: Text("Add new repair part",
                                          style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold,
                                              color: MainColors.primary,
                                              fontSize: Fonts.sm()))))
                            ],
                          ),
                          Transform.translate(offset: const Offset(15, -22),child:
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Text("Want to configure car repair",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.bold,
                                      color: MainColors.black,
                                      fontSize: Fonts.sm())),
                              Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text("Change Repair Milestone",
                                          style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold,
                                              color: MainColors.primary,
                                              fontSize: Fonts.sm()))))
                            ],
                          )),
                      Transform.translate(offset: const Offset(-1, -30),child:
                          Row(
                            mainAxisSize: MainAxisSize.min,
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
                                onPressed: addRepairRow,
                              ),
                              Transform.translate(
                                offset: const Offset(-6, 0),
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
                                                CarSelectedPage(
                                                  userName: widget.userName,
                                                  currentIndex: widget.carIndex,
                                                  costs: widget.costs,
                                                  date: widget.date,
                                                  itemsNumber:
                                                      widget.itemsNumber,
                                                  liters: widget.liters,
                                                  petrolName: widget.petrolName,
                                                )),
                                      );
                                    }),
                              )
                            ],
                          )
                      )],
                      )),
                ]),
              )
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
