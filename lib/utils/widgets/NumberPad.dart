import 'package:flutterCrypto/import/Imports.dart';

class KeyboardNumber extends StatelessWidget {
  final int number;
  final BuildContext contextBack;
  final Function() onPressed;

  KeyboardNumber({Key key, this.number, this.onPressed, this.contextBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 40,
        child: Text(
          "$number",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.lightFontFamily,
            color: Theme.of(contextBack).textSelectionColor,
            fontSize: ScreenUtil().setSp(75),
          ),
        ),
      ),
    );
  }
}
