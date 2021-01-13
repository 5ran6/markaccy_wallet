import 'package:flutterCrypto/import/Imports.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  String _animation = 'Flow';
  PageController _pageController;
  double _loginButtonWidth = 138;
  double _registerButtonWidth = 50;
  bool _loginPageSelected = true;

  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    bool loading = Provider.of<ThemeNotifier>(context).loading;

    //Variables to check if the dark Theme is active

    /*Main widget for all the auth pages, its where the login 
    and register pages are called separately*/

    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  /*Here the App will decide what color it will use 
                        corresponding to the seleted theme option in the
                        App settings page*/

                  height: 1.hp,
                  width: 1.wp,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Stack(
                    children: [
                      _background(context),
                      PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          /*With this logic the App changes the width of the 
                              selective navigator*/

                          if (i == 0) {
                            setState(() {
                              _loginButtonWidth = 138;
                              _registerButtonWidth = 50;
                              _loginPageSelected = !_loginPageSelected;
                            });
                          } else if (i == 1) {
                            setState(() {
                              _loginButtonWidth = 50;
                              _registerButtonWidth = 138;
                              _loginPageSelected = !_loginPageSelected;
                            });
                          }
                        },
                        children: <Widget>[
                          LoginView(
                            loginFormKey: loginFormKey,
                            auth: this.auth,
                          ),
                          RegisterView(
                            registerFormKey: registerFormKey,
                            auth: this.auth,
                          ),
                        ],
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 290),
                        child: _buildMenuBar(context),
                      )),
                      _socialLogin(context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  //Where all the background animations are
  Widget _background(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 0.8.hp,
          child: FlareActor(
            'assets/animations/login/flow_background.flr',
            fit: BoxFit.fill,
            animation: _animation,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            height: 1.hp,
            child: FlareActor(
              'assets/animations/login/crypto.flr',
              animation: 'normal',
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  //Where the login and register button widget are
  Widget _buildMenuBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
            gradient: AppTheme.loginBackPainter,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ]),
        child: CustomPaint(
          painter: TabIndicationPainter(pageController: _pageController),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                curve: Curves.easeOutBack,
                width: _loginButtonWidth,
                duration: Duration(milliseconds: 100),
                child: _loginPageSelected
                    ? FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          /*If all the validation parameters in the Login 
                             Form are correct the app will procced and do whats 
                             inside this if */
                          if (loginFormKey.currentState.validate()) {
                            loginFormKey.currentState.save();
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .isLoading(false);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('login'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _loginPageSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: ScreenUtil().setSp(40),
                              fontFamily: AppTheme.mediumFontFamily),
                        ),
                      )
                    : FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _onLoginIconPress,
                        child: ImageIcon(
                          AssetImage('assets/icons/user_check.png'),
                          color: Colors.grey[700],
                        ),
                      ),
              ),
              Expanded(child: SizedBox()),
              AnimatedContainer(
                curve: Curves.easeOutBack,
                width: _registerButtonWidth,
                duration: Duration(milliseconds: 100),
                child: _loginPageSelected
                    ? FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _onRegisterIconPress,
                        child: ImageIcon(
                          AssetImage('assets/icons/user_add.png'),
                          color: Colors.grey[700],
                        ),
                      )
                    : FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          /*If all the validation parameters in the Register 
                             Form are correct the app will procced and do whats 
                             inside this if */
                          if (registerFormKey.currentState.validate()) {
                            registerFormKey.currentState.save();
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .isLoading(false);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('register'),
                          style: TextStyle(
                              color: _loginPageSelected
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: ScreenUtil().setSp(40),
                              fontFamily: AppTheme.mediumFontFamily),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Google, Facebook and Twitter Auth buttons
  Widget _socialLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: SvgPicture.asset(
                      'assets/icons/link.svg',
                      height: 25,
                      color: Colors.grey,
                    )),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  await auth.facebookSignIn(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/facebook.svg',
                  height: 70.h,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await auth.googleSignIn(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/google.svg',
                  height: 70.h,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await auth.twitterSignIn(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/twitter.svg',
                  height: 70.h,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: InkWell(
              onTap: () async {
                auth.anonLogin(context);
              },
              child: Text(
                AppLocalizations.of(context).translate('anon_login'),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40),
                  color: Colors.grey,
                  fontFamily: AppTheme.mediumFontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //When the login icon is pressed this executes changing the page
  void _onLoginIconPress() {
    _pageController.animateToPage(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
    );
    setState(() {
      _loginButtonWidth = 138;
      _registerButtonWidth = 50;
    });
  }

  //When the register icon is pressed this executes changing the page
  void _onRegisterIconPress() {
    _pageController?.animateToPage(
      1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
    );
    setState(() {
      _loginButtonWidth = 50;
      _registerButtonWidth = 138;
    });
  }
}
