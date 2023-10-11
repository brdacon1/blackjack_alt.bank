import 'package:blackjack/constants/colors.dart';
import 'package:blackjack/providers/deck.dart';
import 'package:blackjack/providers/game.dart';
import 'package:blackjack/routes.dart';
import 'package:blackjack/screens/initial_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final MaterialColor colorCustom = MaterialColor(0xFF8DC63F, color);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Game(),
        ),
        ChangeNotifierProvider(
          create: (_) => Deck(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: colorCustom,
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: colorCustom)),
        home: const InitialScreen(),
        routes: routes,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

