import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketDescription extends StatelessWidget{
  final String title;
  final String des;
  TicketDescription(this.title, this.des);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 300, bottom: 300),
      child: Hero(
        tag: "dash",
        child:  Material(
            color: Colors.teal,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Vé ${title}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('+ $des', style: TextStyle(color: Colors.white),),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Dismiss',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}