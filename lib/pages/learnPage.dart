import 'package:clay_containers/clay_containers.dart';
import 'package:dictionaryenglish/class/Item.dart';
import 'package:dictionaryenglish/constants/colors.dart';

import 'package:dictionaryenglish/db/dbMain.dart';
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class learnPage extends StatefulWidget {
  const learnPage({super.key});

  @override
  State<learnPage> createState() => _learnPageState();
}

class _learnPageState extends State<learnPage> {
  List<Item> tareasma = [];
  TextEditingController controller1 = TextEditingController();

  List<Item> _questions = [];
  int _currentIndex = 0;
  String _userAnswer = "";
  String frasedefault = "Cargando";

  @override
  void initState() {
    cargarTareas();
    super.initState();
  }

  cargarTareas() async {
    List<Item> itemAwait = await DB.readItem();
    itemAwait.shuffle();

    setState(() {
      tareasma = itemAwait;
    });
    if (_questions == null) {
      for (int i = 0; i < 10; i++) {
        _questions.add(
          Item(
            questionDefinition: tareasma[i].questionDefinition,
            answerWord: tareasma[i].answerWord,
          ),
        );
      }
    }

    if (_questions == null || _questions.isEmpty) {
      frasedefault = "Cargando";
    } else {
      if (_currentIndex >= 0 && _currentIndex < _questions.length) {
        frasedefault = _questions[_currentIndex].questionDefinition;
      } else {
        // Manejar el caso en el que _currentIndex está fuera del rango válido
        frasedefault = "Índice fuera de rango";
      }
    }
  }

  void _submitAnswer() {
    controller1.text = "";
    if (_userAnswer.toLowerCase() ==
        _questions[_currentIndex].answerWord.toLowerCase()) {
      // Si la respuesta del usuario es correcta, avanzamos a la siguiente pregunta
      if (_currentIndex >= 0 && _currentIndex < _questions.length - 1) {
        _currentIndex++;
        frasedefault = _questions[_currentIndex].questionDefinition;
      } else {
        _currentIndex = 0;
        frasedefault = _questions[_currentIndex].questionDefinition;
      }
      setState(() {});
    } else {
      // Si la respuesta del usuario es incorrecta, mostramos un mensaje de error
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Personaliza el radio aquí
                ),
                backgroundColor: primaryColor,
                title: Text("Answer Incorrect"),
                content: Text(
                    "The correct answer is ${_questions[_currentIndex].answerWord}"),
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                        if (_currentIndex >= 0 &&
                            _currentIndex < _questions.length - 1) {
                          _currentIndex++;

                          frasedefault =
                              "${_currentIndex + 1}. ${_questions[_currentIndex].questionDefinition}";
                        } else {
                          _currentIndex = 0;
                          frasedefault =
                              "${1}.${_questions[_currentIndex].questionDefinition}";
                        }
                      },
                      child: ClayContainer(
                          spread: 3,
                          borderRadius: 10,
                          color: primaryColor,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "OK",
                              style: TextStyle(color: textColor),
                            ),
                          )))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 5,
        toolbarHeight: 70.0,
        centerTitle: true,
        title: Text("Learn",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 25, color: textColor)),
      ),
      body: frasedefault == 'Cargando'
          ? Center(
              child: ClayContainer(
                  width: 130,
                  height: 50,
                  spread: 3,
                  borderRadius: 10,
                  color: primaryColor,
                  child: Center(
                      child: Text(
                    "Add 10 Words",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ))))
          : Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: ListView(
                  children: [
                    Center(
                        child: UnityBannerAd(
                      placementId: "Banner_Android",
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      child: ClayContainer(
                        spread: 3,
                        borderRadius: 10,
                        color: primaryColor,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${frasedefault}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    ClayContainer(
                        borderRadius: 10,
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width * 0.75,
                        emboss: true,
                        spread: 4,
                        child: TextField(
                          style: TextStyle(fontSize: 24.0),
                          maxLines: 1,
                          controller: controller1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(height: 40.0),
                    Container(
                        child: ElevatedButton(
                      onPressed: _submitAnswer,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Send",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,
                            ),
                          )),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Ajusta el valor según sea necesario
                          ),
                          elevation: 5,
                          primary: primaryColor),
                    )),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
