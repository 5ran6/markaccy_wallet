import 'package:flutterCrypto/import/Imports.dart';

class WalletSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 70),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _top(context),
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
                _profile(context),
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
                _security(context),
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
                _aboutUs(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context).translate('settings'),
          style: TextStyle(
            color: Theme.of(context).textSelectionColor,
            fontFamily: AppTheme.mediumFontFamily,
            fontSize: ScreenUtil().setSp(70),
          ),
        ),
      ],
    );
  }

  Widget _profile(BuildContext context) {
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
            Container(
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
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
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

  Widget _security(BuildContext context) {
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

  Widget _aboutUs(BuildContext context) {
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
}
