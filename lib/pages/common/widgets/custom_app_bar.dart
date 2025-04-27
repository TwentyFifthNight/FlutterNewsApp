import 'package:flutter/material.dart';

AppBar customAppBar(){
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Flutter"),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    centerTitle: true,
    elevation: 0,
  );
}