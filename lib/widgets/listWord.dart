import 'package:audioplayers/audioplayers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:dictionaryenglish/class/Word.dart';
import 'package:dictionaryenglish/constants/colors.dart';
import 'package:dictionaryenglish/widgets/viewData.dart';
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

Widget listWord(Word wordData, BuildContext context) {
  AudioPlayer audioPlayer = AudioPlayer();
  late Source audioUrl;

  Future<void> playSound(String url) async {
    audioUrl = UrlSource(url);
    await audioPlayer.play(audioUrl);
  }

  return Container(
    padding: EdgeInsets.all(5),
    child: ListView(
      children: [
        Center(
            child: UnityBannerAd(
          placementId: "Banner_Android",
        )),
        Center(
            child: Text(
          wordData.word,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
        )),
        Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      playSound(wordData.phonetics);
                    },
                    child: ClayContainer(
                      height: 50,
                      width: 50,
                      color: backgroundColor,
                      spread: 3,
                      borderRadius: 10,
                      child: Icon(Icons.play_arrow),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ClayContainer(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 50,
                      color: backgroundColor,
                      spread: 3,
                      borderRadius: 10,
                      child: Center(child: Text("Play Sound")),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          children: obtenerListaDeWidgets(wordData),
        ),
        SizedBox(
          height: 25,
        )
      ],
    ),
  );
}
