import 'package:carcare/PopUps/delete_account.dart';
import 'package:carcare/Services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/custom_button.dart';
import '../Components/nav_button.dart';
import '../Config/constants.dart';
import '../Services/car_api.dart';
import '../Services/repair_api.dart';
import 'car_list_page.dart';
import 'gas_tracking_page.dart';
import 'car_selected_page.dart';


class Settings extends StatefulWidget {
  final bool isSub;
  final String userName;
  final String userLastName;
  final String userEmail;
  final int carIndex;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final List<Cars> myCars;
  final String profileID;
  final List<RepairType> upComingChecks;
  const Settings({required this.isSub,
    required this.userName,
    required this.carIndex,
    required this.costs,
    required this.date,
    required this.liters,
    required this.petrolName,
    required this.itemsNumber,
    required this.userEmail,
    required this.userLastName,
    required this.myCars,
    required this.profileID,
    required this.upComingChecks,
    super.key});

  @override
  State<StatefulWidget> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings> {
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late UserAPI userApi;
  bool _isClosed = false;
  bool _changed = false;
  @override
  void initState()
  {
    userApi = UserAPI(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 65),
                Row(
                  children: [
                    SizedBox(width: Width.xs()),
                    Text("Settings",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                            fontSize: Fonts.xxl(), color: MainColors.black)),
                    SizedBox(width: Width.m2d()),
                    GestureDetector(
                      onTap: () {
                       userApi.logout();
                      },
                      child: Container(
                        width: ButtonWidth.l3g(),
                        height: ButtonHeights.s3m(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 108, 113, 132),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.login_outlined,
                                  color: MainColors.white, size: 15),
                              const SizedBox(width: 10),
                              Text("Logout",
                                  style: GoogleFonts.rubik(
                                      fontSize: Fonts.sm(),
                                      color: MainColors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                        height: Height.sm(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: MainColors.grey,
                                blurRadius: 20,
                                offset: Offset(0, 0))
                          ],
                          color: const Color.fromARGB(255, 254, 247, 255),
                          border: Border.all(
                            color: MainColors.primary,
                            // Set the border color to blue
                            width:
                                1, // Adjust the width of the border if needed
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Text("Free trial plan",
                                style: GoogleFonts.rubik(
                                    fontSize: Fonts.md(),
                                    color: MainColors.primary)),
                            SizedBox(
                              width: Width.s7m(),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: ButtonWidth.l5g(),
                                height: ButtonHeights.s2m(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColors.primary,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: Width.x4s()),
                                    const Icon(
                                      Icons.keyboard_double_arrow_up_rounded,
                                      color: MainColors.white,
                                    ),
                                    SizedBox(width: Width.x3s()),
                                    Text("UPGRADE",
                                        style: GoogleFonts.rubik(
                                            fontSize: Fonts.md(),
                                            color: MainColors.white))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))),
                Transform.translate(
                  offset: Offset(-Width.m2d(), 0),
                  child: Text("Information",
                      style: GoogleFonts.rubik(
                          fontSize: Fonts.md(), color: MainColors.black)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: Screen.size.width,
                    height:!_isClosed ?Screen.size.height * 0.2 : Screen.size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: MainColors.grey,
                            blurRadius: 20,
                            offset: Offset(0, 0))
                      ],
                      color: const Color.fromARGB(255, 254, 247, 255),
                    ),
                    child: Center(
                      child: !_isClosed ?
                      Column(children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            const Text("First Name: "),
                            const SizedBox(width: 1),
                            Text(_changed?_fName.text: widget.userName,style: GoogleFonts.rubik(
                                color: MainColors.primary,fontSize: 12)),
                            const SizedBox(width: 5),
                            const Text("Last Name: "),
                            const SizedBox(width: 1),
                            Text(_changed?_lName.text:widget.userLastName,style: GoogleFonts.rubik(
                              color: MainColors.primary,
                              fontSize: 12
                            ),),
                          ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          const SizedBox(width: 10),
                          const Text("Email: "),
                          const SizedBox(width: 1),
                          Text(widget.userEmail,style: GoogleFonts.rubik(
                              color: MainColors.primary,
                              fontSize: 12
                          ),),
                        ],),
                        Padding(padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child:Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10), // Border radius for the image
                              child: Opacity(
                                opacity: 0.7, // Adjust opacity as needed
                                child: Image.asset(
                                  'assets/image/loginBackground.png', // Replace with your image asset path
                                  fit: BoxFit.cover,
                                  width: double.infinity, // Make sure the image covers the button area
                                  height: 50, // Adjust height as needed for the button size
                                ),
                              ),
                            ),
                            SizedBox(
                                width: Screen.size.width,
                                height: 50,
                                child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Text color
                                      backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 48, 95, 215).withOpacity(0.8)),
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Border radius
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(Icons.edit),
                                    label: Text("Edit Profile",style:TextStyle(fontSize: Fonts.sm(), color: MainColors.white,)),
                                    onPressed: () {
                                      setState(() {
                                        _isClosed = true;
                                      });
                                    }))],),)]):
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            SizedBox(
                              width: Width.xxl() * 0.88,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                cursorColor: MainColors.black,
                                style: GoogleFonts.mada(
                                  color: MainColors.black,
                                  fontSize: Fonts.md(),
                                ),
                                controller: _fName,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  hintStyle: GoogleFonts.mada(
                                    color: MainColors.black,
                                    fontSize: Fonts.md(),
                                  ),
                                  hintText: 'Enter First Name',
                                  label: const Text("First Name"),
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
                                    return 'Please Enter Your First Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: Width.xxl() * 0.88,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                cursorColor: MainColors.black,
                                style: GoogleFonts.mada(
                                  color: MainColors.black,
                                  fontSize: Fonts.md(),
                                ),
                                controller: _lName,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  hintStyle: GoogleFonts.mada(
                                    color: MainColors.black,
                                    fontSize: Fonts.md(),
                                  ),
                                  hintText: 'Enter Last Name',
                                  label: const Text("Last Name"),
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
                                    return 'Please Enter Your Last Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Transform.translate(
                                offset: Offset(Width.x5s(), Height.x3s()),
                                child: Row(
                                  children: [
                                    CustomButton(
                                        width: ButtonWidth.xxl(),
                                        height: ButtonHeights.s3_1m(),
                                        hasGradient: true,
                                        gradientColors: const [
                                          Color.fromARGB(255, 48, 95, 215),
                                          Color.fromARGB(255, 48, 95, 215)
                                        ],
                                        hasImage: true,
                                        imagePath:
                                            "assets/image/loginBackground.png",
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
                                        fontSize:Fonts.s3m(),
                                        textColor: MainColors.white,
                                        onPressed: () async {
                                          User user = User(id: widget.profileID, email: widget.userEmail , firstName: _fName.text,lastName: _lName.text);
                                          await userApi.updateMe(user);
                                          setState(() {
                                            _changed = true;
                                            _isClosed = false;
                                          });
                                        }),
                                    Transform.translate(
                                      offset: Offset(Width.x3s(), Height.x5s()),
                                      child: CustomButton(
                                          width: ButtonWidth.xxl(),
                                          height: ButtonHeights.s3_1m(),
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
                                          fontSize: Fonts.s3m(),
                                          textColor: MainColors.white,
                                          onPressed: () {
                                            setState(() {
                                              _isClosed = false;
                                            });
                                          }),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Transform.translate(
                  offset: Offset(-Width.s7m(), 0),
                  child: Text("Repairs Configuration",
                      style: GoogleFonts.rubik(
                          fontSize: Fonts.md(), color: MainColors.black)),
                ),
                const SizedBox(height: 10),
                Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                    child:Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Border radius for the image
                        child: Opacity(
                          opacity: 0.7, // Adjust opacity as needed
                          child: Image.asset(
                            'assets/image/loginBackground.png', // Replace with your image asset path
                            fit: BoxFit.cover,
                            width: double.infinity, // Make sure the image covers the button area
                            height: 50, // Adjust height as needed for the button size
                          ),
                        ),
                      ),
                      SizedBox(
                    width: Screen.size.width,
                        height: 50,
                        child: ElevatedButton.icon(
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Text color
                              backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 48, 95, 215).withOpacity(0.8)),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Border radius
                                ),
                              ),
                            ),
                            label: Text("Edit Repairs Configuration",style:TextStyle(fontSize: Fonts.sm(), color: MainColors.white,)),
                            onPressed: () {}))],),),
                const SizedBox(height: 15),
                Transform.translate(
                  offset: Offset(-Width.s9m(), 0),
                  child: Text("Account Settings",
                      style: GoogleFonts.rubik(
                          fontSize: Fonts.md(), color: MainColors.black)),
                ),
                const SizedBox(height: 10),
                Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                  child:
                    Container(
                        width: Screen.size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: MainColors.danger.withOpacity(0.5)), // Red border
                          borderRadius: BorderRadius.circular(CustomRadius.md()),
                        ),
                        child: ElevatedButton.icon(
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Text color
                              backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 254, 246, 254)),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Border radius
                                ),
                              ),
                            ),
                            icon:  Icon(Icons.delete_rounded,color: MainColors.danger.withOpacity(0.5)),
                            label: Text("Delete My Account",style:TextStyle(fontSize: Fonts.sm(), color: MainColors.danger.withOpacity(0.5),)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeleteAccount(
                                          upComingChecks: widget.upComingChecks,
                                          profileID: widget.profileID,
                                          myCars: widget.myCars,
                                          userEmail: widget.userEmail ,
                                          userLastName: widget.userLastName ,
                                          userName:widget.userName,
                                          isSub: widget.isSub,
                                          carIndex: widget.carIndex,
                                          costs: widget.costs,
                                          date:widget.date ,
                                          itemsNumber: widget.itemsNumber,
                                          liters: widget.liters,
                                          petrolName: widget.petrolName,
                                        )),
                              );
                            }),),),
              ],
            ),
          ),
        ],
      ),
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
            padding: const EdgeInsets.fromLTRB(3, 10, 20, 10),
            child: Row(
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
                              builder: (context) =>
                                  CarSelectedPage(
                                    upComingChecks: widget.upComingChecks,
                                    myCars: widget.myCars,
                                    userLastName:_changed?_lName.text: widget.userLastName,
                                    userEmail: widget.userEmail,
                                    userName:_changed?_fName.text:widget.userName,
                                    currentIndex: widget.carIndex,
                                    costs: widget.costs,
                                    date:widget.date ,
                                    itemsNumber: widget.itemsNumber,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                    profileID: widget.profileID,
                                  )),
                        );
                      },
                      title: "Dashboard",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.directions_car_filled,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: NavButton(
                      hasIcon: false,
                      buttonImage: "assets/customIcons/garage.png",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarList(
                                    upComingChecks: widget.upComingChecks,
                                    profileID: widget.profileID,
                                    myCars: widget.myCars,
                                    userLastName: widget.userLastName,
                                    userEmail: widget.userEmail,
                                    userName:widget.userName,
                                    isSub: widget.isSub,
                                    carIndex: widget.carIndex,
                                    costs: widget.costs,
                                    date:widget.date ,
                                    itemsNumber: 0,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                    currentIndex: widget.carIndex,
                                  )),
                        );
                      },
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarGasPage(
                                    upComingChecks: widget.upComingChecks,
                                    profileID: widget.profileID,
                                    myCars: widget.myCars,
                                    userLastName: widget.userLastName,
                                    userEmail: widget.userEmail,
                                    userName:widget.userName,
                                    isSub: widget.isSub,
                                    carIndex: widget.carIndex,
                                    onPressed: (){},
                                    costs: widget.costs,
                                    date:widget.date ,
                                    itemsNumber: widget.itemsNumber,
                                    liters: widget.liters,
                                    petrolName: widget.petrolName,
                                  )),
                        );
                      },
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
                      onPressed: () {},
                      title: "Settings",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.settings,
                      currentColor: const Color.fromARGB(255, 42, 87, 208),
                      currentBorderColor:
                          const Color.fromARGB(255, 42, 87, 208),
                    )),
              ],
            ),
          ),
        ),
      )
    );
  }
}
