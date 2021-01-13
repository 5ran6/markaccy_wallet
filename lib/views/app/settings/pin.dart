import 'package:flutter/rendering.dart';
import 'package:flutterCrypto/import/Imports.dart';

class PinView extends StatefulWidget {
  PinView({Key key}) : super(key: key);

  @override
  _PinViewtate createState() => _PinViewtate();
}

class _PinViewtate extends State<PinView> {
  String pin = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _top(context),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pinContainers(context),
              _numberPad(context),
            ]),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(top: 15),
        child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/double_arrows_left.svg',
              height: 50.h,
              color: Theme.of(context).textSelectionHandleColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          AppLocalizations.of(context).translate('pin_code'),
          style: TextStyle(
            color: Theme.of(context).textSelectionColor,
            fontSize: ScreenUtil().setSp(60),
            fontFamily: AppTheme.mediumFontFamily,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget _pinContainers(BuildContext context) {
    return Container(
      width: 1.wp,
      alignment: Alignment.center,
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              padding: EdgeInsets.all(20),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: AppTheme.darkblueTheme,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lightTheme.shadowColor,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ]),
              child: Center(
                child:
                    /*Here the app will verify if the length of the string its lower
                 than the index of the list. If its true it means that the string
                 dont have 
                 */
                    pin.length <= index
                        ? Text("")
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
              ),
            ),
          );
        },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                    number: 1,
                    contextBack: context,
                    onPressed: () {
                      if (pin.length < 4) {
                        setState(() {
                          pin = pin + "1";
                        });
                      }
                    }),
                KeyboardNumber(
                  number: 2,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "2";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 3,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "3";
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
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "4";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 5,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "5";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 6,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "6";
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
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "7";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 8,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "8";
                      });
                    }
                  },
                ),
                KeyboardNumber(
                  number: 9,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "9";
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
                  onPressed: () {},
                  height: 2,
                  minWidth: 2,
                ),
                KeyboardNumber(
                  number: 0,
                  contextBack: context,
                  onPressed: () {
                    if (pin.length < 4) {
                      setState(() {
                        pin = pin + "0";
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
                      color: Theme.of(context).textSelectionColor,
                    ),
                    onPressed: () {
                      if (pin.length > 0) {
                        setState(() {
                          pin = pin.substring(0, pin.length - 1);
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
}
