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
  //جزء التحكم في شريك الحاله وشريك التنقل

  // جعل شريط التنقل وشريط الحالة يختفيان
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // جعل شريط الحالة شفافاً
    statusBarIconBrightness:
        Brightness.light, // تغيير لون النص في شريط الحالة إلى اللون الداكن
    systemNavigationBarColor: Colors.transparent, // جعل شريط التنقل شفافاً
    systemNavigationBarIconBrightness:
        Brightness.light, // تغيير لون الأيقونات في شريط التنقل إلى اللون الداكن
  ));

  // تعيين الألوان والتنسيقات المطلوبة لشريط التنقل
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // جعل شريط التنقل شفافاً
    systemNavigationBarIconBrightness:
        Brightness.light, // تغيير لون الأيقونات في شريط التنقل إلى اللون الداكن
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
