import 'package:flutterCrypto/import/Imports.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDarkModeOn = true;
  bool systemTheme = false;
  SharedPreferences prefs;
  bool activeBottomNav = false;
  bool loading = false;

  ThemeNotifier() {
    _loadThemeFromPrefs();
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  /*This function will load the stored configurations about the 
  theme that was previous selected inside the app*/

  _loadThemeFromPrefs() async {
    await _initPrefs();
    systemTheme = prefs.getBool("systemTheme") ?? true;
    isDarkModeOn = prefs.getBool("theme") ?? true;
    notifyListeners();
  }

  /*This function will save the configuration variables so
  the next time the app will be started this values can be restored*/

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool("systemTheme", systemTheme);
    prefs.setBool("theme", isDarkModeOn);
  }

  /*This function will activate the update theme corresponding to 
  the selected mode in the device */
  void updatBySystem(bool systemThemeChange) {
    this.systemTheme = systemThemeChange;

    _saveToPrefs();
    notifyListeners();
  }

  void updateTheme(bool isDarkModeOnChange) {
    this.systemTheme = false;
    this.isDarkModeOn = isDarkModeOnChange;
    _saveToPrefs();
    notifyListeners();
  }

  Future isLoading(bool loading) async {
    this.loading = loading;
    notifyListeners();
  }
}
