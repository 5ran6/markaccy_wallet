import 'dart:ui';

import 'package:flutterCrypto/import/Imports.dart';
import 'package:flutterCrypto/views/app/crypto.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 40, bottom: 60, left: 15, right: 15),
                child: _top(context, firebaseUser),
              ),
              _movers(context),
              _activity(context),
           //   _news(context),
            ],
          ),
        ),

        //_news(context),
      ),
    );
  }

  /*Widget with the title and bell*/
  Widget _top(BuildContext context, FirebaseUser firebaseUser) {
    return FadeAnimation(
      0.5,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('hello') + ',',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppTheme.lightFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                    color: Theme.of(context).textSelectionHandleColor,
                  ),
                ),
              ),
              AutoSizeText(
                firebaseUser != null && firebaseUser.displayName != null
                    ? firebaseUser.displayName
                    : "Anonymous",
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(70),
                ),
              ),
            ],
          ),
          Stack(children: [
            SvgPicture.asset(
              'assets/icons/alarm.svg',
              height: 50.h,
              color: Theme.of(context).textSelectionHandleColor,
            ),
            Positioned(
              child: Icon(
                Icons.brightness_1,
                size: 9,
                color: AppTheme.orangeTheme,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  /*The individual container of each top mover will be generated here
  with the information present in lib/model/CryptoCoins.dart.*/

  Widget _movers(BuildContext context) {
    CryptoAPI cryptoAPI = CryptoAPI();
    return FadeAnimation(
      0.8,
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30, left: 20),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('top_movers'),
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(50),
                    color: Theme.of(context).textSelectionHandleColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30, right: 40),
                child: SvgPicture.asset(
                  'assets/icons/market.svg',
                  height: 40.h,
                  color: Theme.of(context).textSelectionHandleColor,
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: cryptoAPI.rank(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                /*List variable with all crypto coins */
                List<Cryptos> crypto = snapshot.data;
                return _moversFuture(context, crypto);
              } else {
                return Loading();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _moversFuture(BuildContext context, List<Cryptos> cryptos) {
    return Container(
      height: 0.24.hp,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cryptos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 15, right: 8),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CryptoView(
                    cryptoId: cryptos[index].id,
                  ),
                ),
              ),
              child: Container(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
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
                width: 0.4.wp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: AutoSizeText(
                        cryptos[index]
                                .quote
                                .usd
                                .percentChange24H
                                .toStringAsFixed(2) +
                            '%',
                        maxLines: 1,
                        minFontSize: 5,
                        maxFontSize: 60,
                        style: TextStyle(
                          color: cryptos[index]
                                  .quote
                                  .usd
                                  .percentChange24H
                                  .toString()
                                  .contains("-")
                              ? Colors.redAccent
                              : Colors.greenAccent,
                          fontFamily: AppTheme.lightFontFamily,
                          fontSize: ScreenUtil().setSp(70),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                                cryptos[index].id.toString() +
                                '.png',
                          ),
                          fit: BoxFit.contain,
                          width: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                cryptos[index].symbol,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppTheme.mediumFontFamily,
                                  color: Theme.of(context).textSelectionColor,
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                              ),
                              SizedBox(
                                width: 0.17.wp,
                                child: AutoSizeText(
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
                                  maxLines: 1,
                                  minFontSize: 10,
                                  maxFontSize: 60,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(40),
                                    fontFamily: AppTheme.mediumFontFamily,
                                    color: Theme.of(context)
                                        .textSelectionHandleColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /*#3D Chart Modal with the account balance */
  Widget _activity(BuildContext context) {
    return FadeAnimation(
      1.1,
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GestureDetector(
          onTap: () {
            //When user clicks on activity box the full acitivty page will appear
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                child: ActivityView(),
              ),
            );
          },
          child: Container(
            width: 1.wp,
            height: 0.3.hp,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  width: 1.wp,
                  height: 0.25.hp,
                  decoration: BoxDecoration(
                      color: AppTheme.blueTheme,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.blueTheme.withOpacity(0.5),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: 'activity_text',
                            child: Material(
                              child: AutoSizeText(
                                AppLocalizations.of(context)
                                    .translate('activity'),
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                minFontSize: 10,
                                maxFontSize: 50,
                                style: TextStyle(
                                  fontFamily: AppTheme.mediumFontFamily,
                                  fontSize: ScreenUtil().setSp(50),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Material(
                            child: AutoSizeText(
                              "April 10, 2020 ",
                              maxFontSize: 30,
                              minFontSize: 15,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                color: Colors.grey[200],
                                fontFamily: AppTheme.lightFontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Hero(
                        tag: 'last_activity',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
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
                                    cryptoCoins[0].image,
                                    fit: BoxFit.contain,
                                    width: 70.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(cryptoCoins[0].code,
                                      style: TextStyle(
                                          color: Colors.grey[200],
                                          fontFamily: AppTheme.lightFontFamily,
                                          fontSize: ScreenUtil().setSp(40))),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5, left: 20),
                                  child: Material(
                                    child: AutoSizeText(
                                      'Buy',
                                      maxFontSize: 50,
                                      minFontSize: 12,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(40),
                                        color: Colors.white,
                                        fontFamily: AppTheme.mediumFontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, bottom: 5),
                                  child: Material(
                                    child: AutoSizeText(
                                      "+ €624,29",
                                      maxFontSize: 40,
                                      minFontSize: 9,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(40),
                                          color: Colors.greenAccent,
                                          fontFamily:
                                              AppTheme.mediumFontFamily),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0,
                child: Hero(
                  tag: 'activity_chart',
                  child: Image(
                    image: AssetImage('assets/ui/activity_chart.png'),
                    width: 380.w,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  /*The individual container of each new will be generated here
  with the information present in lib/model/News.dart.*/

  Widget _news(BuildContext context) {
    return Column(
      children: [
        FadeAnimation(
          1.8,
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: AutoSizeText(
                  AppLocalizations.of(context).translate('news'),
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(50),
                    color: Theme.of(context).textSelectionHandleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        FadeAnimation(
          2.0,
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cryptoNews.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: NewDetailView(
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40, left: 25, right: 20),
                    child: Container(
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
                      width: 0.8.wp,
                      height: 350.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: '${index.toString()}image',
                            child: Container(
                              height: 1.hp,
                              width: 0.3.wp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                image: DecorationImage(
                                  image: NetworkImage(cryptoNews[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                      color: Colors.black.withOpacity(0.2)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Material(
                                        child: SizedBox(
                                          width: 0.4.wp,
                                          child: AutoSizeText(
                                            cryptoNews[index].title,
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppTheme.mediumFontFamily,
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontSize: ScreenUtil().setSp(40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      child: SizedBox(
                                        width: 0.4.wp,
                                        child: AutoSizeText(
                                          cryptoNews[index].subtitle,
                                          textAlign: TextAlign.start,
                                          maxLines: 3,
                                          minFontSize: 5,
                                          maxFontSize: 40,
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(40),
                                            fontFamily:
                                                AppTheme.lightFontFamily,
                                            color: Theme.of(context)
                                                .textSelectionHandleColor,
                                          ),
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
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
