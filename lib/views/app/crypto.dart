import 'package:flutterCrypto/import/Imports.dart';

class CryptoView extends StatefulWidget {
  final int cryptoId;

  CryptoView({this.cryptoId});
  @override
  _CryptoViewState createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  int graphData = 0;

  /*List of all points taht make the 4 graphs  */
  List data = [
    [
      FlSpot(0, 3),
      FlSpot(2.6, 2),
      FlSpot(4.9, 5),
      FlSpot(6.8, 3.1),
      FlSpot(8, 4),
      FlSpot(9.5, 3),
      FlSpot(11, 4),
    ],
    [
      FlSpot(0, 5),
      FlSpot(3, 4),
      FlSpot(6, 4.5),
      FlSpot(7, 3.1),
      FlSpot(8, 2),
      FlSpot(9.5, 3),
      FlSpot(11, 2),
    ],
    [
      FlSpot(0, 1),
      FlSpot(3, 3),
      FlSpot(6, 4),
      FlSpot(7, 4.5),
      FlSpot(8, 5.6),
      FlSpot(9.5, 4.5),
      FlSpot(11, 6),
    ],
    [
      FlSpot(0, 3),
      FlSpot(2.6, 2),
      FlSpot(4.9, 5),
      FlSpot(6.8, 3.1),
      FlSpot(8, 4),
      FlSpot(9.5, 3),
      FlSpot(11, 4),
    ]
  ];
  /*Variable with the CryptoAPI instance to call the api functions present in
  /lib/services/CryptoAPI.dart*/
  CryptoAPI cryptoAPI = CryptoAPI();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cryptoAPI.individualCoin(widget.cryptoId),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          /*List variable with all crypto coins */
          IndCrypto crypto = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/double_arrows_left.svg',
                    height: 50.h,
                    color: Theme.of(context).textSelectionHandleColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: _top(context, crypto),
            ),
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return null;
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _price(context, crypto),
                    _graph(context),
                    _sort(context),
                    _highLow(context, crypto),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
  /*This widget represents top AppBar context  */

  Widget _top(BuildContext context, IndCrypto crypto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          crypto.name,
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontFamily: AppTheme.mediumFontFamily,
            fontSize: ScreenUtil().setSp(60),
          ),
        ),
        SvgPicture.asset(
          'assets/icons/star_half.svg',
          color: Theme.of(context).textSelectionHandleColor,
          width: 80.w,
        )
      ],
    );
  }

  /*This widget represents the price above the graph  */

  Widget _price(BuildContext context, IndCrypto crypto) {
    return Padding(
        padding: EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                'https://s2.coinmarketcap.com/static/img/coins/64x64/' +
                    crypto.id.toString() +
                    '.png',
              ),
              fit: BoxFit.contain,
              width: 110.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    crypto.symbol,
                    style: TextStyle(
                      color: Theme.of(context).textSelectionHandleColor,
                      fontFamily: AppTheme.lightFontFamily,
                      fontSize: ScreenUtil().setSp(40),
                    ),
                  ),
                  Row(
                    children: [
                      AutoSizeText(
                        '€ ' + crypto.price.toStringAsFixed(4),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: AutoSizeText(
                          crypto.percentChange24H.toStringAsFixed(4) + '%',
                          style: TextStyle(
                            color:
                                crypto.percentChange24H.toString().contains('-')
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                            fontFamily: AppTheme.mediumFontFamily,
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
        ));
  }

  /*This widget represents the graph  */

  Widget _graph(BuildContext context) {
    return Container(
      height: 0.4.hp,
      width: 1.wp,
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
                  data[graphData],
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

  /*This widget represents the buttons below the graph to change his value */

  Widget _sort(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*This widget will detect user touch and if the user taps this container
          the graph will change his values to the first data set */
          GestureDetector(
            onTap: () {
              setState(() {
                graphData = 0;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: 0.15.wp,
              decoration:
                  /*If the 1H is selected the box decoration will show  */
                  graphData == 0
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.shadowColor,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ])
                      : null,
              child: AutoSizeText(
                "1H",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
          /*This widget will detect user touch and if the user taps this container
          the graph will change his values to the second data set */
          GestureDetector(
            onTap: () {
              setState(() {
                graphData = 1;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: 0.15.wp,
              decoration:
                  /*If the 1D is selected the box decoration will show  */
                  graphData == 1
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.shadowColor,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ])
                      : null,
              child: AutoSizeText(
                "1D",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
          /*This widget will detect user touch and if the user taps this container
          the graph will change his values to the third data set */
          GestureDetector(
            onTap: () {
              setState(() {
                graphData = 2;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: 0.15.wp,
              decoration:
                  /*If the 1W is selected the box decoration will show  */
                  graphData == 2
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.shadowColor,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ])
                      : null,
              child: AutoSizeText(
                "1W",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
          /*This widget will detect user touch and if the user taps this container
          the graph will change his values to the fourth data set */
          GestureDetector(
            onTap: () {
              setState(() {
                graphData = 3;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: 0.15.wp,
              decoration:
                  /*If the 1M is selected the box decoration will show  */
                  graphData == 3
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.shadowColor,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ])
                      : null,
              child: AutoSizeText(
                "1M",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  /*This widget shows the low and high values of the coin  */

  Widget _highLow(BuildContext context, IndCrypto crypto) {
    return Padding(
      padding: EdgeInsets.only(left: 25, top: 10, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                AppLocalizations.of(context).translate('high'),
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
              AutoSizeText(
                '€ ' + (crypto.price * 1.1).toStringAsFixed(5),
                style: TextStyle(
                  color: Theme.of(context).textSelectionHandleColor,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  AppLocalizations.of(context).translate('low'),
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
                AutoSizeText(
                  '€ ' + crypto.price.toStringAsFixed(5),
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
