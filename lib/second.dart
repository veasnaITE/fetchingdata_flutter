import 'dart:convert';

import 'package:fetchingdata/beer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MySecond extends StatefulWidget {
  var id;
  MySecond({super.key, this.id});

  @override
  State<MySecond> createState() => _MySecondState();
}

class _MySecondState extends State<MySecond> {
  Future<List<Beer>> getAllBeers() async {
    var response =
        await http.get(Uri.https('api.punkapi.com', 'v2/beers/${widget.id}'));
    if (response.statusCode == 200) {
      var beers = (json.decode(response.body) as List)
          .map((beer) => Beer.fromJson(beer))
          .toList();
      return beers;
    } else {
      throw Exception('Could not load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
        appBar: AppBar(
          title: Text("detail page"),
        ),
        body: Center(
          child: FutureBuilder(
            future: getAllBeers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 300,
                            child: Image.network(data[index].imageUrl),
                          ),
                          ListTile(
                            title: Text(
                              data[index].name,
                              style: const TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(
                              data[index].tagline,
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "Description",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(
                              data[index].description,
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "ABV",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(
                              '${data[index].abv}',
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "First Brewed",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(
                              data[index].firstBrewed,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.0),
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    "Food Pairing",
                                  ),
                                  for (var item in data[index].foodPairing)
                                    Text(
                                      '- $item',
                                    ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "Brewers Tips",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(
                              data[index].brewersTips,
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
