import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myflutterapplication/unsplashimage.dart';

class element extends StatefulWidget {
  const element({Key? key, required this.image}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final UnsplashImage image;

  @override
  State<element> createState() => _element();
}

class _element extends State<element> {

  @override
  void initState() {
    super.initState();
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
      body: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(widget.image.regularUrl!,fit: BoxFit.cover),
              ),

              Positioned(
                  top: 10,
                  left: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(side: BorderSide.none,borderRadius: BorderRadius.circular(60)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('<'),
                ),
              )

              ]
        )

      );
  }
}
