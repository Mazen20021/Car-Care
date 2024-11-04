import 'package:carcare/Pages/settings_page.dart';
import 'package:carcare/Services/APIs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/custom_button.dart';
import '../Config/constants.dart';
import '../Pages/car_selected_page.dart';

class DeleteAccount extends StatefulWidget {
  final bool isSub;
  final String userName;
  final int carIndex;
  final String petrolName;
  final String date;
  final String liters;
  final String costs;
  final int itemsNumber;
  final String userLastName;
  final String userEmail;
  final List<Cars> myCars;
  const DeleteAccount(
      {required this.isSub,
      required this.userName,
      required this.carIndex,
      required this.costs,
      required this.date,
      required this.liters,
      required this.petrolName,
      required this.itemsNumber,
        required this.userEmail , required this.userLastName,
        required this.myCars,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeleteAccount();
  }
}

class _DeleteAccount extends State<DeleteAccount> {
  late AuthActions aa;
  @override
  void initState()
  {
    aa = AuthActions(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SingleChildScrollView(
          child: Container(
              width: Screen.size.width,
              height: Screen.size.height,
              decoration: BoxDecoration(
                color: MainColors.danger.withOpacity(0.8),
              ),
              child: Column(children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "Delete My Account",
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
                          iconColor: MainColors.danger,
                          iconSize: 30,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings(
                                    myCars: widget.myCars,
                                    userEmail: widget.userEmail ,
                                    userLastName: widget.userLastName ,
                                        carIndex: widget.carIndex,
                                        userName: widget.userName,
                                        costs: widget.costs,
                                        date: widget.date,
                                        itemsNumber: widget.itemsNumber,
                                        liters: widget.liters,
                                        petrolName: widget.petrolName,
                                        isSub: widget.isSub,
                                      )),
                            );
                          }),
                    )
                  ],
                ),
                Column(children: [
                  const SizedBox(height: 80),
                  SizedBox(
                      width: Screen.size.width * 0.85,
                      height: Screen.size.height * 0.6,
                      child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(35)),
                              child: SingleChildScrollView(
                                  child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(children: [
                                        Transform.scale(
                                            scale: 0.8,
                                            child: const Image(
                                              image: AssetImage(
                                                  "assets/deleteAccount.png"),
                                              fit: BoxFit.cover,
                                            )),
                                        Text(
                                          "Delete My Account",
                                          style: GoogleFonts.rubik(
                                              color: Color.fromARGB(
                                                  255, 192, 8, 8),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Transform.translate(
                                            offset: const Offset(5, 5),
                                            child: Text(
                                                "If you deleted your account you will not be able to get it back",
                                                style: GoogleFonts.rubik())),
                                        Transform.translate(
                                          offset: const Offset(-16.5, 17),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: Screen.size.width * 0.425,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => Settings(
                                                                myCars: widget.myCars,
                                                                userEmail: widget.userEmail ,
                                                                userLastName: widget.userLastName ,
                                                                carIndex: widget.carIndex,
                                                                userName: widget.userName,
                                                                costs: widget.costs,
                                                                date: widget.date,
                                                                itemsNumber: widget.itemsNumber,
                                                                liters: widget.liters,
                                                                petrolName: widget.petrolName,
                                                                isSub: widget.isSub,
                                                              )),
                                                        );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(0),
                                                            bottomLeft: Radius.circular(35),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10),
                                                        child: Text(
                                                          "No Don't Delete",
                                                          style: GoogleFonts.rubik(
                                                            fontWeight: FontWeight.bold,
                                                            color: const Color.fromARGB(255, 133, 133, 133),
                                                            fontSize: Fonts.md(),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(0),
                                                  child: Container(
                                                    width: 0.5,
                                                    color: Colors.black, // Color of the divider
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Screen.size.width * 0.425,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      aa.deleteAccount();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 192, 9, 9),
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight: Radius.circular(35),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(20),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Yes, Delete",
                                                              style: GoogleFonts.rubik(
                                                                fontWeight: FontWeight.bold,
                                                                color: MainColors.white,
                                                                fontSize: Fonts.md(),
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
                                      ]))))))
                ])
              ])))
    ]));
  }
}
