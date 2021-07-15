import 'package:ccd_quiz_flutter/model/model_quiz.dart';
import 'package:ccd_quiz_flutter/screen/screen_home.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.answers, required this.quizzes})
      : super(key: key);
  final List<int> answers;
  final List<Quiz> quizzes;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    int score = 0;

    for (int i = 0, loopCnt = quizzes.length; i < loopCnt; i++) {
      if (quizzes[i].answer == answers[i]) score += 1;
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.deepPurple,
              ),
              width: width * 0.85,
              height: height * 0.5,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(bottom: width * 0.048)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white,
                    ),
                    width: width * 0.7,
                    height: height * 0.25,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            width * 0.048,
                            0,
                            width * 0.012,
                          ),
                          child: Text(
                            '수고하셨습니다!',
                            style: TextStyle(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '당신의 점수는',
                          style: TextStyle(
                            fontSize: width * 0.048,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          '$score/${quizzes.length}',
                          style: TextStyle(
                            fontSize: width * 0.21,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(width * 0.012))
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                    child: ButtonTheme(
                      minWidth: width * 0.73,
                      height: height * 0.05,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        child: Text(
                          '홈으로 돌아가기',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
