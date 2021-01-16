import 'package:flutterCrypto/import/Imports.dart';

bool isDarkModeOn = true;

class TabNavigator extends StatelessWidget {
  final String tabItem;

  TabNavigator({Key key, this.tabItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = HomeView();

    switch (tabItem) {
      case '/':
        child = HomeView();

        break;
      case '/portfolio':
        child = PortfolioView();

        break;
      case '/market':
        child = MarketView();

        break;

      case '/settings':
        child = SettingsView(
          onSelection: (isCheck) {
            isDarkModeOn = !isCheck;
          },
        );
        break;
      default:
        child = error();
        break;
    }
    return WillPopScope(
        onWillPop: () async {
          showAlertDialog(context);
        },
        child: child);
  }

  static error() {
    return Scaffold(
      body: Center(
        child: Text("Error"),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exiting?"),
      content: Text("Are you sure you want to exit?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
