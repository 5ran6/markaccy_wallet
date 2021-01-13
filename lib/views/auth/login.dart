import 'package:flutterCrypto/import/Imports.dart';

class LoginView extends StatefulWidget {
  final GlobalKey<FormState> loginFormKey;
  final AuthService auth;
  LoginView({Key key, this.loginFormKey, this.auth}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _hidePass = true;
  User _user = User();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeAnimation(
          1,
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('login_title_text'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(90),
                        fontFamily: AppTheme.lightFontFamily,
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('login_subtitle_text'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(50),
                      fontFamily: AppTheme.lightFontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: _loginCard(context),
        ),
      ],
    );
  }

  //Where all the form inputs are
  Widget _loginCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeAnimation(
          1.2,
          Container(
            width: 0.85.wp,
            decoration: BoxDecoration(
              color: AppTheme.loginCard,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.shadowColor,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: widget.loginFormKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        /*If the email field its empty this error message 
                        will show */
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('empty_email');
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        fontFamily: AppTheme.lightFontFamily,
                        color: Theme.of(context).textSelectionHandleColor,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).translate('email'),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: AppTheme.lightFontFamily),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        /*If the password field have less than 5 characters 
                        this error message will show */
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('empty_password');
                        } else {
                          _user.email = _emailController.text.trim();
                          _user.password = _passwordController.text;
                          _loginUser();
                          return null;
                        }
                      },
                      obscureText: _hidePass,
                      style: TextStyle(
                        fontFamily: AppTheme.lightFontFamily,
                        fontSize: ScreenUtil().setSp(40),
                        color: Theme.of(context).textSelectionHandleColor,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            color: Colors.grey,
                            icon: ImageIcon(
                              AssetImage(
                                _hidePass
                                    ? 'assets/icons/eye_slash.png'
                                    : 'assets/icons/eye.png',
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePass = !_hidePass;
                              });
                            }),
                        hintText:
                            AppLocalizations.of(context).translate('password'),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: AppTheme.lightFontFamily),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FadeAnimation(
          1.4,
          Container(
            width: 0.8.wp,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.upToDown,
                          child: ForgetPassView(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('forgot_password'),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        color: Colors.grey,
                        fontFamily: AppTheme.lightFontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _loginUser() async {
    dynamic result =
        await widget.auth.loginUserWithEmailAndPassword(_user, context);

    if (result == null) {
    } else {
      _passwordController.clear();
      _emailController.clear();
    }
  }
}
