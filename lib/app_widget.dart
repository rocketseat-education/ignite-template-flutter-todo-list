import 'package:flutter/material.dart';

import 'home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ignite Flutter | ToDo App',
      home: SafeArea(
        child: HomePage(),
      ),
    );
  }
}
