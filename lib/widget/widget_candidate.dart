import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget {
  const CandWidget(
      {Key? key,
      required this.tap,
      required this.text,
      required this.index,
      required this.width,
      required this.answerState})
      : super(key: key);
  final VoidCallback tap;
  final String text;
  final int index;
  final double width;
  final bool answerState;

  @override
  _CandWidgetState createState() => _CandWidgetState();
}

class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    bool _answerState = widget.answerState;

    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(
        widget.width * 0.048,
        widget.width * 0.024,
        widget.width * 0.48,
        widget.width * 0.024,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        border: Border.all(color: Colors.deepPurple),
        color: _answerState ? Colors.deepPurple : Colors.white,
      ),
      child: InkWell(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.width * 0.035,
            color: _answerState ? Colors.white : Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            widget.tap();
            _answerState = !_answerState;
          });
        },
      ),
    );
  }
}
