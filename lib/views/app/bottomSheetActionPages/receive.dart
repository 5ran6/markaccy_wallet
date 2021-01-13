import 'package:flutterCrypto/import/Imports.dart';

class ReceiveView extends StatefulWidget {
  final BuildContext contextBack;
  const ReceiveView({Key key, this.contextBack}) : super(key: key);

  @override
  _ReceiveViewState createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceiveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _top(context),
      backgroundColor: Theme.of(widget.contextBack).scaffoldBackgroundColor,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _qrBox(context),
            _selectBox(context),
            _button(context),
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
        AppLocalizations.of(widget.contextBack).translate('receive_asset'),
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

  Widget _qrBox(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        width: 0.7.wp,
        height: 0.40.hp,
        decoration: BoxDecoration(
            color: Theme.of(widget.contextBack).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/ui/qrcode.png',
              height: 0.3.hp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        AppLocalizations.of(widget.contextBack)
                            .translate('wallet_address'),
                        style: TextStyle(
                          color: Theme.of(widget.contextBack)
                              .textSelectionHandleColor,
                          fontSize: ScreenUtil().setSp(40),
                          fontFamily: AppTheme.lightFontFamily,
                        ),
                      ),
                    ),
                    Text(
                      "3FEn8j...2h1TCz",
                      style: TextStyle(
                        color: Theme.of(widget.contextBack)
                            .textSelectionHandleColor,
                        fontSize: ScreenUtil().setSp(50),
                        fontFamily: AppTheme.mediumFontFamily,
                      ),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(widget.contextBack).translate('copy'),
                  style: TextStyle(
                    color: AppTheme.blueTheme,
                    fontSize: ScreenUtil().setSp(50),
                    fontFamily: AppTheme.mediumFontFamily,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80, bottom: 20),
      child: Container(
        height: 60,
        width: 0.8.wp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(
              color: Colors.grey[200],
            )),
        child: MaterialButton(
          onPressed: () => _showOther(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                cryptoCoins[0].image,
                fit: BoxFit.contain,
                width: 90.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cryptoCoins[0].name,
                      style: TextStyle(
                        color: Theme.of(widget.contextBack).textSelectionColor,
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(45),
                      ),
                    ),
                    Text(
                      cryptoCoins[0].code,
                      style: TextStyle(
                        color: Theme.of(widget.contextBack).textSelectionColor,
                        fontFamily: AppTheme.lightFontFamily,
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget with the Preview buy button */
  Widget _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
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
          AppLocalizations.of(widget.contextBack).translate('share_address'),
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

  void _showOther(BuildContext context) {
    showBarModalBottomSheet(
      expand: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context, scrollController) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: Container(
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
                            child: Image.asset(
                              cryptoCoins[index].image,
                              fit: BoxFit.contain,
                              width: 90.w,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  cryptoCoins[index].name,
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
                                  cryptoCoins[index].code,
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
      ),
    );
  }
}
