import 'package:flutterCrypto/import/Imports.dart';

class AuthService {
  FirebaseAuth _authInstance = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookLogin _facebookLogin = FacebookLogin();
  TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: Keys().twitterPublic,
    consumerSecret: Keys().twitterSecret,
  );

  //Auth change user stream
  Stream<FirebaseUser> get user => _authInstance.onAuthStateChanged;

  //Anon Login
  Future anonLogin(BuildContext context) async {
    try {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(true);
      await _authInstance.signInAnonymously();
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);
    } catch (e) {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

      showSnackBar(
          AppLocalizations.of(context).translate('login_error'), context);
    }
  }

  //Register with Email and Password
  Future createNewUser(User userModel, BuildContext context) async {
    try {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(true);
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = userModel.username;

      AuthResult authResult =
          (await _authInstance.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password));
      await authResult.user.updateProfile(userUpdateInfo);
      await authResult.user.reload();
    } catch (e) {
      showSnackBar(
          AppLocalizations.of(context).translate('register_error'), context);
    }
  }

  //Login with Email and Password
  Future loginUserWithEmailAndPassword(
      User userModel, BuildContext context) async {
    try {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(true);
      AuthResult authResult = await _authInstance.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password);

      return authResult.user;
    } catch (e) {
      showSnackBar(
          AppLocalizations.of(context).translate('login_error'), context);
    }
  }

  //Logout
  Future signOut(BuildContext context) async {
    try {
      _facebookLogin.logOut();
      _authInstance.signOut();
      _googleSignIn.signOut();

      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);
    } catch (e) {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);
      showSnackBar(
          AppLocalizations.of(context).translate('logout_error'), context);
    }
  }

  //Reset Password
  resetPass(
      String email, FirebaseUser firebaseUser, BuildContext context) async {
    try {
      await _authInstance.sendPasswordResetEmail(email: email);
    } catch (e) {
      showSnackBar(
          AppLocalizations.of(context).translate('register_error'), context);
    }
  }

  //Google SignIn
  Future googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(true);
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      AuthResult authResult =
          (await _authInstance.signInWithCredential(credential));
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

      return authResult.user;
    } catch (e) {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

      showSnackBar(
          AppLocalizations.of(context).translate('google_error'), context);
    }
  }

  //Facebook SignIn
  Future facebookSignIn(BuildContext context) async {
    try {
      final result = await _facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(true);

      switch (result.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken facebookAccessToken = result.accessToken;

          final AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: facebookAccessToken.token);

          await _authInstance.signInWithCredential(credential);
          Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

          break;
        case FacebookLoginStatus.cancel:
          showSnackBar(
              AppLocalizations.of(context).translate('facebook_cancel'),
              context);
          break;
        case FacebookLoginStatus.error:
          showSnackBar(AppLocalizations.of(context).translate('facebook_error'),
              context);
          break;
      }

      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);
    } catch (e) {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

      showSnackBar(
          AppLocalizations.of(context).translate('facebook_error'), context);
    }
  }

  //Twitter SignIn
  Future twitterSignIn(BuildContext context) async {
    try {
      final TwitterLoginResult result = await twitterLogin.authorize();
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(true);
      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          final twitterAccessToken = result.session;
          final AuthCredential credential = TwitterAuthProvider.getCredential(
              authToken: twitterAccessToken.token,
              authTokenSecret: twitterAccessToken.secret);

          await _authInstance.signInWithCredential(credential);
          Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

          break;
        case TwitterLoginStatus.cancelledByUser:
          Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);
          showSnackBar(AppLocalizations.of(context).translate('twitter_cancel'),
              context);
          break;
        case TwitterLoginStatus.error:
          Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

          showSnackBar(
              AppLocalizations.of(context).translate('twitter_error'), context);
          break;
      }
    } catch (e) {
      Provider.of<ThemeNotifier>(context, listen: false).isLoading(false);

      showSnackBar(
          AppLocalizations.of(context).translate('twitter_error'), context);
    }
  }
}
