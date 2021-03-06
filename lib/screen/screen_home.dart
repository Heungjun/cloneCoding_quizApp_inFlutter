import 'package:ccd_quiz_flutter/model/api_adapter.dart';
import 'package:ccd_quiz_flutter/model/model_quiz.dart';
import 'package:ccd_quiz_flutter/screen/screen_quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Quiz> quizzes = [];
  bool isLoading = false;

  _fetchQuizzes() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri(path: 'https://drf-quiz-test-yhj.herokuapp.com/quiz/3/'));
    if (response.statusCode == 200) {
      setState(() {
        quizzes = parseQuizzes(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      throw Exception('failed to load data');
    }
  }

  // List<Quiz> quizzes = [
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  // ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('images/quiz.jpeg'),
              ),
              Padding(padding: EdgeInsets.all(width * 0.024)),
              Text(
                '????????? ?????? ???',
                style: TextStyle(
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '????????? ?????? ??? ?????????????????????.\n????????? ?????? ?????? ????????? ???????????????.',
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(width * 0.048)),
              _buildStep(width, '1. ???????????? ????????? ?????? 3?????? ???????????????.'),
              _buildStep(width, '2. ????????? ??? ?????? ????????? ?????? ???\n??????  ?????? ????????? ???????????????.'),
              _buildStep(width, '3. ????????? ?????? ??????????????????!'),
              Padding(padding: EdgeInsets.all(width * 0.048)),
              Container(
                padding: EdgeInsets.only(bottom: width * 0.036),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width * 0.8,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      child: Text(
                        '?????? ?????? ??????',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: width * 0.036)),
                              Text('?????? ???....'),
                            ],
                          ),
                        ));
                        _fetchQuizzes().whenComplete(() {
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuizScreen(quizzes: quizzes)),
                          );
                        });
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepPurple),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.048,
        width * 0.024,
        width * 0.048,
        width * 0.024,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(padding: EdgeInsets.only(right: width * 0.024)),
          Text(title),
        ],
      ),
    );
  }
}
