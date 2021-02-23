import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final onPageChanged;
  final color;
  final childLeft;
  final childRight;

  const NavBar({
    Key key,
    this.onPageChanged,
    this.color = Colors.orangeAccent,
    @required this.childLeft,
    @required this.childRight,
  }) : super(key: key);
  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double animHeightRight = 100;
  double animHeightLeft = 50;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
      lowerBound: 50,
      upperBound: 100,
    )..addListener(() {
      setState(() {
        animHeightLeft = _controller.value;
        animHeightRight = 150 - _controller.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _openLeft() {
    _controller.reverse();
    if(widget.onPageChanged != null) widget.onPageChanged(1);
  }

  void _openRight() {
    _controller.forward();
    if(widget.onPageChanged != null) widget.onPageChanged(2);
  }


  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
        painter: ShapePainter(
          animHeightRight: animHeightRight,
          animHeightLeft: animHeightLeft,
          color: widget.color,
        ),
        child: Padding(
            padding: EdgeInsets.only(top: 60),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _openLeft,
                    child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: widget.childLeft,
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: _openRight,
                    child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: widget.childRight,
                        )
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}

class ShapePainter extends CustomPainter {
  final animHeightRight;
  final animHeightLeft;
  final color;

  ShapePainter({this.animHeightRight, this.animHeightLeft, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    var path = Path();

    double maxWidth = size.width;
    double maxHeight = 100;
    double midWidth = maxWidth / 2;
    double midHeight = maxHeight / 2;

    path.lineTo(maxWidth, 0);
    path.lineTo(maxWidth, animHeightRight);
    path.lineTo(midWidth + (maxWidth / 20), animHeightRight);
    path.quadraticBezierTo(midWidth, animHeightRight, midWidth, midHeight * 1.5);
    path.quadraticBezierTo(midWidth, animHeightLeft, midWidth - (maxWidth / 20), animHeightLeft);
    path.lineTo(0, animHeightLeft);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}