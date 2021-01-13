import 'package:flutterCrypto/import/Imports.dart';
import 'package:flutterCrypto/views/landingPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /*When the program initializaes the portraitonly mode its activated */
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen.navigate(
          loopAnimation: 'loading',
          height: 100,
          name: 'assets/animations/global/animated_circle.flr',
          next: (context) => MultiProvider(
            providers: [
              /*When The user changes the color theme this notifier will update 
              all variables related with the App Theme*/
              ChangeNotifierProvider<ThemeNotifier>(
                create: (context) => ThemeNotifier(),
              ),
            ],
            child: MyApp(),
          ),
          until: () => Future.delayed(Duration(seconds: 2)),
          startAnimation: 'loading',
          backgroundColor: Colors.white,
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    /*When the user logs in, the app will update all the variables related
    to the user info*/
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: LandingPage(),
    );
  }
}

//Show alert errors
void showSnackBar(
  String message,
  BuildContext context,
) {
  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Stack(
      children: [
        ImageIcon(
          AssetImage('assets/icons/alert.png'),
          color: Colors.red,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: AutoSizeText(
            message,
            maxLines: 4,
            style: TextStyle(
              fontFamily: AppTheme.mediumFontFamily,
              fontSize: ScreenUtil().setSp(20),
            ),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: 3),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}
