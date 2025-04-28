import 'package:flutter/material.dart';

Widget actionButton(String text, final Function() onButtonTapped){
  return GestureDetector(
    onTap: () {onButtonTapped();},
    child: Text(
      text,
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
  );
}