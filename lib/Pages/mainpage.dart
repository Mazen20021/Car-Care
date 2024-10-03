import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Config/constants.dart';


class MainMenuPage extends StatefulWidget
{
  final String userName;
  const MainMenuPage({required this.userName,super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}
class _MainPage extends State<MainMenuPage>
{
  final bool _isSub = false;
  final bool _isCarSelected = false;

  @override
  Widget build(BuildContext context) {
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
          onTap: (){

          },
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
              ],
            ),
          ],
        )):
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
                  ],
                ),
              ],
            ))
      ],),

    );
  }

}

