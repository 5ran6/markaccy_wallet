import 'package:flutterCrypto/import/Imports.dart';

class ForgetPassView extends StatelessWidget {
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 1.hp,
          width: 1.wp,
          child: Stack(
            children: [
              SizedBox(height: 1.hp),
              _background(context),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: FadeAnimation(
                  1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/double_arrows_left.svg',
                            height: 50.h,
                            color: Theme.of(context).textSelectionHandleColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('forgot_password'),
                          style: TextStyle(
                            color: Theme.of(context).textSelectionHandleColor,
                            fontSize: ScreenUtil().setSp(80),
                            fontFamily: AppTheme.lightFontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _forgotForm(context),
            ],
          ),
        ),
      ),
    );
  }

  //Where the background animations are
  Widget _background(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 80),
          height: 0.45.hp,
          child: FlareActor(
            "assets/animations/login/question_mark.flr",
            animation: "default",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            height: 1.hp,
            child: FlareActor(
              "assets/animations/login/flow_bottom.flr",
              animation: "Flow",
              fit: BoxFit.fill,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  //Form where the user input the email to reset password
  Widget _forgotForm(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 90),
              child: Column(
                children: [
                  FadeAnimation(
                    1.2,
                    Container(
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
                        key: forgotFormKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  /*If the email field have less than 5 characters 
                                  this error message will show */
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .translate('empty_email');
                                  } else {
                                    _sendPassReset(context);
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionHandleColor,
                                  fontFamily: AppTheme.lightFontFamily,
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .translate('email'),
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
              ),
            ),
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context).translate('forgot_password_text'),
                style: TextStyle(
                  fontFamily: AppTheme.lightFontFamily,
                  color: Theme.of(context).textSelectionHandleColor,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 5),
                child: FadeAnimation(
                  1.2,
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Color(0xFF434952),
                    onPressed: () {
                      /*If all the validation parameters in the Login 
                                 Form are correct the app will procced and do whats 
                                 inside this if */
                      if (forgotFormKey.currentState.validate()) {
                        forgotFormKey.currentState.save();
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('send_email'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(40),
                          fontFamily: AppTheme.mediumFontFamily),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _sendPassReset(BuildContext context) async {
    FirebaseUser firebaseUser =
        Provider.of<FirebaseUser>(context, listen: false);
    dynamic result =
        await auth.resetPass(_emailController.text, firebaseUser, context);

    if (result == null) {
    } else {
      _emailController.clear();
      Navigator.of(context).pushNamed('/auth');
    }
  }
}
