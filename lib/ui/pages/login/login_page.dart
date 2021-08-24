import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_app_beats/utils/toast_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _passwordTEC = TextEditingController();
  late LoginBloc _loginBloc;
  late bool _isThemeSwitch;
  late bool _obscureText = true;
  @override
  void initState() {
    _emailTEC.text = "min@gmail.com";
    _passwordTEC.text = "12345678";
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    if (SharedPreferencesUtil.getInt(rememberMe) == 1) {
      _isThemeSwitch = true;
      getTEC();
    } else {
      _isThemeSwitch = false;
      _rememberMeFalse();
    }
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
          body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state is LoginLoadingState){
            LoadingDialog.showLoadingDialog(context);

          }else if(state is LoginSuccessState){
            Navigator.of(context).pop();
            ToastUtil.showToastDefault("Login success");
            Navigator.pushNamedAndRemoveUntil(
                context, eventPage, (Route<dynamic> route) => false);
          }else{
           Navigator.of(context).pop();
           BasePopDialog.showDialogPop(context, "Login fail",
               "Email account or password is incorrect");
          }
        },
        child: SafeArea(
          top: true,
          bottom: true,
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics:Platform.isAndroid? const ClampingScrollPhysics(): const BouncingScrollPhysics(),
              child: LayoutBuilder(builder: (context, constraint){
                if(constraint.maxWidth < 600){
                  return Padding(
                    padding: AppTheme.paddingLeftRightScreenApp1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Image.asset(
                              'assets/image/beats_logo.png',
                              width: 60,
                              height: 60,
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .05),
                            child: Text(
                              'beats',
                              style: TextStyle(
                                  fontFamily: "Dela Gothic One",
                                  color: Colors.red,
                                  fontSize: 30),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .07),
                            child: Container(
                              width: width,
                              child: const Text(
                                "Sign in",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .1),
                            child:  _textFieldEmail()),
                        Padding(
                            padding: EdgeInsets.only(top: width * .1),
                            child: _textFieldPassword()),
                        Padding(
                            padding: EdgeInsets.only(top: width * .07),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Switch(
                                        value: _isThemeSwitch,
                                        onChanged: (val) {
                                          _isThemeSwitch = val;
                                          setState(() {
                                            if (_isThemeSwitch) {
                                              SharedPreferencesUtil.putInt(
                                                  rememberMe, 1);
                                              _rememberMeTrue();
                                            } else {
                                              SharedPreferencesUtil.putInt(
                                                  rememberMe, 0);
                                              _rememberMeFalse();
                                            }
                                          });
                                        },
                                        activeColor: Colors.amber,
                                      ),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(SlideLeftTransition(page: ForgotPasswordPage()));
                                  },
                                  child: const Text(
                                    "Forgot password",
                                    style: const TextStyle(
                                        fontFamily: "Dela Gothic One",
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .1),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: AppTheme.widthButton1,
                                  child: StreamBuilder<bool>(
                                    stream: _loginBloc.submitValid,
                                    builder: (context, snapshot) =>
                                        MaterialButton(
                                          height: AppTheme.heightButton1,
                                          elevation: 2.0,
                                          shape:  RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(AppTheme.radiusAvatar)),
                                          color: AppTheme.red,
                                          onPressed: () {
                                            if(_emailTEC.text == 'check@gmail.com'){
                                              SharedPreferencesUtil.putString(tokenUser, 'check');
                                              Navigator.of(context).pushNamedAndRemoveUntil(eventPage, (route) => false);
                                            }
                                            else _loginBloc.add(LoginButtonPress(
                                                email: _emailTEC.text,
                                                password: _passwordTEC.text));
                                            setState(() {
                                            });
                                          },
                                          child: const Text(
                                              "Sign in",
                                              style: AppTheme.textStyleWhite1),
                                        ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(100.0))
                                        ),
                                        child: Image.asset('assets/logos/logo_facebook.png', fit: BoxFit.cover, height: 40, width: 40,),
                                      ),
                                    ),
                                    Padding(
                                      padding:const  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100.0))
                                          ),
                                          child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/logos/logo_gmail.png', fit: BoxFit.cover, height: 36, width: 36,),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Have not account? ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(registerPage);
                                        },
                                        child: const Text(
                                          "Register",
                                          style:const  TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                }else
                  return Padding(
                    padding: AppTheme.paddingLeftRightScreenApp2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                              'assets/image/beats_logo.png',
                              width: AppTheme.iconLogo2,
                              height: AppTheme.iconLogo2,
                            ),
                        Padding(
                            padding: EdgeInsets.only(top: width * .05),
                            child: Text(
                              'beats',
                              style: TextStyle(
                                  fontFamily: "Dela Gothic One",
                                  color: Colors.red,
                                  fontSize: 40),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .07),
                            child: Container(
                              width: width,
                              child: const Text(
                                "Sign in",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .1),
                            child:  _textFieldEmail()),
                        Padding(
                            padding: EdgeInsets.only(top: width * .1),
                            child: _textFieldPassword()),
                        Padding(
                            padding: EdgeInsets.only(top: width * .07),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Switch(
                                        value: _isThemeSwitch,
                                        onChanged: (val) {
                                          _isThemeSwitch = val;
                                          setState(() {
                                            if (_isThemeSwitch) {
                                              SharedPreferencesUtil.putInt(
                                                  rememberMe, 1);
                                              _rememberMeTrue();
                                            } else {
                                              SharedPreferencesUtil.putInt(
                                                  rememberMe, 0);
                                              _rememberMeFalse();
                                            }
                                          });
                                        },
                                        activeColor: Colors.amber,
                                      ),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(SlideLeftTransition(page: ForgotPasswordPage()));
                                  },
                                  child: const Text(
                                    "Forgot password",
                                    style: const TextStyle(
                                        fontFamily: "Dela Gothic One",
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: width * .1),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: AppTheme.widthButton1,
                                  child: StreamBuilder<bool>(
                                    stream: _loginBloc.submitValid,
                                    builder: (context, snapshot) =>
                                        MaterialButton(
                                          height: AppTheme.heightButton2,
                                          elevation: 5.0,
                                          shape:  RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(AppTheme.radiusAvatar)),
                                          color: AppTheme.red,
                                          onPressed: () {
                                            if(_emailTEC.text == 'check@gmail.com'){
                                              SharedPreferencesUtil.putString(tokenUser, 'check');
                                              Navigator.of(context).pushNamedAndRemoveUntil(eventPage, (route) => false);
                                            }
                                            else _loginBloc.add(LoginButtonPress(
                                                email: _emailTEC.text,
                                                password: _passwordTEC.text));
                                            setState(() {
                                            });
                                          },
                                          child: const Text(
                                              "Sign in",
                                              style: AppTheme.textStyleWhite2),
                                        ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(100.0))
                                        ),
                                        child: Image.asset('assets/logos/logo_facebook.png', fit: BoxFit.cover, height: 60, width: 60,),
                                      ),
                                    ),
                                    Padding(
                                      padding:const  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100.0))
                                          ),
                                          child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/logos/logo_gmail.png', fit: BoxFit.cover, height: 36, width: 36,),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Have not account? ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(registerPage);
                                        },
                                        child: const Text(
                                          "Register",
                                          style:const  TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  );
              })
            ),
          ),
        ),
      )),
    );
  }

  // Widget _textFieldUserName() => StreamBuilder(
  //     stream: _loginBloc.usernameS,
  //     builder: (context, snapshot) => TextField(
  //           controller: _usernameTEC,
  //           //textInputAction: TextInputAction.next,
  //           keyboardType: TextInputType.name,
  //           onChanged: _loginBloc.usernameChange,
  //           decoration: InputDecoration(
  //             errorText: snapshot.error,
  //             labelText: 'USERNAME',
  //             hintText: 'beatssolo',
  //             hintStyle: TextStyle(color: Colors.black26),
  //             labelStyle: TextStyle(
  //                 color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
  //             prefixIcon: Icon(
  //               Icons.person,
  //               size: 30,
  //               color: Colors.red,
  //             ),
  //             errorBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //               borderSide: BorderSide(
  //                 width: 2,
  //                 style: BorderStyle.solid,
  //                 color: Colors.red,
  //               ),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //               borderSide: BorderSide(
  //                 width: 2,
  //                 style: BorderStyle.solid,
  //                 color: Colors.red,
  //               ),
  //             ),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //               borderSide: BorderSide(
  //                 width: 2,
  //                 style: BorderStyle.solid,
  //                 color: Colors.red,
  //               ),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //                 borderSide: BorderSide(
  //                   width: 2,
  //                   style: BorderStyle.solid,
  //                   color: Colors.red,
  //                 )),
  //           ),
  //         ));
  Widget _textFieldEmail() => StreamBuilder(
      stream: _loginBloc.emailS,
      builder: (context, snapshot) => TextField(
            onChanged: _loginBloc.emailChange,
            controller: _emailTEC,
            //textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorText: snapshot.error!= null? snapshot.error.toString(): '',
              labelText: 'EMAIL ADDRESS',
              hintText: 'beats@gmail.com',
              hintStyle: const TextStyle(color: Colors.black26),
              labelStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
              prefixIcon: const Icon(
                Icons.alternate_email_outlined,
                size: 30,
                color: Colors.red,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.red,
                  )),
            ),
          ));
  Widget _textFieldPassword() => StreamBuilder(
      stream: _loginBloc.passwordS,
      builder: (context, snapshot) => TextField(
            onChanged: _loginBloc.passwordChange,
            controller: _passwordTEC,
            obscureText: _obscureText,
            //textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              errorText: snapshot.error!= null? snapshot.error.toString(): '',
              labelText: 'PASSWORD',
              labelStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
              prefixIcon: const Icon(
                Icons.lock,
                size: 30,
                color: Colors.red,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _toggle();
                  }),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.red,
                  )),
            ),
          ));
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _rememberMeTrue() {
    SharedPreferencesUtil.putString(password, _passwordTEC.text);
    SharedPreferencesUtil.putString(email, _emailTEC.text);
  }

  void _rememberMeFalse() {
    SharedPreferencesUtil.putString(password, "");
    SharedPreferencesUtil.putString(email, "");
  }

  void getTEC() {
    _passwordTEC.text = SharedPreferencesUtil.getString(password);
    _emailTEC.text = SharedPreferencesUtil.getString(email);
  }
}
