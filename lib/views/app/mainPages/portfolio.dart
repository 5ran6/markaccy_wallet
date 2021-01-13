import 'package:flutterCrypto/import/Imports.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppTheme.blueTheme,
              leading: null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              expandedHeight: 0.42.hp,
              pinned: true,
              floating: false,
              elevation: 15,
              forceElevated: true,
              shadowColor: AppTheme.blueTheme.withOpacity(0.5),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    AppLocalizations.of(context).translate('portfolio'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppTheme.mediumFontFamily,
                      fontSize: ScreenUtil().setSp(70),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/graph.png',
                    height: 60.h,
                    color: Colors.grey[100],
                  )
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: _top(context),
              ),
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  width: 0.8.wp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('coin'),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionHandleColor,
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('holdings'),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionHandleColor,
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('price'),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionHandleColor,
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                    ],
                  ),
                ),
                childCount: 1,
              ),
              itemExtent: 130.h,
            ),
            _crypto(context),
          ],
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return Container(
      height: 0.45.hp,
      child: Stack(
        children: [
          /*Calling _balance Widget to show the total Value and percentage*/
          _balance(context),

          /*Calling _mostCrypto Widget to show the trending crypto and his 
          holding value*/
          _mostCrypto(context),
        ],
      ),
    );
  }

  Widget _balance(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 0.42.hp,
      width: 1.wp,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              child: Text(
                AppLocalizations.of(context).translate('total_value'),
                style: TextStyle(
                  color: Colors.grey[200],
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(50),
                ),
              ),
            ),
            Material(
              child: Text(
                "€1682.45683",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(60),
                ),
              ),
            ),
            Material(
              child: Text(
                "18.6%",
                style: TextStyle(
                  color: "18.6%".contains("-")
                      ? Colors.redAccent
                      : Colors.greenAccent,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mostCrypto(BuildContext context) {
    return Positioned(
      width: 1.2.wp,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'most_crypto',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    child: Image.asset(
                      'assets/crypto_icons/trx.png',
                      fit: BoxFit.contain,
                      width: 90.w,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, left: 15),
                        child: Material(
                          child: AutoSizeText(
                            cryptoCoins[7].name,
                            maxFontSize: 50,
                            minFontSize: 12,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                              color: Colors.white,
                              fontFamily: AppTheme.lightFontFamily,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 5),
                        child: Material(
                          child: AutoSizeText(
                            "€ 624,29",
                            maxFontSize: 40,
                            minFontSize: 9,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(50),
                                color: Colors.white,
                                fontFamily: AppTheme.mediumFontFamily),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Material(
                          child: AutoSizeText(
                            '1505,36546 TRX',
                            maxFontSize: 37,
                            minFontSize: 6,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(40),
                              fontFamily: AppTheme.lightFontFamily,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Hero(
                tag: 'circular_chart',
                child: Image(
                  image: AssetImage('assets/ui/circular_chart.png'),
                  width: 500.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*List of all Crypto Coins that are present in lib/model/CryptoCoins.dart */
  Widget _crypto(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 25, bottom: 70),
      sliver: SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => FadeAnimation(
            0.5,
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WalletCoinView(
                    accountId: index,
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: 1.wp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            cryptoCoins[index].code,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textSelectionHandleColor,
                                fontFamily: AppTheme.lightFontFamily,
                                fontSize: ScreenUtil().setSp(40)),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          /*The price of the coin ist being multiplied by 3 and 
                          converted to string until his 5 decimal places */
                          '€ ' +
                              (cryptoCoins[index].price * 3).toStringAsFixed(5),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: AppTheme.mediumFontFamily,
                            color: Theme.of(context).textSelectionHandleColor,
                            fontSize: ScreenUtil().setSp(40),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: AutoSizeText('3.00',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textSelectionHandleColor,
                                fontFamily: AppTheme.lightFontFamily,
                                fontSize: ScreenUtil().setSp(40),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          '€ ' + cryptoCoins[index].price.toString(),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: AppTheme.mediumFontFamily,
                            color: Theme.of(context).textSelectionHandleColor,
                            fontSize: ScreenUtil().setSp(40),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: AutoSizeText(cryptoCoins[index].percen,
                              style: TextStyle(
                                color: cryptoCoins[index].percen.contains('-')
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                fontFamily: AppTheme.lightFontFamily,
                                fontSize: ScreenUtil().setSp(40),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          childCount: cryptoCoins.length,
        ),
        itemExtent: 210.h,
      ),
    );
  }
}
