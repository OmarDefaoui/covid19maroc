import 'package:covid19morocco/providers/provider_language.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/screens/home_screen.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderSelectedRegion>(
          create: (_) => ProviderSelectedRegion(),
        ),
        ChangeNotifierProvider<ProviderLanguage>(
          create: (_) => ProviderLanguage(),
        ),
      ],
      child: Consumer<ProviderLanguage>(
        builder: (context, providerLanguage, _) => FutureBuilder<bool>(
            future: _getLocale(providerLanguage),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();

              return MaterialApp(
                title: 'Covid19 Maroc',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: HomeScreen(isArabic: snapshot.data),
                // List all of the app's supported locales here
                supportedLocales: [
                  Locale('ar', ''),
                  Locale('fr', ''),
                ],
                // These delegates make sure that the localization data for the proper language is loaded
                localizationsDelegates: [
                  // A class which loads the translations from JSON files
                  AppLocalizations.delegate,
                  // Built-in localization of basic text for Material widgets
                  GlobalMaterialLocalizations.delegate,
                  // Built-in localization for text direction LTR/RTL
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: Locale(providerLanguage.getLocal, ''),
              );
            }),
      ),
    );
  }

  Future<bool> _getLocale(ProviderLanguage providerLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isArabic = prefs.getBool('local') ?? true;
    providerLanguage.isArabic = isArabic;
    providerLanguage.local = isArabic ? 'ar' : 'fr';
    return isArabic;
  }
}
