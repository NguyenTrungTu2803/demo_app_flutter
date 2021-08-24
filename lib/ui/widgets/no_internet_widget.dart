import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget{
  @override
  _NoInternetState createState()=> _NoInternetState();
  
}
class _NoInternetState extends State<NoInternet>{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child:  Stack(
          children: <Widget>[
            Positioned(
              left: 0, right: 0, top: 0,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                    width: width,
                    height: width,
                    child: Image.asset("assets/image/no_internet.png", fit: BoxFit.cover,)

                ),
              )),
            Positioned(
                top: width*.8,
                left: 15, right: 15,
                bottom: width*.2,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      "No Internet Connection",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    const Text(
                      "You are not connected to the internet. Make sure Wi-Fi is on, Airplane Mode is off and try again.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: 200,
                      shape: const RoundedRectangleBorder(
                          side:const  BorderSide(color: Colors.deepPurple, width: 3),
                          borderRadius: const BorderRadius.all(Radius.circular(30.0))
                      ),
                      onPressed: () {},
                      child:const  Text(
                        "Retry",
                        style: const TextStyle(
                          //fontFamily: "Dela Gothic One",
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var firstControlPoint = Offset(55, size.height / 1.4);
    var firstEndPoint = Offset(size.width / 1.7, size.height / 1.3);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width - (35), size.height - 90);
    var secondEndPoint = Offset(size.width, size.height / 1.7);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> false;

}