import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/models/model.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/payment_model.dart';
import 'package:flutter_app_beats/ui/widgets/head_title_card.dart';

typedef void BoolCallback(PaymentModel val);

class PaymentBank extends StatefulWidget {
  final BoolCallback callback;

  PaymentBank({required this.callback});

  @override
  _PaymentBankState createState() => _PaymentBankState();
}

class _PaymentBankState extends State<PaymentBank> {
  var _selectedPayment;
  @override
  void initState() {
    _selectedPayment = BuyPaymentModel('', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Padding(
          padding: AppTheme.paddingLeftRightTopScreen1,
          child: Card(
              elevation: 2.0,
              shape: const RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppTheme.radiusCard1)),
                side: const BorderSide(color: AppTheme.black38, width: .5),
              ),
              child: Container(
                  child: Column(
                children: <Widget>[
                  HeadTitleCard.headTitleCard(['phương thức thanh toán']),
                  Column(
                    children: _buyPayment
                        .map((e) => ListTile(
                              // minLeadingWidth: 20,
                              selected: e.selected,
                              onTap: () {
                                setState(() {
                                  _selectedPayment = e;
                                  for (int i = 0; i < _buyPayment.length; i++) {
                                    if (_buyPayment[i] == _selectedPayment) {
                                      _buyPayment[i].selected = true;
                                      if (i == 1) {
                                        BuyTicketPage.of(context)
                                                !.isSelectedPayment =
                                            PaymentModel(
                                                indexBank: true,
                                                selected:
                                                    _buyPayment[i].selected,
                                                linkImage: _buyPayment[i].image,
                                                titlePayment:
                                                    _buyPayment[i].title);
                                      } else {
                                        BuyTicketPage.of(context)
                                                !.isSelectedPayment =
                                            PaymentModel(
                                                indexBank: false,
                                                selected:
                                                    _buyPayment[i].selected,
                                                linkImage: _buyPayment[i].image,
                                                titlePayment:
                                                    _buyPayment[i].title);
                                      }
                                    } else {
                                      _buyPayment[i].selected = false;
                                    }
                                  }
                                });
                              },
                              title: Text(
                                e.title.toUpperCase(),
                                style: AppTheme.captionBlack,
                              ),
                              leading: Image.network(
                                e.image,
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                width: width * .1,
                                height: width * .1,
                              ),
                              trailing: e.selected
                                  ? const Icon(
                                      Icons.check,
                                      color: AppTheme.black,
                                      size: AppTheme.sizeIcon1,
                                    )
                                  : const Icon(null),
                            ))
                        .toList(),
                  ),
                ],
              ))),
        );
      } else {
        return Padding(
          padding:
              EdgeInsets.only(top: 20, left: width * .03, right: width * .03),
          child: Card(
              elevation: 2.0,
              shape: const RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                side: const BorderSide(color: Colors.black26, width: .5),
              ),
              child: Container(
                  width: width,
                  height: width,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: width,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0)),
                          ),
                          child: const Text(
                            "PHƯƠNG THỨC THANH TOÁN",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, item) {
                              return Container(
                                height: 120,
                                child: Center(
                                  child: ListTile(
                                    selected: _buyPayment[item].selected,
                                    onTap: () {
                                      setState(() {
                                        _selectedPayment = _buyPayment[item];
                                        for (int i = 0;
                                            i < _buyPayment.length;
                                            i++) {
                                          if (_buyPayment[i] ==
                                              _selectedPayment) {
                                            _buyPayment[i].selected = true;
                                            if (i == 1) {
                                              BuyTicketPage.of(context)
                                                      !.isSelectedPayment =
                                                  PaymentModel(
                                                      indexBank: true,
                                                      selected: _buyPayment[i]
                                                          .selected,
                                                      linkImage:
                                                          _buyPayment[i].image,
                                                      titlePayment:
                                                          _buyPayment[i].title);
                                            } else {
                                              BuyTicketPage.of(context)
                                                      !.isSelectedPayment =
                                                  PaymentModel(
                                                      indexBank: false,
                                                      selected: _buyPayment[i]
                                                          .selected,
                                                      linkImage:
                                                          _buyPayment[i].image,
                                                      titlePayment:
                                                          _buyPayment[i].title);
                                            }
                                          } else {
                                            _buyPayment[i].selected = false;
                                          }
                                        }
                                      });
                                    },
                                    title: Text(
                                      _buyPayment[item].title,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    leading: Image.network(
                                      _buyPayment[item].image,
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                      width: width * .1,
                                      height: width * .1,
                                    ),
                                    trailing: _buyPayment[item].selected
                                        ? const Icon(
                                            Icons.check,
                                            size: 50,
                                            color: Colors.black,
                                          )
                                        : const Icon(null),
                                  ),
                                ),
                              );
                            },
                            itemCount: _buyPayment.length,
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ))),
        );
      }
    });
  }
}

List<BuyPaymentModel> _buyPayment = <BuyPaymentModel>[
  BuyPaymentModel(
      "https://vayonline.org/wp-content/uploads/2020/09/the-atm-noi-dia-la-gi.jpg",
      "ATM card(Thẻ nội địa)"),
  BuyPaymentModel(
    "https://neapay.com/res_blog/credit-card-brands.png",
    "Thẻ quốc tế (Visa, Master, Amex, JCB)",
  ),
  BuyPaymentModel(
    "https://static.mservice.io/img/logo-momo.png",
    "Ví MoMo",
  ),
  BuyPaymentModel(
    "https://1.bp.blogspot.com/-gd31Y8LLTXc/XY0WhpfUF9I/AAAAAAADDzo/44-B6-qh8o0yyMwo-J2cHKyWz2SbfJGKACLcBGAsYHQ/s1600/logo.png",
    "ZaloPay",
  ),
  BuyPaymentModel(
    "https://banthe24h.vn/pictures/images/thi-truong-dung-airpay-1.png",
    "Airpay",
  ),
  BuyPaymentModel(
    "https://static.taiphanmemnhanh.com/uploads/taiphanmemnhanh.com/taiphanmemnhanh.com_5e9db71a3abbb.png",
    "Viettelpay",
  ),
];
