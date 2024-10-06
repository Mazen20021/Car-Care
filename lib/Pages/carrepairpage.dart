import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Config/constants.dart';

class CarRepairPage extends StatelessWidget
{
  final int carIndex;
  CarRepairPage({required this.carIndex,super.key});
  final List<String> imagesPath = List<String>.empty(growable: true);
  late final PageController _pageController;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:SingleChildScrollView(child: Column(children: [
       const SizedBox(height: 48),
       Row(children: [
         const SizedBox(width: 80),
         Text("Add A Car Repair",style: GoogleFonts.rubik(
           fontWeight: FontWeight.bold,
           fontSize: Fonts.sm(),),
         ),
       ],),
       const SizedBox(height: 20),
       Stack(
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
       const SizedBox(height: 5),

             ],
           ),
         ),
   );
  }
  }
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
