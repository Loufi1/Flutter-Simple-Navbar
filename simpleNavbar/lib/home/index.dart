import 'package:flutter/material.dart';
import 'package:simpleNavbar/widgets/navbar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(218, 223, 227, 1),
      body: Stack(
        children: [
          NavBar(
            childLeft: Text(
              'PAGE 1',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 20,
              ),
            ),
            childRight: Text(
              'PAGE 2',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}