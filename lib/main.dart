import 'package:fetchingdata/beer.dart';
import 'package:fetchingdata/second.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Beer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Beer>> getAllBeers() async{
    var response = await http.get(Uri.https('api.punkapi.com','v2/beers'));
    if(response.statusCode==200){
      var beers = (json.decode(response.body) as List)
          .map((beer) => Beer.fromJson(beer)).toList();
      return beers;
    }else{
      throw Exception('Could not load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                    return Card(
                      child:
                        ListTile(
                          onTap: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=> MySecond(id: data[index].id,)));
                          },
                          title: Text(
                            data[index].name,
                            style: const TextStyle(color: Colors.blue),
                          ),
                          subtitle: Text(data[index].description ,maxLines: 2,),
                          leading: Image.network(data[index].imageUrl),
                          isThreeLine: true,
                        ),
                    );
                  }
                  );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      )
    );
  }
}
