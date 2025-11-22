import 'package:flutter/material.dart';
import 'package:solana_time/presentation/features/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'generated/l10n.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}