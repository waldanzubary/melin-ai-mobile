import 'package:flutter/material.dart';
import 'post.dart';
// import 'login.dart';
void main() {
 runApp(MyApp());
}
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 title: 'HTTP',
 debugShowCheckedModeBanner: false,
 theme: ThemeData(
 primarySwatch: Colors.blue,
 visualDensity: VisualDensity.adaptivePlatformDensity,
 ),
 home: ChatScreen(),

 );
 }
}