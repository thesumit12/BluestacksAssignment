import 'package:bluestacks_assignment/login/login_provider.dart';
import 'package:bluestacks_assignment/navigation/app_navigator_factory.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(this._factory);

  final AppNavigatorFactory _factory;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = LoginProvider();
    _userNameController.addListener(() {
      _provider.changeLoginButtonState(
          _userNameController.text, _passwordController.text);
    });
    _passwordController.addListener(() {
      _provider.changeLoginButtonState(
          _userNameController.text, _passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login').tr(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png"),
                Container(
                  margin: const EdgeInsets.only(top: 48),
                  child: TextField(
                    controller: _userNameController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'username_hint'.tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _passwordController,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'password_hint'.tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 24),
                  child: ChangeNotifierProvider(
                    create: (BuildContext context) => _provider,
                    child: LoginButton(widget._factory),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class LoginButton extends StatelessWidget {
  LoginButton(this._factory);
  final AppNavigatorFactory _factory;
  @override
  Widget build(BuildContext context) {
    final LoginProvider _provider = Provider.of(context);
    return RaisedButton(
      elevation: 5,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      color: ThemeData.light().primaryColor,
      onPressed: _provider.isLoginButtonEnabled
          ? () {
              String result = _provider.login();
              if (result != null) {
                Fluttertoast.showToast(
                  msg: result,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              } else {
                _provider.setLoginStatus(true);
                _factory.get(context).navigateToHomePage(_provider.userName);
              }
            }
          : null,
      child:
          Text('login'.tr(), style: TextStyle(color: Colors.white, fontSize: 20.0)),
    );
  }
}
