import 'package:flutter/material.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    labelText: "用户名", prefixIcon: Icon(Icons.person)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "密码", prefixIcon: Icon(Icons.lock)),
              ),
            ),
            Container(
              width: 250.0,
              height: 40.0,
              margin: EdgeInsets.only(top: 70.0),
              child: RaisedButton(
                colorBrightness: Brightness.dark,
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  'Login',
                ),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Created By WangLu',
                style: TextStyle(color: Colors.grey),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
