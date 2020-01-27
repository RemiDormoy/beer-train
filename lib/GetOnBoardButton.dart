import 'package:flutter/material.dart';

import 'GetOnBoardDialog.dart';
import 'colors.dart';

class GetOnBoardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return GetOnBoardDialog();
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Center(
            child: Text(
              'Je monte à bord',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: skyGradientTop,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 8.0,
              offset: Offset(2.0, 2.0),
            ),
          ]
        ),
      ),
    );
  }
}
