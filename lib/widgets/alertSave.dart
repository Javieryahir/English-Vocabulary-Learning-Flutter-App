import 'dart:math';

import 'package:clay_containers/clay_containers.dart';
import 'package:dictionaryenglish/adsManager.dart';
import 'package:dictionaryenglish/class/Item.dart';
import 'package:dictionaryenglish/constants/colors.dart';
import 'package:dictionaryenglish/db/dbMain.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  String wordEnglish = "";
  String defintion = "";

  FloatingButton({required this.wordEnglish, required this.defintion});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    late TextEditingController controllerWord =
        TextEditingController(text: widget.wordEnglish);
    late TextEditingController controllerDefinition =
        TextEditingController(text: widget.defintion);
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Personaliza el radio aquí
          ),
          backgroundColor: primaryColor,
          title: const Text('Save Word'),
          content: Container(
            height: 200,
            width: 100,
            child: ListView(
              children: [
                Container(
                    height: 80,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                      child: ClayContainer(
                          borderRadius: 10,
                          color: primaryColor,
                          emboss: true,
                          spread: 2,
                          child: TextField(
                            controller: controllerWord,
                            decoration: InputDecoration(
                              label: Text(
                                "Word",
                                style: TextStyle(color: textColor),
                              ),
                              contentPadding: EdgeInsets.all(5),
                              border: InputBorder.none,
                            ),
                          )),
                    )),
                Container(
                    height: 120,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      child: ClayContainer(
                          borderRadius: 10,
                          color: primaryColor,
                          emboss: true,
                          spread: 2,
                          child: TextField(
                            controller: controllerDefinition,
                            minLines: 3,
                            maxLines: 6,
                            decoration: InputDecoration(
                              label: Text(
                                "Definition",
                                style: TextStyle(color: textColor),
                              ),
                              contentPadding: EdgeInsets.all(5),
                              border: InputBorder.none,
                            ),
                          )),
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ClayContainer(
                borderRadius: 10,
                spread: 3,
                color: primaryColor,
                child: TextButton(
                  onPressed: () async {
                    final random = Random();
                    final num = random
                        .nextDouble(); // Generar un número aleatorio entre 0 y 1

                    if (num < 0.25) {
                      // Comprobar si el número aleatorio es menor que la probabilidad dada
                      await AdManager
                          .showIntAd(); // Ejecutar la otra función si el número aleatorio es menor que la probabilidad
                    }
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ClayContainer(
                borderRadius: 10,
                spread: 3,
                color: primaryColor,
                child: TextButton(
                  onPressed: () async {
                    final random = Random();
                    final num = random
                        .nextDouble(); // Generar un número aleatorio entre 0 y 1

                    if (num < 0.25) {
                      // Comprobar si el número aleatorio es menor que la probabilidad dada
                      await AdManager
                          .showIntAd(); // Ejecutar la otra función si el número aleatorio es menor que la probabilidad
                    }
                    // Si uno o ambos controladores están vacíos, asigna un valor predeterminado como "No data"
                    DB.insertItem(Item(
                      questionDefinition: controllerDefinition.text.isNotEmpty
                          ? controllerDefinition.text
                          : "No data",
                      answerWord: controllerWord.text.isNotEmpty
                          ? controllerWord.text
                          : "No data",
                    ));

                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: Icon(Icons.save),
    );
  }
}
