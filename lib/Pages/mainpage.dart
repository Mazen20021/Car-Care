import 'package:carcare/Components/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Config/constants.dart';


class MainMenuPage extends StatefulWidget
{
  final String userName;
  final int currentIndex;
  const MainMenuPage({required this.userName,required this.currentIndex,super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}
class _MainPage extends State<MainMenuPage>
{
  final bool _isSub = false;
  final bool _isCarSelected = false;
  final List<String> imagesPath = List<String>.empty(growable: true);
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 2.0 , initialPage: widget.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    imagesPath.add("assets/cars/Coupe.png");
    imagesPath.add("assets/cars/Hatchback.png");
    imagesPath.add("assets/cars/Sedan.png");
    imagesPath.add("assets/cars/SUV.png");
    Screen.setSize(context);
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 48),
        Row(children: [
          const SizedBox(width: 20),
          Text("Welcome Back,",style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          fontSize: Fonts.sm(),),
        ),
          const SizedBox(width: 10),
          Text(widget.userName,style: GoogleFonts.rubik(
            fontWeight: FontWeight.bold,
            color: MainColors.primary,
          fontSize: Fonts.sm(),),
          ),
        ],),
       const SizedBox(height: 5),
       Row(children: [const SizedBox(width: 20), !_isSub ?Text("Free Trial Plan",style: GoogleFonts.rubik(
          color: const Color.fromARGB(255, 182, 182, 182),
          fontSize: Fonts.sm(),
        ),) :const Text("")],),
        const SizedBox(height: 20),
        !_isCarSelected?
        GestureDetector(
          onTap: (){},
            child: Stack(
          children: [
            Opacity(
              opacity: 0.30,
              child: SizedBox(
                width: Screen.size.width * 0.9,
                height: Screen.size.height * 0.25,
                child:Transform.translate(
                  offset: const Offset(
                  75, 0),
                  child: const Image(
                  image: AssetImage("assets/cover.png"),
                  fit: BoxFit.cover,
                ),
              )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(50, 30),
                child: Text("Click To Add Car",style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  color: MainColors.white,
                  fontSize: Fonts.md(),
                shadows: [const Shadow(color: MainColors.black,blurRadius: 25 ,offset: Offset(0, 2))])
                )),
              Container(
                width: Screen.size.width,
                height: Screen.size.height * 0.5,
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(10, -102),
                  child: Transform.scale(
                      scale: 1.35, // Zoom in the image by 1.5x
                      child:
                      const Image(
                        image: AssetImage("assets/cars/NoCar.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              ),
                const SizedBox(height: 5),
                Row(children: [
                  GestureDetector(
                      onTap: (){},
                      child: Transform.translate(
                      offset: const Offset(40, -250),
                      child: Text("View online reports", style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      color:!_isCarSelected? MainColors.primary.withOpacity(0.5) : MainColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: MainColors.primary,
                      fontSize: Fonts.xs())))),
                  GestureDetector(
                        onTap: (){},
                        child: Transform.translate(
                        offset: const Offset(100, -250),
                        child: Text("View check log", style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        color: !_isCarSelected? MainColors.primary.withOpacity(0.5): MainColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: MainColors.primary,
                        fontSize: Fonts.xs())))),
                ],),
                Transform.translate(
                    offset: const Offset(20, -150),
                    child:Container(
                      width: Screen.size.width * 0.8,
                      height: Height.sm(),
                      color: MainColors.primaryLight,
                    )),
              ],
            ),
          ],
        )):GestureDetector(
          onTap: () {},
          child: Stack(
            children: [Opacity(
                opacity: 1,
                child: SizedBox(
                  width: Screen.size.width * 0.9,
                  height: Screen.size.height * 0.25,
                  child: Transform.translate(
                    offset: const Offset(75, 0),
                    child:Container(
                      decoration: BoxDecoration(
                        color: MainColors.primary,
                          borderRadius: BorderRadius.circular(30),
                          image:const DecorationImage(
                            image: AssetImage("assets/cover.png"),
                            opacity: 0.1,
                            fit: BoxFit.cover,
                          ),),),
              ))),
              SizedBox(
                height: Screen.size.height * 0.68, // Adjust height for images
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesPath.length,
                  itemBuilder: (context, index) {
                    return buildCarImage(imagesPath[index], Screen.size);
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(180, 20),
                child:Row(children: [ Text("Name",style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    color: MainColors.white,
                    fontSize: Fonts.md(),
                    shadows: [const Shadow(color: MainColors.black,blurRadius: 25 ,offset: Offset(0, 2))])),
                  const SizedBox(width: 25),
                   Icon(Icons.error_rounded,color: MainColors.white,size: Width.xs(),),
                  const SizedBox(width: 10),
                  Text("Data",style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      color: MainColors.white,
                      fontSize: Fonts.sm(),
                      shadows: [const Shadow(color: MainColors.black,blurRadius: 25 ,offset: Offset(0, 2))]))
                ],),
              ),
            ],
          ),
        ),
    ]));
  }
  // Helper method to build each car image
  Widget buildCarImage(String imagePath, Size screenSize) {
    return Container(
      width: screenSize.width, // Occupy full width
      height: screenSize.height * 0.68, // Adjust to desired height
      alignment: Alignment.center,
      child: Transform.translate(
        offset: const Offset(10, -140),
    child:
    Transform.scale(
    scale: 0.65,
        child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    )));
  }
}

