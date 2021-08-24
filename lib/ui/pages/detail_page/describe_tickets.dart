import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/models/detail/data_tickets.dart';
import 'package:flutter_app_beats/other/format_money.dart';
import 'package:flutter_app_beats/ui/widgets/head_title_card.dart';

class DescribeTickets extends StatefulWidget {
  final List<DataTickets> dataTickets;

  DescribeTickets({Key? key,required  this.dataTickets}) : super(key: key);

  @override
  _DescribeTicketsState createState() => _DescribeTicketsState();
}

class _DescribeTicketsState extends State<DescribeTickets>{
  List<bool>? _isExpansion;
  @override
  void initState() {
    _isExpansion = List.filled(widget.dataTickets.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _dataTicker = widget.dataTickets;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: AppTheme.paddingLeftRightTopScreen1,
      child: LayoutBuilder( builder: (context, constraints){
        if(constraints.maxWidth < 600){
          return Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppTheme.radiusCard1)),
                side: BorderSide(color: Colors.black38, width: .5)),
            elevation: 1.0,
            child: Container(
              width: width,
              child: Column(
                children: <Widget>[
                  HeadTitleCard.headTitleCard(['thông tin vé']),
                  if(_dataTicker.isNotEmpty)
                     Padding(
                        padding: AppTheme.paddingLeftRightScreenApp1,
                        child: Column(
                          children: _dataTicker.map((e) => ExpansionTile(
                              tilePadding: AppTheme.paddingLeftRightScreenApp1,
                              initiallyExpanded: _isExpansion![_dataTicker.indexOf(e)],
                              onExpansionChanged: (
                                  expansion,
                                  ) {
                                setState(() {
                                  _isExpansion![_dataTicker.indexOf(e)] = expansion;
                                });
                              },
                              childrenPadding: AppTheme.paddingLeftRightScreenApp1, //.copyWith(top: 10),
                              trailing: Text(
                                'Còn ${_dataTicker[_dataTicker.indexOf(e)].quantities - _dataTicker[_dataTicker.indexOf(e)].solvedTicket} vé',
                                style: AppTheme.textRedBold500_1,
                              ),
                              leading: !_isExpansion![_dataTicker.indexOf(e)]
                                  ? const Icon(
                                Icons.arrow_drop_down_circle_rounded,
                                color: AppTheme.red,
                              )
                                  : Container(
                                height: height*.055,
                                width: width*.055,
                                child: CircleAvatar(
                                  backgroundColor: AppTheme.red,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.white,
                                      size: width*.05,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                '${FormatMoney.coverPrice(_dataTicker[_dataTicker.indexOf(e)].price)}',
                                style: AppTheme.textRedBold500_1
                              ),
                              title: Text(
                                _dataTicker[_dataTicker.indexOf(e)].ticketType.toUpperCase(),
                                style: AppTheme.captionBlack1
                              ),
                              children: [
                                if (_dataTicker[_dataTicker.indexOf(e)].description != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Align(
                                      child: Text(
                                        '+ ${_dataTicker[_dataTicker.indexOf(e)].description}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),
                              ])).toList(),
                        )
                      ),

                ],
              ),
            ),
          );
        }else{
          return Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppTheme.radiusCard1)),
                side: BorderSide(color: Colors.black38, width: .5)),
            elevation: 5.0,
            child: Container(
              width: width,
              child: Column(
                children: <Widget>[
                  HeadTitleCard.headTitleCard(['thông tin vé']),
                  if(_dataTicker.isNotEmpty)
                    Padding(
                        padding: AppTheme.paddingLeftRightScreenApp2,
                        child: Column(
                          children: _dataTicker.map((e) => ExpansionTile(
                              tilePadding: AppTheme.paddingLeftRightScreenApp2,
                              initiallyExpanded: _isExpansion![_dataTicker.indexOf(e)],
                              onExpansionChanged: (
                                  expansion,
                                  ) {
                                setState(() {
                                  _isExpansion![_dataTicker.indexOf(e)] = expansion;
                                });
                              },
                              childrenPadding: AppTheme.paddingLeftRightScreenApp1, //.copyWith(top: 10),
                              trailing: Text(
                                'Còn ${_dataTicker[_dataTicker.indexOf(e)].quantities - _dataTicker[_dataTicker.indexOf(e)].solvedTicket} vé',
                                style: AppTheme.textRedBold500_2,
                              ),
                              leading: !_isExpansion![_dataTicker.indexOf(e)]
                                  ? const Icon(
                                Icons.arrow_drop_down_circle_rounded,
                                color: AppTheme.red,
                                size: AppTheme.sizeIcon2,
                              )
                                  : Container(
                                height: height*.055,
                                width: width*.055,
                                child: CircleAvatar(
                                  backgroundColor: AppTheme.red,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.white,
                                      size: width*.05,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                  '${FormatMoney.coverPrice(_dataTicker[_dataTicker.indexOf(e)].price)}',
                                  style: AppTheme.textRedBold500_1
                              ),
                              title: Text(
                                  _dataTicker[_dataTicker.indexOf(e)].ticketType.toUpperCase(),
                                  style: AppTheme.captionBlack1
                              ),
                              children: [
                                if (_dataTicker[_dataTicker.indexOf(e)].description != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Align(
                                      child: Text(
                                        '+ ${_dataTicker[_dataTicker.indexOf(e)].description}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),
                              ])).toList(),
                        )
                    ),

                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
