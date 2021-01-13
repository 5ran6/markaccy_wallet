import 'package:flutterCrypto/import/Imports.dart';

class SellView extends StatefulWidget {
  final BuildContext contextBack;
  const SellView({Key key, this.contextBack}) : super(key: key);

  @override
  _SellViewState createState() => _SellViewState();
}

class _SellViewState extends State<SellView> {
  String value = "";
  final CryptoAPI cryptoAPI = CryptoAPI();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                /*Function that will be called when this user access this page */
                future: cryptoAPI.buyList(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    /*List variable with all crypto coins */
                    List<dynamic> cryptos = snapshot.data;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1,
                          _list(context, cryptos),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: 0.5.hp,
                      color:
                          Theme.of(widget.contextBack).scaffoldBackgroundColor,
                      child: Center(
                        child: SizedBox(
                          height: 0.1.hp,
                          child: FlareActor(
                            'assets/animations/global/animated_circle.flr',
                            animation: 'loading',
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
/*Widget with the top title and buttons */

  Widget _top(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: AutoSizeText(
        AppLocalizations.of(widget.contextBack)
            .translate('select_asset_to_sell'),
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

  Widget _list(BuildContext context, List<Cryptos> cryptos) {
    return Column(
      children: [
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
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: BuyAmountView(
                      contextBack: widget.contextBack,
                      coinName: cryptos[index].name,
                    ),
                  ),
                ),
                child: Container(
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
                            child: Image(
                              image: NetworkImage(
                                'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                                    cryptos[index].id.toString() +
                                    '.png',
                              ),
                              fit: BoxFit.contain,
                              width: 100.w,
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
                                      color: Theme.of(widget.contextBack)
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
                              color: Theme.of(widget.contextBack)
                                  .textSelectionHandleColor,
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
                                    .toStringAsFixed(2),
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
