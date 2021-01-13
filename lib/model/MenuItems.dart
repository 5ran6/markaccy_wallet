import 'package:flutterCrypto/import/Imports.dart';

class MenuItems {
  String title;
  IconData icon;
  String view;

  MenuItems({this.title, this.icon, this.view});
}

List<BottomNavigationBarItem> menuitems = [
  BottomNavigationBarItem(
    label: "/",
    icon: ImageIcon(
      AssetImage('assets/icons/home.png'),
    ),
  ),
  BottomNavigationBarItem(
    label: "/portfolio",
    icon: Padding(
      padding: const EdgeInsets.only(right: 40),
      child: ImageIcon(
        AssetImage('assets/icons/list.png'),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "/market",
    icon: Padding(
      padding: const EdgeInsets.only(left: 40),
      child: ImageIcon(
        AssetImage('assets/icons/bar_chart.png'),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "/settings",
    icon: ImageIcon(
      AssetImage('assets/icons/cogs.png'),
    ),
  )
];
