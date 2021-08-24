import 'package:flutter/material.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';

class PopupMenu {
  static Widget popupMenuCheckTicket(BuildContext context, double width) =>
      PopupMenuButton(
        onSelected: (result) {
          //setState(() { _selection = result; });
          if(result == 'logout'){
            IOSDialog.showDialogLogout(context, 'Bạn có muốn đăng xuât?', (){
              Navigator.of(context).pushNamedAndRemoveUntil(loginPage, (Route<dynamic>route) => false);
              SharedPreferencesUtil.clear();
            });
          }
          else Navigator.of(context).pushNamed(result.toString());
        },
        itemBuilder: (context) => [
          if (SharedPreferencesUtil.getString(tokenUser) == 'check')
            PopupMenuItem(
              height: width * .035,
              value: qrPage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.qr_code,
                    color: Colors.black,
                    size: width * .07,
                  ),
                  Text(
                    "Check ticket",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * .035),
                  )
                ],
              )),
          PopupMenuItem(
              height: width * .035,
              value: eventPaymentPage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.sticky_note_2,
                    color: Colors.black,
                    size: width * .07,
                  ),
                  Text(
                    "My ticket",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * .035),
                  )
                ],
              )),
          PopupMenuItem(
              height: width * .035,
              value: 'logout',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: width * .07,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * .035),
                  )
                ],
              )),
        ],
      );

  static Widget popupMenuMyTicket(BuildContext context, double width) =>
      PopupMenuButton(
        icon: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.white,
        ),
        onSelected: (result) {
          //Navigator.of(context).push(result);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
              height: width * .035,
              value: '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.alarm_off,
                    color: Colors.black,
                    size: width * .07,
                  ),
                  Text(
                    "Lọc theo ngày",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * .035),
                  )
                ],
              )),
          PopupMenuItem(
              height: width * .035,
              value: '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.alarm,
                    color: Colors.black,
                    size: width * .07,
                  ),
                  Text(
                    "Lọc theo sự kiện",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * .035),
                  )
                ],
              )),
        ],
      );
}
