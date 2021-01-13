import 'package:flare_flutter/flare_controls.dart';
import 'package:flutterCrypto/import/imports.dart';
import 'package:flutterCrypto/import/Imports.dart';

DayNightAnimationController animationController = DayNightAnimationController();
AnimationStates _currentAnimationState = AnimationStates.night_idle;
AnimationStates get currentAnimationState => _currentAnimationState;
bool isDark = true;
set currentAnimationState(AnimationStates value) {
  _currentAnimationState = value;
  animationController.changeAnimationState(value);
}

Function(bool) onSelectionChange;

enum AnimationStates { day_idle, switch_day, night_idle, switch_night }

extension on AnimationStates {
  String getName() {
    return this.toString().split('.').last;
  }
}

/*This function will 
  */
checkAnimationState(BuildContext context) {
  bool isDark = Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn;
  if (isDark) {
    currentAnimationState = AnimationStates.switch_day;
  } else {
    currentAnimationState = AnimationStates.switch_night;
  }
  Provider.of<ThemeNotifier>(context, listen: false).updateTheme(!isDark);
}

checkSystemAnimation(BuildContext context) {
  bool systemTheme =
      Provider.of<ThemeNotifier>(context, listen: false).systemTheme;

  if (systemTheme &&
      MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
    currentAnimationState = AnimationStates.night_idle;
  } else if (systemTheme &&
      MediaQuery.platformBrightnessOf(context) == Brightness.light) {
    currentAnimationState = AnimationStates.day_idle;
  }
}

class DayNightAnimationController extends FlareControls {
  @override
  void onCompleted(String name) {
    if (name == AnimationStates.switch_night.getName()) {
      play(AnimationStates.night_idle.getName());
      currentAnimationState = AnimationStates.night_idle;
      onSelectionChange(false);
    }
    if (name == AnimationStates.switch_day.getName()) {
      play(AnimationStates.day_idle.getName());
      currentAnimationState = AnimationStates.day_idle;
      onSelectionChange(true);
    }
    super.onCompleted(name);
  }

  void changeAnimationState(AnimationStates states) {
    play(states.getName());
  }
}
