import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode =
        (themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  static String defaultFontFamily = 'Avenir';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // دسترسی مستقیم به ThemeProvider

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        colorScheme: themeProvider.themeMode == ThemeMode.light
            ? const ColorScheme.light(background: Color(0xffFBFCFF))
            : const ColorScheme.dark(background: Color(0xfff3e3e3e)),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: defaultFontFamily,
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 138),
                  child: Text(
                    'Calculator',
                    style: themeProvider.themeMode == ThemeMode.light
                        ? Theme.of(context).textTheme.headline1
                        : Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 39),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: IconButton(
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.light
                          ? Icons.wb_sunny
                          : Icons.brightness_3,
                      size: 27,
                    ),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
