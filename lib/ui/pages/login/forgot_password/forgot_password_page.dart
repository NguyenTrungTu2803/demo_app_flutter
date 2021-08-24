import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late ForgotPasswordBloc _bloc;
  late TextEditingController _emailTCL;
  @override
  void initState() {
    _bloc = BlocProvider.of<ForgotPasswordBloc>(context);
    _emailTCL = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    _emailTCL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppTheme.red,
              statusBarIconBrightness: Brightness.light),
          backgroundColor: AppTheme.red,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Forgot Password',
            style:AppTheme.titleAppBar1
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            //height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                      child: Image.asset(
                    'assets/image/beats_logo.png',
                    width: 60,
                    height: 60,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'beats',
                    style: const TextStyle(
                        fontFamily: "Dela Gothic One",
                        color: Colors.red,
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Forgot Password',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, left: 10.0, right: 10.0),
                  child: EmailTextFiled(
                    emailCTL: _emailTCL,
                    bloc: _bloc,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38.0, left: 10.0, right: 10.0, bottom: 5.0),
                  child: const Text(
                    'Enter your email and we will send you a code to reset your password',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<bool>(
                    stream: _bloc.submitValid,
                    builder: (context, snapshot)=>MaterialButton(
                      color: AppTheme.red,
                      height: AppTheme.heightButton1,
                      minWidth: AppTheme.widthButton1,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      onPressed: () {},
                      child: const Text(
                        'Next',
                        style: AppTheme.textStyleWhite1
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}

class EmailTextFiled extends StatelessWidget {
  final ForgotPasswordBloc bloc;
  final TextEditingController emailCTL;
  const EmailTextFiled({required this.bloc,required  this.emailCTL});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.emailS,
        builder: (context, snapshot) => TextField(
              onChanged: bloc.emailChange,
              controller: emailCTL,
              decoration: InputDecoration(
                errorText: snapshot.error!= null? snapshot.error.toString(): '',
                labelText: 'EMAIL ADDRESS',
                hintText: 'beats@gmail.com',
                hintStyle: const TextStyle(color: Colors.black26),
                labelStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
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
  }
}
