import 'dart:convert';
import 'package:http/http.dart';
import '../model/item.dart';
import 'package:flutter/material.dart';

import 'itemView.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isPressed = false;

  Future<List<ItemModel>> _fetchItem() async {
    final uri = 'http://prishtinatask.scoopandspoon.at/api/flutter.php';
    final response = await get(
      Uri.parse(uri),
    );

    var mapResponse = json.decode(response.body);
    List<ItemModel> itemList = [];
    for (int i = 0; i < mapResponse.values.toList().length - 1; i++) {
      var item = ItemModel.fromJson(
          mapResponse.values.toList()[i] as Map<String, dynamic>);

      itemList.add(item);
    }
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<ItemModel>>(
          future: _fetchItem(),
          builder: (
            context,
            snapshot,
          ) {
            print('builder');
            return Container(
              color: Colors.white54,
              child: snapshot.hasData
                  ? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 13,
                                        mainAxisSpacing: 30),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext ctx, i) {
                                  return InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) =>  ItemDetail(),
                                      // );
                                      print('next screen');
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${snapshot.data![i].id}. ${snapshot.data![i].name}',
                                        style: TextStyle(
                                            color: isPressed
                                                ? Colors.white
                                                : Colors.white70,
                                            fontSize: 25),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    )
                  : snapshot.hasError
                      ? Center(
                          child: Text('Something went wrong'),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
            );
          }),
    );
  }
}
