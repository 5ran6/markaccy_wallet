import 'package:flutterCrypto/import/Imports.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext contex) {
    return Consumer<ThemeNotifier>(
      builder: (context, appState, child) {
        return Container(
          height: 0.24.hp,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: FlareActor(
                'assets/animations/global/animated_circle.flr',
                animation: 'loading',
                alignment: Alignment.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
