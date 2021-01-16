import 'package:flutterCrypto/import/Imports.dart';
import 'package:intl/intl.dart';

/*In this page will be a graph with the data of the investment 
and all the transactions done in this cryptocoin account */
class WalletCoinView extends StatefulWidget {
  final int accountId;

  WalletCoinView({this.accountId});

  @override
  _WalletCoinViewState createState() => _WalletCoinViewState();
}

class _WalletCoinViewState extends State<WalletCoinView> {
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

  @override
  Widget build(BuildContext context) {
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
        title: _top(context),
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
              _price(context),
              _graph(context),
              _sort(context),
              _transactions(context),
            ],
          ),
        ),
      ),
    );
  }
  /*This widget represents top AppBar context  */

  Widget _top(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          cryptoCoins[widget.accountId].name,
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

  Widget _price(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              cryptoCoins[widget.accountId].image,
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
                    '3.00 ' + cryptoCoins[widget.accountId].code,
                    style: TextStyle(
                      color: Theme.of(context).textSelectionHandleColor,
                      fontFamily: AppTheme.lightFontFamily,
                      fontSize: ScreenUtil().setSp(40),
                    ),
                  ),
                  Row(
                    children: [
                      AutoSizeText(
                        '€ ' +
                            (cryptoCoins[widget.accountId].price * 3)
                                .toStringAsFixed(5),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontFamily: AppTheme.mediumFontFamily,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: AutoSizeText(
                          cryptoCoins[widget.accountId].percen,
                          style: TextStyle(
                            color: cryptoCoins[widget.accountId]
                                    .percen
                                    .contains('-')
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
        //TODO: get real values and set real min and max x and y

        LineChartData(
          gridData: FlGridData(
            show: false,
            drawHorizontalLine: true,
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
            show: true,
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
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
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

  Widget _transactions(BuildContext context) {
    /*This query will search through all the transactions trying to 
    find the ones with the same Crypto coin code   */
    List<Transactions> transactionsList = transactions
        .where((transaction) =>
            transaction.code.contains(cryptoCoins[widget.accountId].code))
        .toList();

    /*Here the program will ascending order all the transactions by time.
    The last executed transition will appear in first place inside the list
    and the first executed transition will appear in last inside the list  */
    transactionsList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return Padding(
      padding: EdgeInsets.only(right: 15, left: 15, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText(
            AppLocalizations.of(context).translate('transactions'),
            style: TextStyle(
              color: Theme.of(context).textSelectionHandleColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(50),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactionsList.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Here the application will decide when to print the transaction 
            date. If more than one transaction were executed in the same day the date 
            will just appear one time  */
                    index != 0
                        ? transactionsList[index - 1].dateTime.day !=
                                transactionsList[index].dateTime.day
                            ? Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 25),
                                child: Text(
                                  DateFormat.yMMMd()
                                      .format(transactionsList[index].dateTime)
                                      .toString(),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionHandleColor,
                                    fontFamily: AppTheme.mediumFontFamily,
                                    fontSize: ScreenUtil().setSp(40),
                                  ),
                                ),
                              )
                            : Text("")
                        : Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 25),
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(transactionsList[index].dateTime)
                                  .toString(),
                              style: TextStyle(
                                color:
                                    Theme.of(context).textSelectionHandleColor,
                                fontFamily: AppTheme.mediumFontFamily,
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        //When user clicks on transaction box the full transaction page will appear
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: TransactionView(
                              transactionId: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppTheme.iconContainerColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.blueTheme
                                              .withOpacity(0.5),
                                          blurRadius: 6,
                                          offset: Offset(0, 1),
                                        ),
                                      ]),
                                  /* Here the program will compare wich type of transition
                        was done and show the correct icon */
                                  child: transactionsList[index].type ==
                                          "Received"
                                      ? Image.asset(
                                          'assets/icons/arrow_down.png',
                                          color: Colors.white,
                                          height: 40.h,
                                        )
                                      : transactionsList[index].type == "Sent"
                                          ? Image.asset(
                                              'assets/icons/arrow_up.png',
                                              color: Colors.white,
                                              height: 40.h,
                                            )
                                          : SvgPicture.asset(
                                              'assets/icons/arrows_hori.svg',
                                              color: Colors.white,
                                              height: 40.h,
                                            ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transactionsList[index].type +
                                            ' ' +
                                            transactionsList[index].code,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionHandleColor,
                                          fontFamily: AppTheme.mediumFontFamily,
                                          fontSize: ScreenUtil().setSp(40),
                                        ),
                                      ),
                                      Text(
                                        'to ' +
                                            transactionsList[index].destination,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionHandleColor,
                                          fontFamily: AppTheme.lightFontFamily,
                                          fontSize: ScreenUtil().setSp(35),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  transactions[index].amount.toString() +
                                      ' ' +
                                      transactions[index].code,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionHandleColor,
                                    fontFamily: AppTheme.mediumFontFamily,
                                    fontSize: ScreenUtil().setSp(40),
                                  ),
                                ),
                                Text(
                                  '€ ' +
                                      (transactions[index].amount *
                                              transactions[index].price)
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionHandleColor,
                                    fontFamily: AppTheme.lightFontFamily,
                                    fontSize: ScreenUtil().setSp(35),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
