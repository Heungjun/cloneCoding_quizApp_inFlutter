import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:ccd_quiz_flutter/model/model_quiz.dart';
import 'package:ccd_quiz_flutter/screen/screen_result.dart';
import 'package:ccd_quiz_flutter/widget/widget_candidate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.quizzes}) : super(key: key);
  final List<Quiz> quizzes;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> _answers = [-1, -1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;
  SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Swiper(
              controller: _swiperController,
              itemCount: widget.quizzes.length,
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemBuilder: (context, index) =>
                  _buildQuizCard(widget.quizzes[index], width, height),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q${(_currentIndex + 1).toString()}.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container()),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _currentIndex == widget.quizzes.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                  answers: _answers, quizzes: widget.quizzes),
                            ),
                          );
                        },
                        child: Text('결과보기'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(color: Colors.white),
                          primary: Colors.deepPurple,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _answerState = [false, false, false, false];
                          _currentIndex += 1;
                          _swiperController.next();
                        },
                        child: Text('다음문제'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(color: Colors.white),
                          primary: Colors.deepPurple,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];

    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
            tap: () {
              setState(() {
                for (int j = 0; j < 4; j++) {
                  if (j == i) {
                    _answerState[j] = true;
                    _answers[_currentIndex] = j;
                  } else {
                    _answerState[j] = false;
                  }
                }
              });
            },
            text: quiz.candidates[i],
            index: i,
            width: width,
            answerState: _answerState[i]),
      );
      _children.add(Padding(
        padding: EdgeInsets.all(width * 0.024),
      ));
    }

    return _children;
  }
}
