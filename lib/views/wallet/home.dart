import 'dart:ui';

import 'package:flutterCrypto/import/Imports.dart';
import 'package:flutterCrypto/views/wallet/notifications.dart';
import 'package:flutterCrypto/views/wallet/settings.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key key}) : super(key: key);

  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
//TODO: Markaccy wallet mode

  int _selectedItemPosition = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                _selectedItemPosition = index;
              });
            },
            controller: pageController,
            children: <Widget>[
              WalletHomeView(),
              WalletNotificationsView(),
              WalletSettingsView(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              elevation: 0,
              iconSize: 55.h,
              type: BottomNavigationBarType.fixed,
              fixedColor: Color(0xff2398C3),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.transparent,
              currentIndex: _selectedItemPosition,
              onTap: handleNavigationChange,
              items: [
                BottomNavigationBarItem(
                  label: "",
                  backgroundColor: Colors.transparent,
                  icon: ImageIcon(
                    AssetImage('assets/icons/home.png'),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  backgroundColor: Colors.transparent,
                  icon: ImageIcon(
                    AssetImage('assets/icons/bell.png'),
                  ),
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  label: "",
                  icon: ImageIcon(
                    AssetImage('assets/icons/settings.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleNavigationChange(int index) {
    setState(
      () {
        _selectedItemPosition = index;
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      },
    );
  }
}

class WalletHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _top(context),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _balance(context),
              _cards(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 15),
        child: CircleAvatar(
          backgroundColor: Colors.grey[400],
          child: SvgPicture.asset(
            'assets/icons/user.svg',
            height: 60.h,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        AppLocalizations.of(context).translate('wallet'),
        style: TextStyle(
          color: Theme.of(context).textSelectionColor,
          fontFamily: AppTheme.mediumFontFamily,
          fontSize: ScreenUtil().setSp(70),
        ),
      ),
    );
  }

  Widget _balance(BuildContext context) {
    return FadeAnimation(
      1,
      Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate('total_value'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(50),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "€ 5,846.00",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(90),
                  ),
                ),
              ),
              Text(
                "16.05%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cards(BuildContext context) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: EdgeInsets.only(top: 40, left: 25, right: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Crypto",
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(60),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/dots.svg',
                  height: 50.h,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 0.2.hp,
                width: 1.wp,
                decoration: BoxDecoration(
                    color: AppTheme.darkTheme.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.lightTheme.shadowColor,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey[200],
                            ),
                          ),
                          child: Image.asset(
                            'assets/crypto_icons/trx.png',
                            fit: BoxFit.contain,
                            width: 90.w,
                          ),
                        ),
                        Text(
                          "TRX",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppTheme.lightFontFamily,
                            fontSize: ScreenUtil().setSp(50),
                          ),
                        ),
                      ],
                    ),
                    _graph(context),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    height: 0.24.hp,
                    width: 0.5.wp,
                    decoration: BoxDecoration(
                        color: AppTheme.darkTheme.cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lightTheme.shadowColor,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey[200],
                            ),
                          ),
                          child: Image.asset(
                            cryptoCoins[0].image,
                            fit: BoxFit.contain,
                            width: 90.w,
                          ),
                        ),
                        Text(
                          cryptoCoins[0].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppTheme.mediumFontFamily,
                              fontSize: ScreenUtil().setSp(60)),
                        ),
                        Text(
                          cryptoCoins[0].percen,
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontFamily: AppTheme.mediumFontFamily,
                              fontSize: ScreenUtil().setSp(70)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.24.hp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 0.1.hp,
                          width: 0.22.wp,
                          decoration: BoxDecoration(
                              color: AppTheme.darkTheme.cardColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.lightTheme.shadowColor,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/arrow_obli_right.svg',
                                height: 80.h,
                                color: Colors.red,
                              ),
                              Text(
                                AppLocalizations.of(context).translate('send'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppTheme.mediumFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 0.1.hp,
                          width: 0.22.wp,
                          decoration: BoxDecoration(
                              color: AppTheme.darkTheme.cardColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.lightTheme.shadowColor,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/arrow_obli_left.svg',
                                height: 80.h,
                                color: Colors.green,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('receive'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppTheme.mediumFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _graph(BuildContext context) {
    return Container(
      height: 0.4.hp,
      width: 0.62.wp,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: false,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
          ),
          /*To show the graph titles chnage teh "show" parameter to true  */
          titlesData: FlTitlesData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),

          /*Here are the graph max and min values to x and y axis  */
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots:
                  /*This are the current values of the graph, when the user taps 
               on the sort buttons below the graph this graphData will change 
               and get other values to show in graph  */
                  [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 3.1),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              colors: [
                AppTheme.blueTheme,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0)
              ],
              barWidth: 3,
              gradientFrom: Offset(0, 0),
              gradientTo: Offset(10, 100),
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                gradientFrom: Offset(1, 0),
                gradientTo: Offset(1, 1),
                show: true,
                colors: [
                  AppTheme.blueTheme,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0)
                ].map((color) => color.withOpacity(0.15)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
