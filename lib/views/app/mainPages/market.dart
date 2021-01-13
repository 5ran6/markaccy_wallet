import 'package:flutterCrypto/import/Imports.dart';
import 'package:flutterCrypto/views/app/crypto.dart';

class MarketView extends StatefulWidget {
  const MarketView({Key key}) : super(key: key);

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  bool showSearch = false;
  /*Variable with the CryptoAPI instance to call the api functions present in
  /lib/services/CryptoAPI.dart*/
  final CryptoAPI cryptoAPI = CryptoAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _top(context),
              _filters(context),
              _list(context),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget with the title and bell*/
  Widget _top(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: FadeAnimation(
        0.5,
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showSearch
                      ? Container(
                          padding: EdgeInsets.only(left: 15),
                          width: 0.75.wp,
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey[100],
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: AppTheme.lightFontFamily,
                              ),
                            ),
                          ),
                        )
                      : Text(""),
                  IconButton(
                    iconSize: 60.h,
                    icon: showSearch
                        ? SvgPicture.asset(
                            'assets/icons/close.svg',
                            height: 50.h,
                            color: Theme.of(context).textSelectionHandleColor,
                          )
                        : Icon(
                            Icons.search,
                            size: 50.h,
                            color: Theme.of(context).textSelectionHandleColor,
                          ),
                    color: Theme.of(context).textSelectionHandleColor,
                    onPressed: () {
                      setState(() {
                        showSearch = !showSearch;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      AppLocalizations.of(context).translate('market'),
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontFamily: AppTheme.mediumFontFamily,
                        fontSize: ScreenUtil().setSp(70),
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/ui/market.png'),
                      height: 150.h,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  /*Horizontal list with all of the filters  */
  Widget _filters(BuildContext context) {
    return FadeAnimation(
      1,
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: Container(
          height: 130.h,
          child: ListView(
            padding: EdgeInsets.only(left: 15, bottom: 10, top: 5),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: AppTheme.blueTheme,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.blueTheme.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('following'),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "5",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.darkblueTheme.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ]),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('cryptocurrencies'),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(35),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "5",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: AppTheme.mediumFontFamily,
                              fontSize: ScreenUtil().setSp(35),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.darkblueTheme.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ]),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('utility_tokens'),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontFamily: AppTheme.mediumFontFamily,
                            fontSize: ScreenUtil().setSp(35),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "5",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: AppTheme.mediumFontFamily,
                              fontSize: ScreenUtil().setSp(35),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*Vertical List with all of the coins and tokens */
  Widget _list(BuildContext context) {
    /*Builder that will wait until the api request its done and then show the 
    data that was received, if the api isnt working the loader will never 
    end*/
    return FutureBuilder(
      /*Function that will be called when this user access this page */
      future: cryptoAPI.updateMarket(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          /*List variable with all crypto coins */
          List<dynamic> cryptos = snapshot.data;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeAnimation(1, _coins(context, cryptos[0])),
              FadeAnimation(1.2, _tokens(context, cryptos[1])),
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }

  /*Widget with the "Following" and "Cryptocurrencies list" */
  Widget _coins(BuildContext context, List<Cryptos> cryptos) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, top: 25),
          child: Text(
            AppLocalizations.of(context).translate('following'),
            style: TextStyle(
              color: Theme.of(context).textSelectionHandleColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(50),
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(bottom: 15, top: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return FadeAnimation(
              0.5,
              /*When the user taps this icon he will be redirected to 
              the individual page of this coin */
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CryptoView(
                      cryptoId: cryptos[index].id,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: 1.wp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: Image(
                              image: NetworkImage(
                                'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                                    cryptos[index].id.toString() +
                                    '.png',
                              ),
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
                                  cryptos[index].name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.mediumFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  cryptos[index].symbol,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.lightFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
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
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppTheme.mediumFontFamily,
                              color: Theme.of(context).textSelectionHandleColor,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: AutoSizeText(
                                cryptos[index]
                                        .quote
                                        .usd
                                        .percentChange24H
                                        .toStringAsFixed(2) +
                                    '%',
                                style: TextStyle(
                                  color: cryptos[index]
                                          .quote
                                          .usd
                                          .percentChange24H
                                          .toString()
                                          .contains('-')
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
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 2),
          child: Text(
            AppLocalizations.of(context).translate('cryptocurrencies'),
            style: TextStyle(
              color: Theme.of(context).textSelectionHandleColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(50),
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(bottom: 15, top: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cryptos.length,
          itemBuilder: (context, index) {
            return FadeAnimation(
              0.5,

              /*When the user taps this icon he will be redirected to 
              the individual page of this coin */
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CryptoView(
                      cryptoId: cryptos[index].id,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: 1.wp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: Image(
                              image: NetworkImage(
                                'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                                    cryptos[index].id.toString() +
                                    '.png',
                              ),
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
                                  cryptos[index].name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.mediumFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  cryptos[index].symbol,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.lightFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
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
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppTheme.mediumFontFamily,
                              color: Theme.of(context).textSelectionHandleColor,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: AutoSizeText(
                                cryptos[index]
                                        .quote
                                        .usd
                                        .percentChange24H
                                        .toStringAsFixed(2) +
                                    '%',
                                style: TextStyle(
                                  color: cryptos[index]
                                          .quote
                                          .usd
                                          .percentChange24H
                                          .toString()
                                          .contains('-')
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
            );
          },
        ),
      ],
    );
  }

  /*Widget with the "Utility Tokens" list */
  Widget _tokens(BuildContext context, List<Cryptos> cryptos) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, top: 2),
          child: Text(
            AppLocalizations.of(context).translate('utility_tokens'),
            style: TextStyle(
              color: Theme.of(context).textSelectionHandleColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(50),
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(bottom: 60, top: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return FadeAnimation(
              0.5,

              /*When the user taps this icon he will be redirected to 
              the individual page of this token */
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CryptoView(
                      cryptoId: cryptos[index].id,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: 1.wp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: Image(
                              image: NetworkImage(
                                'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                                    cryptos[index].id.toString() +
                                    '.png',
                              ),
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
                                  cryptos[index].name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.mediumFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  cryptos[index].symbol,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor,
                                      fontFamily: AppTheme.lightFontFamily,
                                      fontSize: ScreenUtil().setSp(40)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
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
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppTheme.mediumFontFamily,
                              color: Theme.of(context).textSelectionHandleColor,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: AutoSizeText(
                                cryptos[index]
                                        .quote
                                        .usd
                                        .percentChange24H
                                        .toStringAsFixed(2) +
                                    '%',
                                style: TextStyle(
                                  color: cryptos[index]
                                          .quote
                                          .usd
                                          .percentChange24H
                                          .toString()
                                          .contains('-')
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
            );
          },
        ),
      ],
    );
  }
}
