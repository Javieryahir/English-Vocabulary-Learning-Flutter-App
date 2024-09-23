import 'dart:convert';
import 'package:dictionaryenglish/class/Word.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Word> fetchData(String url) async {
  Word wordObject = Word(word: "Error", phonetics: "Error", meanings: []);
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Successful request
      final List<dynamic> data = json.decode(response.body);
      final Map<String, dynamic> wordData = data[0];
      final Word wordSucessful = parseWord(wordData);

      wordObject = wordSucessful;

      // Process the data as needed
    } else {
      // Request failed
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle errors
    print('Error: $error');
  }

  return Future.value(wordObject);
}

List<Meaning> parseMeanings(dynamic meaningsData) {
  List<Meaning> meanings = [];
  for (int index = 0; index < meaningsData.length; index++) {
    meanings.add(
      Meaning(
          partOfSpeech: meaningsData[index]["partOfSpeech"] ?? "No data",
          meanings:
              meaningsData[index]["definitions"][0]["definition"] ?? "No data",
          example:
              meaningsData[index]["definitions"][0]["example"] ?? "No data",
          synonyms: meaningsData[index]["synonyms"] ?? "No data",
          antonyms: meaningsData[index]["antonyms"] ?? "No data"),
    );
  }
  return meanings;
}

String getAudioUrl(dynamic phonetics) {
  if (phonetics[0]["audio"] == "") {
    return phonetics[1]["audio"];
  } else {
    return phonetics[0]["audio"];
  }
}

List<Meaning> extractMeanings(dynamic wordData) {
  List<Meaning> itemsMeaning = [];
  if (wordData.containsKey("meanings")) {
    itemsMeaning = parseMeanings(wordData["meanings"]);
  }
  return itemsMeaning;
}

Word parseWord(dynamic wordData) {
  String audio = getAudioUrl(wordData["phonetics"]);
  List<Meaning> itemsMeaning = extractMeanings(wordData);

  return Word(
    word: wordData["word"],
    phonetics: audio,
    meanings: itemsMeaning,
  );
}
