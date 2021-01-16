import 'package:flutterCrypto/import/Imports.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedItemPosition = 0;
  final navigatorKey = new GlobalKey<NavigatorState>();
  String view = '/';
  bool isDark = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<FirebaseUser>(context);

    ScreenUtil.init(context);

    /*Logic to set the initial page when the user logs in */

    if (firebaseUser == null) {
      view = '/';
      _selectedItemPosition = 0;
    }

    return Consumer<ThemeNotifier>(
      builder: (context, appState, child) {
        /*Logic to set the Theme of the application */

        if (appState.systemTheme) {
          if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
            isDark = true;
          } else {
            isDark = false;
          }
        } else if (appState.isDarkModeOn) {
          isDark = true;
        } else {
          isDark = false;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: firebaseUser != null
              ? WillPopScope(
                  onWillPop: () async {
                    if (navigatorKey.currentState.canPop()) {
                      setState(() {
                        navigatorKey.currentState.pop();
                      });

                      return false;
                    }

                    return true;
                  },
                  child: Scaffold(
                    key: _scaffoldKey,
                    extendBody: true,
                    body:
                        /*Router Widget that will change the page corresponding to selected
          bottom navigation bar icon */

                        TabNavigator(
                      tabItem: view,
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      elevation: 50,
                      iconSize: 55.h,
                      type: BottomNavigationBarType.fixed,
                      fixedColor: Color(0xff2398C3),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      backgroundColor: isDark
                          ? AppTheme.darkTheme.cardColor
                          : AppTheme.lightTheme.cardColor,
                      currentIndex: _selectedItemPosition,
                      onTap: handleNavigationChange,
                      items: menuitems,
                      unselectedIconTheme: isDark
                          ? AppTheme.darkTheme.iconTheme
                          : AppTheme.lightTheme.iconTheme,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: Container(
                      height: 150.h,
                      width: 150.h,
                      decoration: BoxDecoration(
                          color: AppTheme.darkblueTheme,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.blueTheme.withOpacity(0.5),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        onPressed: () => _bottomSheet(),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/arrows_hori.svg',
                            color: Colors.white,
                            height: 70.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  extendBody: true,
                  body: Auth(),
                ),

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          supportedLocales: languageCodes,
          localizationsDelegates: [
            //A class which loads the trtanslations from JSON files
            AppLocalizations.delegate,
            //Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            //Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          //Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            //Check if the current device locale is supported
            for (var supportedLocales in supportedLocales) {
              if (supportedLocales.languageCode == locale.languageCode &&
                  supportedLocales.countryCode == locale.countryCode) {
                return supportedLocales;
              }
            }
            //TODO: set the default language dynamically...not statically choosing English

            //If the locale of the device is not supported, use the first one
            //from the list (English, in this case)
//            return supportedLocales.elementAt(1);
            return supportedLocales.first;
          },
        );
      },
    );
  }

  /*Function that will be shown when user press bottom floatingActionButton*/
  void _bottomSheet() {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      expand: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          height: 0.5.hp,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Theme.of(_scaffoldKey.currentContext).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyView(
                      contextBack: _scaffoldKey.currentContext,
                    ),
                  ),
                ),
                child: Container(
                  width: 1.wp,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppTheme.iconContainerColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.blueTheme.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: Image.asset(
                          'assets/icons/buy_crypto.png',
                          color: Colors.white,
                          height: 65.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('buy'),
                              maxFontSize: 37,
                              minFontSize: 6,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: AppTheme.mediumFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            ),
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('buy_text'),
                              maxFontSize: 50,
                              minFontSize: 8,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: AppTheme.lightFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellView(
                      contextBack: _scaffoldKey.currentContext,
                    ),
                  ),
                ),
                child: Container(
                  width: 1.wp,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppTheme.iconContainerColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.blueTheme.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: Image.asset(
                          'assets/icons/sell_crypto.png',
                          color: Colors.white,
                          height: 65.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('sell'),
                              maxFontSize: 37,
                              minFontSize: 6,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: AppTheme.mediumFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            ),
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('sell_text'),
                              maxFontSize: 50,
                              minFontSize: 8,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: AppTheme.lightFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConvertView(
                      contextBack: _scaffoldKey.currentContext,
                    ),
                  ),
                ),
                child: Container(
                  width: 1.wp,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppTheme.iconContainerColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.blueTheme.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: Image.asset(
                          'assets/icons/convert.png',
                          color: Colors.white,
                          height: 65.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('convert'),
                              maxFontSize: 37,
                              minFontSize: 6,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: AppTheme.mediumFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            ),
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('convert_text'),
                              maxFontSize: 50,
                              minFontSize: 8,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: AppTheme.lightFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendView(
                      contextBack: _scaffoldKey.currentContext,
                    ),
                  ),
                ),
                child: Container(
                  width: 1.wp,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppTheme.iconContainerColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.blueTheme.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: Image.asset(
                          'assets/icons/arrow_up.png',
                          color: Colors.white,
                          height: 60.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('send'),
                              maxFontSize: 37,
                              minFontSize: 6,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: AppTheme.mediumFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            ),
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('send_text'),
                              maxFontSize: 50,
                              minFontSize: 8,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: AppTheme.lightFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiveView(
                      contextBack: _scaffoldKey.currentContext,
                    ),
                  ),
                ),
                child: Container(
                  width: 1.wp,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppTheme.iconContainerColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.blueTheme.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: Image.asset(
                          'assets/icons/arrow_down.png',
                          color: Colors.white,
                          height: 60.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('receive'),
                              maxFontSize: 37,
                              minFontSize: 6,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: AppTheme.mediumFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            ),
                            AutoSizeText(
                              AppLocalizations.of(_scaffoldKey.currentContext)
                                  .translate('receive_text'),
                              maxFontSize: 50,
                              minFontSize: 8,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: AppTheme.lightFontFamily,
                                color: Theme.of(_scaffoldKey.currentContext)
                                    .textSelectionHandleColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Function that will handle the navigation with bottom navigation bar updating
  variables and calling the new pages*/

  void handleNavigationChange(int index) {
    setState(
      () {
        if (_selectedItemPosition == index) {
          return null;
        } else {
          _selectedItemPosition = index;

          view = menuitems[index].label;
        }
      },
    );
  }

}
