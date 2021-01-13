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
    return child;
  }

  static error() {
    return Scaffold(
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}
