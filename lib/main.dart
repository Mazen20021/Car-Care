import 'package:carcare/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'Config/constants.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initLocalStorage();
      Screen.setSize(context);
    });
    return const MaterialApp(home: Login());
  }
}
