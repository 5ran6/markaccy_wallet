import 'package:flutterCrypto/import/Imports.dart';
import 'package:flutterCrypto/model/Notifications.dart';

class WalletNotificationsView extends StatefulWidget {
  const WalletNotificationsView({Key key}) : super(key: key);

  @override
  _WalletNotificationsViewState createState() =>
      _WalletNotificationsViewState();
}

class _WalletNotificationsViewState extends State<WalletNotificationsView> {
  List<Notifications> _notificationsList = notifications;

  @override
  Widget build(BuildContext context) {
    print(_notificationsList.length);
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15, top: 25),
          child: SafeArea(
            child: Column(
              children: [
                _top(context),
                _notificationsList.length == 0
                    ? _noNotification(context)
                    : _notifications(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return FadeAnimation(
      0.8,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).translate('notifications'),
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(70),
            ),
          ),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: AppTheme.blueTheme,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.blueTheme.withOpacity(0.5),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ]),
            child: Center(
              child: Text(
                _notificationsList.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notifications(BuildContext context) {
    return FadeAnimation(
      1,
      Container(
        padding: EdgeInsets.only(top: 50),
        height: 1.hp,
        child: ListView.builder(
          itemCount: _notificationsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: ObjectKey(_notificationsList[index]),
                onDismissed: (direction) {
                  setState(() {
                    _notificationsList.removeAt(index);
                  });
                },
                child: Container(
                  height: 250.h,
                  width: 1.wp,
                  padding: EdgeInsets.all(15),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        _notificationsList[index].image,
                        height: 70.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                _notificationsList[index].title,
                                style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                  fontFamily: AppTheme.mediumFontFamily,
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                              ),
                            ),
                            Text(
                              _notificationsList[index].subtitle,
                              style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
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
          },
        ),
      ),
    );
  }

  /*Widget that will appear when the user dont have notifications */
  Widget _noNotification(BuildContext context) {
    return Container(
      height: 0.6.hp,
      width: 1.wp,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 500.h,
              child: FlareActor(
                'assets/animations/global/no_notification.flr',
                animation: 'appear',
              ),
            ),
            Text(
              AppLocalizations.of(context).translate('no_notifications'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: ScreenUtil().setSp(50),
                fontFamily: AppTheme.mediumFontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
