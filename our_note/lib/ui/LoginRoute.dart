import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_note/ui/Loading.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _nameController;
  TextEditingController _pwdController;
  Loading _loading;
  Flushbar _flushbar;

  FocusNode _nameNode = FocusNode();
  FocusNode _pwdNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loading = Loading();
    _nameController = TextEditingController();
    _pwdController = TextEditingController();
    _flushbar = Flushbar()..duration = Duration(seconds: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: TextField(
                      focusNode: _nameNode,
                      onSubmitted: (s) =>
                          FocusScope.of(context).requestFocus(_pwdNode),
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: "用户名", prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: TextField(
                      controller: _pwdController,
                      focusNode: _pwdNode,
                      onSubmitted: (s) {
                        showLoading();
                      },
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
                      onPressed: () {
                        login();
                      },
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
            Center(
              child: _loading,
            )
          ],
        ));
  }

  login() {
    hideKeyboard();
    if (_nameController.text.isEmpty) {
      _flushbar
        ..message = "账号不能为空"
        ..show(context);
      return;
    }
    showLoading();
    Future.delayed(Duration(seconds: 2)).then((e) {
      hideLoading();
    });
  }

  showLoading() {
    setState(() {
      _loading.setIsLoading(true);
    });
  }

  hideLoading() {
    setState(() {
      _loading.setIsLoading(false);
    });
  }

  hideKeyboard() {
    _nameNode.unfocus();
    _pwdNode.unfocus();
  }
}
