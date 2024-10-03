import 'package:flutter/material.dart';

class Signup extends StatefulWidget
{
  final userName;
  const Signup({required this.userName ,super.key});

  _signup createState() => _signup();
}
class _signup extends State<Signup>
{
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(elevation: 20,title: Center(child: Text("Welocome to Signup"),),automaticallyImplyLeading: false,),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Text("${widget.userName} ",style: TextStyle(fontSize: 50),),
        SizedBox(height: 10),
        ElevatedButton(onPressed: (){

        }, child: Text("Press Me" ,style: TextStyle(fontSize: 60),))

      ],)
      
      ),
    );
  }
}