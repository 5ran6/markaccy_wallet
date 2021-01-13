import 'package:flutterCrypto/import/Imports.dart';

class RegisterView extends StatefulWidget {
  final GlobalKey<FormState> registerFormKey;
  final AuthService auth;

  RegisterView({Key key, this.registerFormKey, this.auth}) : super(key: key);
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _hidePass = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User _user = User();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeAnimation(
          0.6,
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
                          .translate('register_title_text'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(90),
                        fontFamily: AppTheme.lightFontFamily,
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('register_subtitle_text'),
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
        Positioned.fill(child: _registerCard(context)),
      ],
    );
  }

/*Widget with the register forms */
  Widget _registerCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeAnimation(
          0.8,
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
              key: widget.registerFormKey,
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
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        fontFamily: AppTheme.lightFontFamily,
                        color: Theme.of(context).textSelectionHandleColor,
                      ),
                      controller: _usernameController,
                      validator: (value) {
                        /*If the username field its empty this error message 
                        will show */
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('empty_username');
                        }
                        /*If the username field have less than 5 characters 
                        this error message will show */
                        else if (value.length <= 2) {
                          return AppLocalizations.of(context)
                              .translate('small_username');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .translate('register_name'),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: AppTheme.lightFontFamily),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        fontFamily: AppTheme.lightFontFamily,
                        color: Theme.of(context).textSelectionHandleColor,
                      ),
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
                      controller: _emailController,
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
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        fontFamily: AppTheme.lightFontFamily,
                        color: Theme.of(context).textSelectionHandleColor,
                      ),
                      validator: (value) {
                        /*If the password field its empty this error message 
                        will show */
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('empty_password');
                        }
                        /*If the password field have less than 5 characters 
                        this error message will show */
                        else if (value.length < 5) {
                          return AppLocalizations.of(context)
                              .translate('small_password');
                        } else {
                          _user.email = _emailController.text.trim();
                          _user.password = _passwordController.text;
                          _user.username = _usernameController.text;
                          _createUser();
                          return null;
                        }
                      },
                      controller: _passwordController,
                      obscureText: _hidePass,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            color: Colors.grey,
                            icon: ImageIcon(
                              AssetImage(_hidePass
                                  ? 'assets/icons/eye_slash.png'
                                  : 'assets/icons/eye.png'),
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
      ],
    );
  }

  void _createUser() async {
    dynamic result = (await widget.auth.createNewUser(_user, context));

    if (result == null) {
    } else {
      _usernameController.clear();
      _passwordController.clear();
      _emailController.clear();
    }
  }
}
