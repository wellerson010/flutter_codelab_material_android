import 'package:flutter/material.dart';
import 'colors.dart';

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({
    Key key, this.color, this.child
  }):super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context){
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color)
    );
  }
}

class Login extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE')
              ],
            ),
            SizedBox(height: 120.0),
          PrimaryColorOverride (
              color: kShrineBrown900,
              child:TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username'
              )
            )),
            SizedBox(height: 12.0),
            PrimaryColorOverride (
              color: kShrineBrown900,
                child: TextField(
              controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              obscureText: true,
            )),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                  ),
                  onPressed: (){
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                RaisedButton(
                  elevation: 8.0,
                  child: Text('Next'),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))
                  ),
                  onPressed: (){
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                )
              ],
            )
          ]
        )
      )
    );
  }
}