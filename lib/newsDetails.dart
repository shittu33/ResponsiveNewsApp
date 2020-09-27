import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/responsive.dart';

class DetailsScreen extends StatefulWidget {
  final String newsUrl;

  DetailsScreen({@required this.newsUrl});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Detailed",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(
                  color: Colors.grey[200], fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(opacity: 0),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.share,
              ))
        ],
//        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: EasyWebView(
          src: widget.newsUrl,
//            convertToWidgets: true,
          onLoaded: () {
            print("Loaded");
          },
          height: MediaQuery.of(context).size.height,
          width: calcWebWidth(context),
        ),
      ),
    );
  }
}

double calcWebWidth(BuildContext context) {
  var deviceWidth = MediaQuery.of(context).size.width;
  return Responsive.isLargeScreen(context)
      ? deviceWidth / 2
      : Responsive.isExtraLargeScreen(context)
          ? deviceWidth / 1.4
          : deviceWidth;
}

class TestScreen extends StatelessWidget {
  Future<String> fetchStudent() async {
    final response = await http
        .get('https://abdulmujeeb-nodejs-news.herokuapp.com/news'
<<<<<<< Updated upstream
<<<<<<< Updated upstream
//
=======
=======
>>>>>>> Stashed changes
//        , headers: {
//      'Content-Type': 'application/json',
//      'Access-Control-Allow-Credentials': 'true', 
//      'Access-Control-Allow-Origin': '*'
//    }
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body).toString();
//      List<dynamic> data = json['documents'];
//      return data.map((student) => Student.fromJson(student)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: fetchStudent(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Text(snapshot.data);
          else {
            return CircularProgressIndicator();
          }
        });
  }
}
