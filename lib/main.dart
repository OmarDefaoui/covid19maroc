import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderSelectedRegion>(
      create: (_) => ProviderSelectedRegion(),
      child: MaterialApp(
        title: 'Covid19 Maroc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
