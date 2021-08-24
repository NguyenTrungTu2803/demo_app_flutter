
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/blocs/register_bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/utils/toast_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _registerBloc;
  TextEditingController _usernameTEC = TextEditingController();
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _passwordTEC = TextEditingController();
  TextEditingController _confirmPasswordTEC = TextEditingController();

  bool _obscurePassText = true;
  bool _obscureConfirmPasswordText = true;
  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppTheme.red, statusBarIconBrightness: Brightness.light),
        backgroundColor: AppTheme.red,
        title: const Text(
          "Register",
        ),
        titleTextStyle: AppTheme.titleAppBar1,
        centerTitle: true,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            LoadingDialog.showLoadingDialog(context);
          } else if (state is RegisterSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(eventPage, (Route<dynamic> route) => false);
            ToastUtil.showToastDefault("Register success");
          } else if (state is RegisterExistState) {
            Navigator.of(context).pop();
            BasePopDialog.showDialogPop(context, "Account fail",
                "Account already exists or is not valid");
          } else {
            print("error");
          }
        },
        child: SafeArea(
          top: true,
          bottom: true,
          child: Container(
            width: width,
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics:const  ClampingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: AppTheme.paddingLeftRightScreenApp1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, width * .05, 0, 0),
                          child: Image.asset(
                            'assets/image/beats_logo.png',
                            width: 60,
                            height: 60,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: width * .03),
                          child: const Text(
                            'beats',
                            style: const TextStyle(
                                fontFamily: "Dela Gothic One",
                                color: Colors.red,
                                fontSize: 30),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: width * .05),
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
                          padding: EdgeInsets.only(top: width * .05),
                          child: _textFieldUserName()),
                      Padding(
                          padding: EdgeInsets.only(top: width * .1),
                          child: _textFieldEmail()),
                      Padding(
                          padding: EdgeInsets.only(top: width * .1),
                          child: _textFieldPassword()),
                      Padding(
                          padding: EdgeInsets.only(top: width * .1),
                          child: _textFieldConfirmPassword()),
                      Padding(
                          padding: EdgeInsets.only(top: width * .07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).popAndPushNamed(forgotPassWord);
                                },
                                child:const  Text(
                                  "Forgot password",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: width * .08),
                          child: Column(
                            children: <Widget>[
                               StreamBuilder<bool>(
                                  stream: _registerBloc.submitValid,
                                  builder: (context, snapshot) => MaterialButton(
                                    minWidth: AppTheme.widthButton1,
                                    height: AppTheme.heightButton1,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppTheme.radiusAvatar)),
                                    color: Colors.red,
                                    onPressed:(){
                                            _registerBloc.add(
                                                RegisterButtonPress(
                                                    confirmPassword:
                                                        _confirmPasswordTEC
                                                            .text,
                                                    username: _usernameTEC.text,
                                                    email: _emailTEC.text,
                                                    password:
                                                        _passwordTEC.text));
                                          }
                                        ,
                                    child: const Text(
                                      "Register",
                                      style: AppTheme.textStyleWhite1
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
                                        child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/logos/logo_gmail.png', fit: BoxFit.cover, height: 34, width: 34,),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldUserName() => StreamBuilder(
      stream: _registerBloc.usernameS,
      builder: (context, snapshot) => TextField(
            controller: _usernameTEC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onChanged: _registerBloc.usernameChange,
            decoration: InputDecoration(
              errorText: snapshot.error!= null? snapshot.error.toString(): '',
              labelText: 'USERNAME',
              hintText: 'beatssolo',
              hintStyle: const TextStyle(color: Colors.black26),
              labelStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
              prefixIcon:const  Icon(
                Icons.person,
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
              enabledBorder:const  OutlineInputBorder(
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
  Widget _textFieldEmail() => StreamBuilder(
      stream: _registerBloc.emailS,
      builder: (context, snapshot) => TextField(
            onChanged: _registerBloc.emailChange,
            controller: _emailTEC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorText: snapshot.error!= null? snapshot.error.toString(): '',
              labelText: 'EMAIL ADDRESS',
              hintText: 'beats@gmail.com',
              hintStyle: const TextStyle(color: Colors.black26),
              labelStyle:const  TextStyle(
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
                borderRadius:const  BorderRadius.all(Radius.circular(50.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius:const  BorderRadius.all(Radius.circular(50.0)),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.red,
                  )),
            ),
          ));
  Widget _textFieldPassword() => StreamBuilder(
      stream: _registerBloc.passwordS,
      builder: (context, snapshot) => TextField(
            onChanged: _registerBloc.passwordChange,
            controller: _passwordTEC,
            obscureText: _obscurePassText,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              errorText: snapshot.error!= null? snapshot.error.toString(): '',
              labelText: 'PASSWORD',
              labelStyle:const  TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
              prefixIcon: const Icon(
                Icons.lock,
                size: 30,
                color: Colors.red,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius:const  BorderRadius.all(Radius.circular(50.0)),
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
                    _obscurePassText ? Icons.visibility : Icons.visibility_off,
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
  Widget _textFieldConfirmPassword() => StreamBuilder(
      stream: _registerBloc.confirmPasswordS,
      builder: (context, snapshot) => TextField(
            onChanged:
              _registerBloc.confirmPasswordChange,
            controller: _confirmPasswordTEC,
            obscureText: _obscureConfirmPasswordText,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              errorText: snapshot.error!= null? snapshot.error.toString(): '',
              labelText: 'CONFIRM PASSWORD',
              labelStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
              prefixIcon: const Icon(
                Icons.vpn_key,
                size: 30,
                color: Colors.red,
              ),
              suffixIcon: IconButton(
                onPressed: (){
                  _toggleConfirm();
                },
                icon: Icon(
                  _obscureConfirmPasswordText
                      ? Icons.visibility
                      : Icons.visibility_off_outlined,
                  color: Colors.red,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius:const  BorderRadius.all(Radius.circular(100.0)),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              enabledBorder:const  OutlineInputBorder(
                borderRadius:const  BorderRadius.all(Radius.circular(100.0)),
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
              focusedBorder:const  OutlineInputBorder(
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
      _obscurePassText = !_obscurePassText;
    });
  }

  void _toggleConfirm() {
    setState(() {
      _obscureConfirmPasswordText = !_obscureConfirmPasswordText;
    });
  }
}
