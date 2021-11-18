import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myflutterapplication/unsplashimage.dart';
import 'element.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Future<List<UnsplashImage>> unsplash;

  @override
  void initState() {
    super.initState();
  }

  Future<List<UnsplashImage>> fetchUnsplashImage() async {
    final apiKey = dotenv.env['API_KEY'];
    final response = await http
        .get(Uri.parse('https://api.unsplash.com/photos?per_page=50&client_id=$apiKey'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
       return List<UnsplashImage>.from(jsonDecode(response.body).map((i) => UnsplashImage.fromJson(i)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load UnsplashImage');
    }
  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(


            child: FutureBuilder<List<UnsplashImage>>(

              future: fetchUnsplashImage(), // async work

              builder: (BuildContext context,

                  AsyncSnapshot<List<UnsplashImage>> snapshot) {

                switch (snapshot.connectionState) {

                  case ConnectionState.waiting:

                    return const Center(

                      child: CircularProgressIndicator(color: Colors.black),

                    );

                  default:

                    if (snapshot.hasError && snapshot.data != null)

                      return Text('Error: ${snapshot.error}');

                    else {

                      return GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(snapshot.data!.length, (index) {
                          return Center(
/*
                              child:Image.network(snapshot.data![index].regularUrl!),
*/
                            child:GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => element(image: snapshot.data![index],)),
                                );
                              },
                              child:Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data![index].regularUrl!),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );

                    }

                }

              },

            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget View(){
  List<String> imageUrlListToDisplay = [
    "https://picsum.photos/id/1000/800/800",
    "https://picsum.photos/id/1005/800/800",
    "https://picsum.photos/id/1004/800/800"
  ];


  return Container(
    child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: imageUrlListToDisplay.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Image.network(imageUrlListToDisplay[index])
          );
        }
    )
  );
}