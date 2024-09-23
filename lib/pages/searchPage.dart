import 'dart:math';

import 'package:clay_containers/clay_containers.dart';
import 'package:dictionaryenglish/adsManager.dart';
import 'package:dictionaryenglish/apiGet/apiFunction.dart';
import 'package:dictionaryenglish/class/Word.dart';
import 'package:dictionaryenglish/constants/colors.dart';
import 'package:dictionaryenglish/widgets/alertSave.dart';
import 'package:dictionaryenglish/widgets/listWord.dart';

import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  Future<Word>? wordData;
  Word? changeData;
  int checker = 0;
  Widget widgetToShow = Container();
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: widgetToShow,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 5,
          centerTitle: true,
          title: Text("Search Words",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 25, color: textColor)),
          bottom: PreferredSize(
              preferredSize: Size(2, 80),
              child: Center(
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0,
                                top: 16.0),
                            child: ClayContainer(
                                borderRadius: 10,
                                color: primaryColor,
                                width: MediaQuery.of(context).size.width * 0.75,
                                emboss: true,
                                spread: 2,
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    border: InputBorder.none,
                                  ),
                                )),
                          )),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {});
                          final random = Random();
                          final num = random
                              .nextDouble(); // Generar un número aleatorio entre 0 y 1

                          if (num < 0.10) {
                            // Comprobar si el número aleatorio es menor que la probabilidad dada
                            await AdManager
                                .showIntAd(); // Ejecutar la otra función si el número aleatorio es menor que la probabilidad
                          }
                          String wordSearch = _controller.text;

                          wordData = fetchData(
                              "https://api.dictionaryapi.dev/api/v2/entries/en/${wordSearch}");

                          changeData = await wordData;

                          if (changeData!.word != "Error") {
                            setState(() {});

                            widgetToShow = FloatingButton(
                              wordEnglish: changeData!.word,
                              defintion: changeData!.meanings[0].meanings,
                            );
                          } else {
                            setState(() {});
                            widgetToShow = Container();
                          }
                        },
                        child: Container(
                          child: ClayContainer(
                              borderRadius: 25,
                              width: 50,
                              height: 50,
                              color: accentColor,
                              spread: 2,
                              child: Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        body: FutureBuilder<Word>(
          future: wordData,
          builder: (BuildContext context, AsyncSnapshot<Word> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: accentColor,
              ));
            } else if (snapshot.hasData) {
              Word listWords = snapshot.data!;

              if (listWords.word == "Error") {
                return Center(
                    child: ClayContainer(
                        width: 130,
                        height: 50,
                        spread: 3,
                        borderRadius: 10,
                        color: primaryColor,
                        child: Center(
                            child: Text(
                          "Word Not Found!",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))));
              } else {}

              return listWord(listWords, context);
            } else {
              return Center(
                  child: ClayContainer(
                      width: 120,
                      height: 50,
                      spread: 3,
                      borderRadius: 10,
                      color: primaryColor,
                      child: Center(
                          child: Text(
                        "Search a Word",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ))));
            }
          },
        ));
  }
}
