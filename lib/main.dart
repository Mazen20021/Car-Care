import 'package:carcare/Pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Login());
}
