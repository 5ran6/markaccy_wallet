import 'package:flutterCrypto/import/Imports.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatelessWidget {
  final int transactionId;
  const TransactionView({Key key, this.transactionId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*When the user press this icon the last page will appear */
                  IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/close.svg',
                      height: 50.h,
                      color: Theme.of(context).textSelectionHandleColor,
                    ),
                  ),
                  _title(context),
                  _from(context),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: Image(
                      image: AssetImage('assets/icons/long_arrow_down.png'),
                      color: Theme.of(context).textSelectionHandleColor,
                      width: 100.w,
                    ),
                  ),
                  _to(context),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 20),
                    child: Divider(
                      color: Colors.grey[500],
                    ),
                  ),
                  _details(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*The title its in this Widget  */
  Widget _title(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 5),
      child: AutoSizeText(
        AppLocalizations.of(context).translate('transaction_details'),
        style: TextStyle(
          color: Theme.of(context).textSelectionColor,
          fontFamily: AppTheme.mediumFontFamily,
          fontSize: ScreenUtil().setSp(70),
        ),
      ),
    );
  }

/*Here its where the "From" row is */
  Widget _from(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
              width: 60.w,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  AppLocalizations.of(context).translate('from') + ' Wallet',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontFamily: AppTheme.lightFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
                AutoSizeText(
                  (transactions[transactionId].amount *
                              transactions[transactionId].price)
                          .toString() +
                      ' ' +
                      transactions[transactionId].code,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
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
/*Here its where the "To" row is */

  Widget _to(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          /*To get the transaction coin image this query will search for the 
                first element in CryptoCoins List with the same Coin code present
                in the Transaction List*/
          cryptoCoins
              .firstWhere((coin) =>
                  coin.code.contains(transactions[transactionId].code))
              .image,
          fit: BoxFit.contain,
          width: 115.w,
        ),
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                AppLocalizations.of(context).translate('to') +
                    ' ' +
                    transactions[transactionId].destination,
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: AppTheme.lightFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
              AutoSizeText(
                (transactions[transactionId].amount *
                            transactions[transactionId].price)
                        .toString() +
                    ' ' +
                    transactions[transactionId].code,
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: AppTheme.mediumFontFamily,
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
/*Here its where all the transaction details will be */

  Widget _details(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          AppLocalizations.of(context).translate(
            'date',
          ),
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontFamily: AppTheme.lightFontFamily,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 15),
          child: AutoSizeText(
            DateFormat.yMMMd()
                .format(transactions[transactionId].dateTime)
                .toString(),
            style: TextStyle(
              color: Theme.of(context).textSelectionHandleColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
        ),
        AutoSizeText(
          AppLocalizations.of(context).translate('transaction_chain'),
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontFamily: AppTheme.lightFontFamily,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 15),
          child: AutoSizeText(
            '0x1dcc4de8dec75d7aab85b567b6cc7',
            style: TextStyle(
              color: Colors.greenAccent,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
        ),
        AutoSizeText(
          AppLocalizations.of(context).translate('status'),
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontFamily: AppTheme.lightFontFamily,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 15),
          child: Row(
            children: [
              Icon(
                Icons.brightness_1,
                size: 9,
                color: Colors.greenAccent,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: AutoSizeText(
                  'Completed',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionHandleColor,
                    fontFamily: AppTheme.mediumFontFamily,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
            ],
          ),
        ),
        AutoSizeText(
          AppLocalizations.of(context).translate('message'),
          style: TextStyle(
            color: Theme.of(context).textSelectionHandleColor,
            fontFamily: AppTheme.lightFontFamily,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 15),
          child: AutoSizeText(
            'Transaction Message here',
            style: TextStyle(
              color: Theme.of(context).textSelectionHandleColor,
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
        ),
      ],
    );
  }
}
