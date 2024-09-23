import 'package:clay_containers/widgets/clay_container.dart';
import 'package:dictionaryenglish/constants/colors.dart';
import 'package:flutter/material.dart';

Widget cardType(String partOfSpeech, String meanings, String textSynonims,
    String textAntonyms, String example) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(15),
    child: ClayContainer(
      spread: 3,
      borderRadius: 10,
      color: backgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              partOfSpeech,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: primaryColor,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Definition: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                          TextSpan(
                            text: meanings,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,

                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Synonyms: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                          TextSpan(
                            text: textSynonims,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,

                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Antonyms ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                          TextSpan(
                            text: textAntonyms,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,

                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Example: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                          TextSpan(
                            text: example,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,

                              // Otros estilos que desees aplicar al texto en negrita
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    ),
  );
}
