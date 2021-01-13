import 'package:flutterCrypto/import/Imports.dart';

class BuyView extends StatefulWidget {
  final BuildContext contextBack;
  const BuyView({Key key, this.contextBack}) : super(key: key);

  @override
  _BuyViewState createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  final CryptoAPI cryptoAPI = CryptoAPI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(widget.contextBack).scaffoldBackgroundColor,
      appBar: _top(context),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                /*Function that will be called when this user access this page */
                future: cryptoAPI.buyList(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    /*List variable with all crypto coins */
                    List<dynamic> cryptos = snapshot.data;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1,
                          _list(widget.contextBack, cryptos),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: 0.5.hp,
                      color:
                          Theme.of(widget.contextBack).scaffoldBackgroundColor,
                      child: Center(
                        child: SizedBox(
                          height: 0.1.hp,
                          child: FlareActor(
                            'assets/animations/global/animated_circle.flr',
                            animation: 'loading',
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

/*Widget with the top title and buttons */
  Widget _top(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: AutoSizeText(
        AppLocalizations.of(widget.contextBack)
            .translate('select_asset_to_buy'),
        textAlign: TextAlign.center,
        maxLines: 3,
        minFontSize: 10,
        style: TextStyle(
          fontFamily: AppTheme.mediumFontFamily,
          color: Theme.of(widget.contextBack).textSelectionHandleColor,
          fontSize: ScreenUtil().setSp(60),
        ),
      ),
      elevation: 1,
      shadowColor: AppTheme.blueTheme,
      backgroundColor: Theme.of(widget.contextBack).scaffoldBackgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 5),
        child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              height: 50.h,
              color: Theme.of(widget.contextBack).textSelectionHandleColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
/*Widget with the top title and buttons */

  Widget _list(BuildContext context, List<Cryptos> cryptos) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(bottom: 15, top: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cryptos.length,
          itemBuilder: (context, index) {
            return FadeAnimation(
              0.5,
              /*When the user taps this icon he will be redirected to 
              the individual page of this coin */
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: BuyAmountView(
                      contextBack: widget.contextBack,
                      coinName: cryptos[index].name,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: 1.wp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey[300],
                              ),
                            ),
                            child: Image(
                              /*Get image from coinmarketcap website */
                              image: NetworkImage(
                                'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                                    cryptos[index].id.toString() +
                                    '.png',
                              ),
                              fit: BoxFit.contain,
                              width: 100.w,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  cryptos[index].name,
                                  style: TextStyle(
                                      color: Theme.of(widget.contextBack)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.mediumFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  cryptos[index].symbol,
                                  style: TextStyle(
                                      color: Theme.of(widget.contextBack)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.lightFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
                            cryptos[index].quote.usd.price > 10
                                ? '€ ' +
                                    cryptos[index]
                                        .quote
                                        .usd
                                        .price
                                        .toStringAsFixed(2)
                                : '€ ' +
                                    cryptos[index]
                                        .quote
                                        .usd
                                        .price
                                        .toStringAsFixed(3),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppTheme.mediumFontFamily,
                              color: Theme.of(widget.contextBack)
                                  .textSelectionHandleColor,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: AutoSizeText(
                                cryptos[index]
                                    .quote
                                    .usd
                                    .percentChange24H
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                  color: cryptos[index]
                                          .quote
                                          .usd
                                          .percentChange24H
                                          .toString()
                                          .contains('-')
                                      ? Colors.redAccent
                                      : Colors.greenAccent,
                                  fontFamily: AppTheme.lightFontFamily,
                                  fontSize: ScreenUtil().setSp(40),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class BuyAmountView extends StatefulWidget {
  final BuildContext contextBack;
  final String coinName;
  const BuyAmountView({Key key, this.contextBack, this.coinName})
      : super(key: key);

  @override
  _BuyAmountViewState createState() => _BuyAmountViewState();
}

class _BuyAmountViewState extends State<BuyAmountView> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(widget.contextBack).scaffoldBackgroundColor,
      appBar: _top(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            _value(),
            _numberPad(),
            _buyButton(),
          ],
        ),
      ),
    );
  }

  /*Widget with title and close button */
  Widget _top(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: AutoSizeText(
        AppLocalizations.of(widget.contextBack).translate('buy') +
            ' ' +
            widget.coinName,
        textAlign: TextAlign.center,
        maxLines: 3,
        minFontSize: 10,
        style: TextStyle(
          fontFamily: AppTheme.mediumFontFamily,
          color: Theme.of(widget.contextBack).textSelectionHandleColor,
          fontSize: ScreenUtil().setSp(60),
        ),
      ),
      elevation: 1,
      shadowColor: AppTheme.blueTheme,
      backgroundColor: Theme.of(widget.contextBack).scaffoldBackgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 5),
        child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              height: 50.h,
              color: Theme.of(widget.contextBack).textSelectionHandleColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }

  /*Widget with the value text */
  Widget _value() {
    return Container(
      height: 0.25.hp,
      width: 1.wp,
      child: Center(
          child: Text(
        value.isEmpty ? '€0' : '€' + value,
        style: TextStyle(
          color: AppTheme.blueTheme,
          fontFamily: AppTheme.lightFontFamily,
          fontSize: ScreenUtil().setSp(100),
        ),
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _paymentMethod(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(widget.contextBack)
                .translate('add_payment_method'),
            style: TextStyle(
              color: Theme.of(widget.contextBack).textSelectionHandleColor,
              fontFamily: AppTheme.lightFontFamily,
              fontSize: ScreenUtil().setSp(50),
            ),
          ),
          Container(
            height: 25,
            width: 80,
            decoration: BoxDecoration(
              color: AppTheme.darkblueTheme,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.blueTheme.withOpacity(0.5),
                  blurRadius: 6,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(widget.contextBack).translate('add'),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget with the number pad buttons */
  Widget _numberPad() {
    return Container(
      height: 0.55.hp,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _paymentMethod(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                    number: 1,
                    contextBack: widget.contextBack,
                    onPressed: () {
                      /*If the lenght of the value its lower than 7 
                      the value "1" will be add to the variable "value" */
                      if (value.length < 7) {
                        setState(() {
                          value = value + "1";
                        });
                      }
                    }),
                KeyboardNumber(
                  number: 2,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "2";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 3,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "3";
                      });
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  number: 4,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "4";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 5,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "5";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 6,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "6";
                      });
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  number: 7,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "7";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 8,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "8";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 9,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "9";
                      });
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  padding: EdgeInsets.all(2),
                  onPressed: () {
                    if (value.length < 7 && !value.contains(".")) {
                      setState(() {
                        value = value + ".";
                      });
                    }
                  },
                  color: Theme.of(widget.contextBack).textSelectionColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 2,
                  minWidth: 2,
                ),
                KeyboardNumber(
                  number: 0,
                  contextBack: widget.contextBack,
                  onPressed: () {
                    if (value.length < 7) {
                      setState(() {
                        value = value + "0";
                      });
                    }
                  },
                ),
                IconButton(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: ImageIcon(
                      AssetImage('assets/icons/arrow_left.png'),
                      size: 20,
                      color: Theme.of(widget.contextBack).textSelectionColor,
                    ),
                    onPressed: () {
                      if (value.length > 0) {
                        setState(() {
                          value = value.substring(0, value.length - 1);
                        });
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /*Widget with the Preview buy button */
  Widget _buyButton() {
    return GestureDetector(
      onTap: () => _alert(),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 0.8.wp,
        decoration: BoxDecoration(
            color: AppTheme.iconContainerColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.blueTheme.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ]),
        child: Text(
          AppLocalizations.of(widget.contextBack).translate('preview_buy'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppTheme.mediumFontFamily,
            fontSize: ScreenUtil().setSp(50),
          ),
        ),
      ),
    );
  }

  void _alert() {
    showDialog(
        barrierColor: AppTheme.darkblueTheme.withOpacity(0.7),
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalizations.of(widget.contextBack).translate('buy') +
                ' ' +
                widget.coinName,
            description: AppLocalizations.of(widget.contextBack)
                .translate('done_success'),
            buttonText:
                AppLocalizations.of(widget.contextBack).translate('confirm'),
            type: 'success',
            contextBack: widget.contextBack,
          );
        });
  }
}
