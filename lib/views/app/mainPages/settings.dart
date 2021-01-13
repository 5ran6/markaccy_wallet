import 'dart:async';

import 'package:flutterCrypto/import/Imports.dart';
import 'package:flutterCrypto/views/wallet/home.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Function(bool) onSelection}) {
    onSelectionChange = onSelection;
  }
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _switchTimer = true;
  bool _bioSwitch = false;

  @override
  Widget build(BuildContext context) {
    checkSystemAnimation(context);
    final firebaseUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _top(firebaseUser),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('profile'),
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
              _profile(),

              Padding(
                padding: EdgeInsets.only(top: 40),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('appearance'),
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
              //This button will change the App Theme corresponding to the Mobile Theme
              _themeChanger(),

              Padding(
                padding: EdgeInsets.only(top: 40),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('security'),
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
              _security(),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('about_us'),
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
              _aboutUs(),

              _logout(),
              _wallet(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top(FirebaseUser firebaseUser) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeAnimation(
            0.2,
            AutoSizeText(
              firebaseUser != null && firebaseUser.displayName != null
                  ? firebaseUser.displayName
                  : "Anonymous",
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).textSelectionHandleColor,
                fontFamily: AppTheme.mediumFontFamily,
                fontSize: ScreenUtil().setSp(70),
              ),
            ),
          ),
          firebaseUser.photoUrl != null
              ? CircleAvatar(
                  radius: 70.h,
                  backgroundImage: NetworkImage(
                    firebaseUser.photoUrl,
                  ))
              : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppTheme.iconContainerColor,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.blueTheme.withOpacity(0.5),
                          blurRadius: 6,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: SvgPicture.asset(
                    'assets/icons/user.svg',
                    height: 70.h,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _profile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppTheme.iconContainerColor,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.blueTheme.withOpacity(0.5),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: SvgPicture.asset(
                        'assets/icons/user.svg',
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: AutoSizeText(
                        AppLocalizations.of(context).translate('personal_data'),
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  child: LinkedAccountsView(),
                ),
              ),
              child: Container(
                width: 1.wp,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Row(
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
                        child: SvgPicture.asset(
                          'assets/icons/credit_cards.svg',
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: AutoSizeText(
                          AppLocalizations.of(context)
                              .translate('linked_accounts'),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(40),
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppTheme.iconContainerColor,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.blueTheme.withOpacity(0.5),
                            blurRadius: 6,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: SvgPicture.asset(
                      'assets/icons/text_format.svg',
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('documents'),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(40),
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeChanger() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 1.wp,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                        child: SvgPicture.asset(
                          'assets/icons/light.svg',
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: AutoSizeText(
                          AppLocalizations.of(context).translate('theme'),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(40),
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60.h,
                    width: 0.4.wp,
                    child: GestureDetector(
                      onTap: _switchTimer
                          ? () {
                              // making it false when onTap() is pressed and after 1 second we'll make it true
                              setState(() => _switchTimer = false);
                              Timer(Duration(milliseconds: 700),
                                  () => setState(() => _switchTimer = true));
                              checkAnimationState(context);
                              // your implementation
                            }
                          : null,
                      child: FlareActor(
                        "assets/animations/settings/themeSwitch.flr",
                        alignment: Alignment.centerRight,
                        controller: animationController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: FlatButton(
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .updatBySystem(true);
                },
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('system_default'),
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(30),
                    color: Theme.of(context).textSelectionColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _security() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: PinView(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
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
                        child: SvgPicture.asset(
                          'assets/icons/lock.svg',
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: AutoSizeText(
                          AppLocalizations.of(context)
                              .translate('change_passcode'),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(40),
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                          child: ImageIcon(
                            AssetImage('assets/icons/bio_lock.png'),
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 36),
                          child: AutoSizeText(
                            AppLocalizations.of(context).translate('bio_lock'),
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: AppTheme.mediumFontFamily,
                              fontSize: ScreenUtil().setSp(40),
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FSwitch(
                      height: 20,
                      width: 45,
                      onChanged: (bool value) {
                        setState(() {
                          _bioSwitch = value;
                        });
                      },
                      open: _bioSwitch,
                      enable: true,
                      shadowColor: Colors.black.withOpacity(0.5),
                      openColor: AppTheme.blueTheme,
                      shadowBlur: 3.0,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppTheme.iconContainerColor,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.blueTheme.withOpacity(0.5),
                            blurRadius: 6,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: SvgPicture.asset(
                      'assets/icons/shield.svg',
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('privacy'),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(40),
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutUs() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppTheme.iconContainerColor,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.blueTheme.withOpacity(0.5),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: SvgPicture.asset(
                        'assets/icons/star.svg',
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: AutoSizeText(
                        AppLocalizations.of(context).translate('rate_us'),
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppTheme.iconContainerColor,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.blueTheme.withOpacity(0.5),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: SvgPicture.asset(
                        'assets/icons/certificate.svg',
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: AutoSizeText(
                        AppLocalizations.of(context).translate('policy'),
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppTheme.iconContainerColor,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.blueTheme.withOpacity(0.5),
                            blurRadius: 6,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: ImageIcon(
                      AssetImage('assets/icons/terms.png'),
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('terms'),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(40),
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget with the logout button */

  Widget _logout() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () => _alert(context),
              child: Container(
                width: 1.wp,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
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
                        child: SvgPicture.asset(
                          'assets/icons/trash.svg',
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: AutoSizeText(
                          AppLocalizations.of(context)
                              .translate('delete_account'),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(40),
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: FlatButton(
                padding: EdgeInsets.only(left: 0),
                onPressed: () => AuthService().signOut(context),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppTheme.iconContainerColor,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.blueTheme.withOpacity(0.5),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: ImageIcon(
                        AssetImage('assets/icons/logout.png'),
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: AutoSizeText(
                        AppLocalizations.of(context).translate('logout'),
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(40),
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wallet() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WalletView(),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ]),
            width: 0.5.wp,
            child: Text(
              "WALLET TEMPLATE",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textSelectionHandleColor,
                fontFamily: AppTheme.lightFontFamily,
                fontSize: ScreenUtil().setSp(50),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _alert(BuildContext context) {
    showDialog(
        barrierColor: AppTheme.darkblueTheme.withOpacity(0.7),
        context: context,
        builder: (context) {
          return CustomDialog(
            title: AppLocalizations.of(this.context)
                .translate('account_delete_text'),
            description:
                AppLocalizations.of(this.context).translate('account_delete'),
            buttonText: AppLocalizations.of(this.context).translate('confirm'),
            type: 'failure',
            contextBack: context,
          );
        });
  }
}
