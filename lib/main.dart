import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/app.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(AppStart());
  });

}
class AppStart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  MyApp();
  }
}