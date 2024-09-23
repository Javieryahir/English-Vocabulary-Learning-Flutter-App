import 'dart:math';

import 'package:clay_containers/clay_containers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dictionaryenglish/adsManager.dart';
import 'package:dictionaryenglish/constants/colors.dart';
import 'package:dictionaryenglish/pages/learnPage.dart';
import 'package:dictionaryenglish/pages/listWordPage.dart';
import 'package:dictionaryenglish/pages/searchPage.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: handlerWidget(selectedIndex),
      bottomNavigationBar: SizedBox(
        child: CurvedNavigationBar(
          height: 75,
          color: primaryColor,
          backgroundColor: backgroundColor,
          items: <Widget>[
            ClayContainer(
                spread: 1,
                borderRadius: 25,
                color: primaryColor,
                height: 50,
                width: 50,
                child: Icon(Icons.search, size: 30)),
            ClayContainer(
                spread: 1,
                borderRadius: 25,
                color: primaryColor,
                height: 50,
                width: 50,
                child: Icon(Icons.list, size: 30)),
            ClayContainer(
                spread: 1,
                borderRadius: 25,
                color: primaryColor,
                height: 50,
                width: 50,
                child: Icon(Icons.school, size: 30)),
          ],
          onTap: (index) async {
            final random = Random();
            final num =
                random.nextDouble(); // Generar un número aleatorio entre 0 y 1

            if (num < 0.20) {
              // Comprobar si el número aleatorio es menor que la probabilidad dada
              await AdManager
                  .showIntAd(); // Ejecutar la otra función si el número aleatorio es menor que la probabilidad
            }
            setState(() {});
            selectedIndex = index;
          },
        ),
      ),
    );
  }
}

Widget handlerWidget(int index) {
  if (index == 0) {
    return searchPage();
  } else if (index == 1) {
    return listWordPage();
  } else {
    return learnPage();
  }
}
