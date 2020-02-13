import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recyclean_03/pages/home_page.dart';
import 'package:recyclean_03/pages/reports.dart';
import 'package:recyclean_03/pages/login_page.dart';

import 'package:provider/provider.dart';
import 'package:recyclean_03/pages/login_state.dart';
import 'package:recyclean_03/pages/bottle_map.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Color.fromRGBO(56, 39, 180, 1.0),));
    return ChangeNotifierProvider<LoginState>(
      builder: (BuildContext context)=>LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reciclame',
        theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
            headline:TextStyle(fontSize: 20.0,fontFamily: 'Quicksand Bold') 
          ),
        ),
        // home: HomePage(),
        routes: {
          '/' :(BuildContext context){
            var state=Provider.of<LoginState>(context);
            if(state.isLoggedIn()){
              return HomePage();
            }else{
              return LoginPage();
            }
          },
          '/reports'    : (BuildContext context)=>Reports(),
          '/maps'    : (BuildContext context)=>BottleMap(),
        },
      ),
    );
  }
} 
