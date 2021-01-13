import 'package:flutterCrypto/import/Imports.dart';
import 'package:intl/intl.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({Key key}) : super(key: key);

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
              expandedHeight: 0.18.hp,
              pinned: true,
              floating: false,
              elevation: 15,
              forceElevated: true,
              shadowColor: AppTheme.blueTheme.withOpacity(0.5),
              backgroundColor: AppTheme.blueTheme,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              leading: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/double_arrows_left.svg',
                    height: 50.h,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 70, bottom: 17),
                stretchModes: [StretchMode.zoomBackground],
                title: _flexibleBar(context),
                background: _background(context),
              ),
              centerTitle: false,
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  width: 0.8.wp,
                  child: Text(
                    AppLocalizations.of(context).translate('transactions'),
                    style: TextStyle(
                      color: Theme.of(context).textSelectionHandleColor,
                      fontFamily: AppTheme.mediumFontFamily,
                      fontSize: ScreenUtil().setSp(50),
                    ),
                  ),
                ),
                childCount: 1,
              ),
              itemExtent: 150.h,
            ),
            _activityList(context),
          ],
        ),
      ),
    );
  }

  /*The appBar title its in here */
  Widget _flexibleBar(BuildContext context) {
    return Hero(
      tag: 'activity_text',
      child: Material(
        child: Text(
          AppLocalizations.of(context).translate('activity'),
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppTheme.mediumFontFamily,
            fontSize: ScreenUtil().setSp(60),
          ),
        ),
      ),
    );
  }

  /*Here its where the appBar background is */
  Widget _background(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Hero(
          tag: 'activity_chart',
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Image(
              image: AssetImage('assets/ui/activity_chart.png'),
              width: 350.w,
            ),
          ),
        ),
      ],
    );
  }

  /*This widget its a list with all the activities generated one by one 
  automatically */
  Widget _activityList(BuildContext context) {
    /*Here the program will ascending order all the transactions by time.
    The last executed transition will appear in first place inside the list
    and the first executed transition will appear in last inside the list  */
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return SliverPadding(
      padding: EdgeInsets.only(bottom: 25),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            transactions.length,
            (index) {
              return FadeAnimation(
                0.5,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Here the application will decide when to print the transaction 
                date. If more than one transaction were executed in the same day the date 
                will just appear one time  */
                    index != 0
                        ? transactions[index - 1].dateTime.day !=
                                transactions[index].dateTime.day
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 15, top: 15, bottom: 25),
                                child: Text(
                                  DateFormat.yMMMd()
                                      .format(transactions[index].dateTime)
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
                            padding:
                                EdgeInsets.only(left: 15, top: 15, bottom: 25),
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(transactions[index].dateTime)
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
                        //When user clicks on activity box the full acitivty page will appear
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
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
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
                                  child: transactions[index].type == "Received"
                                      ? Image.asset(
                                          'assets/icons/arrow_down.png',
                                          color: Colors.white,
                                          height: 40.h,
                                        )
                                      : transactions[index].type == "Sent"
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
                                        transactions[index].type +
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
                                        'to ' + transactions[index].destination,
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
                ),
              );
            },
            growable: true,
          ),
        ),
      ),
    );
  }
}
