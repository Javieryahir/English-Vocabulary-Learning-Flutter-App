import 'package:clay_containers/clay_containers.dart';
import 'package:dictionaryenglish/class/Item.dart';
import 'package:dictionaryenglish/constants/colors.dart';
import 'package:dictionaryenglish/db/dbMain.dart';
import 'package:flutter/material.dart';

class listWordPage extends StatefulWidget {
  const listWordPage({super.key});

  @override
  State<listWordPage> createState() => _listWordPageState();
}

class _listWordPageState extends State<listWordPage> {
  List<Item> itemList = [];

  @override
  void initState() {
    cargarRutinas();
    super.initState();
  }

  cargarRutinas() async {
    List<Item> itemAwait = await DB.readItem();

    setState(() {
      itemList = itemAwait;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 5,
        toolbarHeight: 70.0,
        centerTitle: true,
        title: Text("List Words",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 25, color: textColor)),
      ),
      backgroundColor: backgroundColor,
      body: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Dismissible(
                background: Container(
                  color: accentColor,
                  child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) async {
                  DB.deleteItem(itemList[index]);

                  setState(() {
                    itemList.removeAt(index);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: ClayContainer(
                    color: primaryColor,
                    spread: 3,
                    borderRadius: 10,
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: textColor),
                        ),
                      ),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      title: Text(
                        itemList[index].answerWord,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      maintainState: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      collapsedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              top: 0, bottom: 10, left: 15, right: 10),
                          child: Text(
                            "Definition : ${itemList[index].questionDefinition}",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
