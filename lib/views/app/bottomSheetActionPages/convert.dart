import 'package:flutterCrypto/import/Imports.dart';

class ConvertView extends StatefulWidget {
  final BuildContext contextBack;
  const ConvertView({Key key, this.contextBack}) : super(key: key);

  @override
  _ConvertViewState createState() => _ConvertViewState();
}

class _ConvertViewState extends State<ConvertView> {
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
            _value(context),
            _numberPad(context),
            _continueButton(context),
          ],
        ),
      ),
    );
  }

  /*Widget with the top title and buttons */

  Widget _top(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: AutoSizeText(
        AppLocalizations.of(widget.contextBack).translate('convert') +
            ' ' +
            cryptoCoins[0].name,
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
  Widget _value(BuildContext context) {
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

  Widget _fromTo(BuildContext context) {
    return GestureDetector(
      onTap: () => _showlist(context),
      child: Container(
        width: 1.wp,
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              cryptoCoins[0].image,
              height: 70.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2, right: 2),
              child: ImageIcon(
                AssetImage('assets/icons/arrow_right.png'),
                size: 40.h,
                color: Theme.of(widget.contextBack).textSelectionColor,
              ),
            ),
            Image.asset(
              cryptoCoins[4].image,
              height: 70.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.isEmpty
                        ? AppLocalizations.of(widget.contextBack)
                                .translate('from') +
                            ' 0'
                        : AppLocalizations.of(widget.contextBack)
                                .translate('from') +
                            ' ' +
                            value,
                    style: TextStyle(
                      color: Theme.of(widget.contextBack).textSelectionColor,
                      fontFamily: AppTheme.lightFontFamily,
                      fontSize: ScreenUtil().setSp(40),
                    ),
                  ),
                  Text(
                    value.isEmpty
                        ? AppLocalizations.of(widget.contextBack)
                                .translate('to') +
                            ' 0'
                        : AppLocalizations.of(widget.contextBack)
                                .translate('to') +
                            ' ' +
                            value.toString(),
                    style: TextStyle(
                      color: Theme.of(widget.contextBack).textSelectionColor,
                      fontFamily: AppTheme.lightFontFamily,
                      fontSize: ScreenUtil().setSp(40),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /*Widget with the number pad buttons */
  Widget _numberPad(BuildContext context) {
    return Container(
      height: 0.55.hp,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _fromTo(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                    number: 1,
                    contextBack: widget.contextBack,
                    onPressed: () {
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
  Widget _continueButton(BuildContext context) {
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
          AppLocalizations.of(widget.contextBack).translate('preview_convert'),
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

  void _showlist(BuildContext context) {
    showBarModalBottomSheet(
      expand: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: NotificationListener<
                OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: Container(
              height: 0.65.hp,
              color: Theme.of(widget.contextBack).cardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[200],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: 0.8.wp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(widget.contextBack)
                                    .translate('from'),
                                style: TextStyle(
                                  color: Theme.of(widget.contextBack)
                                      .textSelectionHandleColor,
                                  fontFamily: AppTheme.lightFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 5),
                                child: Image.asset(
                                  cryptoCoins[0].image,
                                  height: 80.h,
                                ),
                              ),
                              Text(
                                cryptoCoins[0].name,
                                style: TextStyle(
                                  color: Theme.of(widget.contextBack)
                                      .textSelectionHandleColor,
                                  fontFamily: AppTheme.lightFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Divider(
                              color: Colors.grey[200],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(widget.contextBack)
                                    .translate('to'),
                                style: TextStyle(
                                  color: Theme.of(widget.contextBack)
                                      .textSelectionHandleColor,
                                  fontFamily: AppTheme.lightFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 31, right: 5),
                                child: Image.asset(
                                  cryptoCoins[4].image,
                                  height: 80.h,
                                ),
                              ),
                              Text(
                                cryptoCoins[4].name,
                                style: TextStyle(
                                  color: Theme.of(widget.contextBack)
                                      .textSelectionHandleColor,
                                  fontFamily: AppTheme.lightFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.4.hp,
                    color: Theme.of(widget.contextBack).cardColor,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 15, top: 20),
                      shrinkWrap: true,
                      itemCount: cryptoCoins.length,
                      itemBuilder: (context, index) {
                        return FadeAnimation(
                          0.5,
                          /*When the user taps this icon he will be redirected to
                          the individual page of this coin */
                          Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                                      child: Image.asset(
                                        cryptoCoins[index].image,
                                        fit: BoxFit.contain,
                                        width: 90.w,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            cryptoCoins[index].name,
                                            style: TextStyle(
                                                color:
                                                    Theme.of(widget.contextBack)
                                                        .textSelectionHandleColor,
                                                fontFamily:
                                                    AppTheme.mediumFontFamily,
                                                fontSize: ScreenUtil().setSp(40)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            cryptoCoins[index].code,
                                            style: TextStyle(
                                                color:
                                                    Theme.of(widget.contextBack)
                                                        .textSelectionHandleColor,
                                                fontFamily:
                                                    AppTheme.lightFontFamily,
                                                fontSize: ScreenUtil().setSp(40)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                AutoSizeText(
                                  '€ 0,00',
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: AppTheme.mediumFontFamily,
                                    color: Theme.of(widget.contextBack)
                                        .textSelectionHandleColor,
                                    fontSize: ScreenUtil().setSp(50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void _alert() {
    showDialog(
        barrierColor: AppTheme.darkblueTheme.withOpacity(0.7),
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalizations.of(widget.contextBack).translate('convert'),
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
