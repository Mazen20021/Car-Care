import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'Config/constants.dart';
import 'Pages/login_page.dart';


void main() {
  runApp( MainPage());
}

class MainPage extends StatelessWidget {
   MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initLocalStorage();
      Screen.setSize(context);
    });
    return MaterialApp(home: Login());
  }
}
