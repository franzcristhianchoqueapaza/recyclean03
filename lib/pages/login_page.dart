import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recyclean_03/pages/login_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget child){
            if(value.isLoading()){
              return CircularProgressIndicator();
            }else{
              return child;
            }
          },
          child: RaisedButton(
            child: Text('login'),
            onPressed: (){
              Provider.of<LoginState>(context).login();
            },
          ),
        ),
      ),
    );
  }
}