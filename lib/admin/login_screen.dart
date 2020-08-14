import 'package:covid19morocco/admin/add_data_screen.dart';
import 'package:covid19morocco/admin/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email, _password;
  bool _isPerforming = false;

  @override
  void initState() {
    super.initState();
    _checkSignIn();
  }

  _checkSignIn() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      print('signed in');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => AddDataScreen()),
        (Route<dynamic> route) => false,
      );
    } else
      print('not signed in');
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 500,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.2),
              ),
              Column(
                children: <Widget>[
                  ///holds email header and inputField
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        inputWidget(30.0, 0.0, 0.0, 'Email', _width, 0),
                        inputWidget(0.0, 30.0, 30.0, 'Password', _width, 1),
                      ],
                    ),
                  ),
                  //buttons
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  _isPerforming
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: _submit,
                              color: Colors.blue,
                              child: Text(
                                "Let's get Started",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode()); //hide keyboard
    if (_formKey.currentState.validate() && !_isPerforming) {
      _formKey.currentState.save();
      setState(() {
        _isPerforming = true;
      });

      print(_email);

      //login user
      bool loginSuccess = await AuthService.login(context, _email, _password);

      if (loginSuccess) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => AddDataScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() => _isPerforming = false);

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Email or password not valid'),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  Widget inputWidget(double topRight, double bottomRight, double paddinBottom,
      String hint, double width, int id) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: paddinBottom),
      child: Container(
        width: width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(bottomRight),
              topRight: Radius.circular(topRight),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
              validator: (input) => id == 0
                  ? _verifyEmail(input.trim())
                  : _verifyPassword(input.trim()),
              onSaved: (input) =>
                  id == 0 ? _email = input.trim() : _password = input.trim(),
              obscureText: id == 0 ? false : true,
              keyboardType: id == 0
                  ? TextInputType.emailAddress
                  : TextInputType.visiblePassword,
            ),
          ),
        ),
      ),
    );
  }

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  String _verifyEmail(String input) {
    if (!isEmail(input) || input.toString().length < 5)
      return 'Please enter a valid email';
    else
      return null;
  }

  String _verifyPassword(String input) {
    return input.trim().length < 8 ? 'Must be at least 8 characters' : null;
  }
}
