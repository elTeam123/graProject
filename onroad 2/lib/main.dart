import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onroad/provider_InfoHnadler/providerapp_info.dart';
import 'package:onroad/splashScreen/splash_screen.dart';
import 'package:onroad/user_infoHnadler/app_info.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // جعل شريط الحالة شفاف
    systemNavigationBarColor: Colors.transparent, // جعل خلفية شريط التنقل شفافة
    systemNavigationBarIconBrightness:
        Brightness.light, // تعيين لون أيقونات التنقل إلى اللون الفاتح
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppInfo>(
          create: (context) => AppInfo(),
        ),
        ChangeNotifierProvider<ProviderAppInfo>(
          create: (context) => ProviderAppInfo(),
        ),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MySplasScreen(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;

  const MyApp({super.key, this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
