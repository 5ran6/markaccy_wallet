import 'package:flutterCrypto/import/Imports.dart';

class LinkedAccountsView extends StatefulWidget {
  const LinkedAccountsView({Key key}) : super(key: key);

  @override
  _LinkedAccountsViewState createState() => _LinkedAccountsViewState();
}

class _LinkedAccountsViewState extends State<LinkedAccountsView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _top(context),
              /*Credit Card carousel */
              _cards(context),
              _add(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            icon: SvgPicture.asset(
              'assets/icons/double_arrows_left.svg',
              height: 50.h,
              color: Theme.of(context).textSelectionHandleColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            AppLocalizations.of(context).translate('linked_accounts'),
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(60),
            ),
          ),
        )
      ],
    );
  }

  Widget _cards(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: SizedBox(
              height: 0.3.hp, // card height
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return null;
                },
                child: PageView.builder(
                  itemCount: 3,
                  controller: PageController(viewportFraction: 0.9),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: AppTheme.blueTheme.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.blueTheme.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "VISA",
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(80),
                                    fontFamily: AppTheme.mediumFontFamily,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/ui/chip.png',
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "0000 0000 0000 0000 ",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(50),
                                  fontFamily: AppTheme.mediumFontFamily,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "06/22",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(50),
                                  fontFamily: AppTheme.lightFontFamily,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 1.wp,
            height: 21,
            alignment: Alignment.center,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, current) {
                return Container(
                  width: current == _index ? 25 : 15,
                  height: 20,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      color: current == _index
                          ? Color.fromRGBO(0, 0, 0, 0.5)
                          : Color.fromRGBO(0, 0, 0, 0.2)),
                );
              },
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _add(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 25, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate('add_account'),
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(60),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/plus.svg',
                height: 40.h,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: SvgPicture.asset(
                    'assets/icons/paypal.svg',
                    height: 80.h,
                    color: AppTheme.blueTheme,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Paypal",
                      style: TextStyle(
                        color: Theme.of(context).textSelectionHandleColor,
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        AppLocalizations.of(context).translate('paypal_text'),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionHandleColor,
                          fontFamily: AppTheme.lightFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Image.asset(
                    'assets/icons/bank.png',
                    height: 80.h,
                    color: AppTheme.blueTheme,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bank Account",
                      style: TextStyle(
                        color: Theme.of(context).textSelectionHandleColor,
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        AppLocalizations.of(context).translate('bank_text'),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionHandleColor,
                          fontFamily: AppTheme.lightFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: SvgPicture.asset(
                    'assets/icons/credit_cards.svg',
                    height: 80.h,
                    color: AppTheme.blueTheme,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credit/Debit Card",
                      style: TextStyle(
                        color: Theme.of(context).textSelectionHandleColor,
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('credit_card_text'),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionHandleColor,
                          fontFamily: AppTheme.lightFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
