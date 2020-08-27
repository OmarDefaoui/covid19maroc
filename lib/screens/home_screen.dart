import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:covid19morocco/services/service_data.dart';
import 'package:covid19morocco/widgets/bottom_widget.dart';
import 'package:covid19morocco/widgets/custom_appbar.dart';
import 'package:covid19morocco/widgets/header_widget.dart';
import 'package:covid19morocco/widgets/overview_widget.dart';
import 'package:covid19morocco/widgets/tables_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final bool isArabic;

  const HomeScreen({
    Key key,
    @required this.isArabic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr');
    AppLocalizations lang = AppLocalizations.of(context);

    return FutureBuilder<ModelData>(
        future: ServiceData.getData(isArabic),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error.toString()),
            );

          ModelData data = snapshot.data;
          List<ModelRegion> regions = data.regions;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<ProviderSelectedRegion>(context, listen: false)
                .selectRegion(0, regions[0].name, regions[0].cities);
          });

          double width = MediaQuery.of(context).size.width;
          bool isPhone = width < 450;
          double horizontaleMargin =
              isPhone ? 0 : _getHorizontalMargin(context, width);

          print(
              '$width: $horizontaleMargin , ${_getHorizontalMargin(context, width)}');

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: CustomAppBar(
                horizontalMargin: horizontaleMargin,
                width: width,
                date: data.date,
                lang: lang,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  HeaderWidget(
                    date: data.date,
                    horizontalMargin: horizontaleMargin,
                    lang: lang,
                  ),
                  OverViewWidget(
                    horizontalMargin: horizontaleMargin,
                    lang: lang,
                    data: data,
                    isPhone: isPhone,
                  ),
                  TablesWidget(
                    horizontalMargin: horizontaleMargin,
                    width: width,
                    lang: lang,
                    regions: regions,
                  ),
                  BottomWidget(
                    horizontaleMargin: horizontaleMargin,
                    lang: lang,
                  ),
                ],
              ),
            ),
          );
        });
  }

  double _getHorizontalMargin(BuildContext context, double width) {
    int boxCount;
    if (width - 1200 - 100 > 0)
      boxCount = 3;
    else if (width - 800 - 75 > 0)
      boxCount = 2;
    else
      boxCount = 1;

    return (width - 400 * boxCount - 25 * (boxCount - 1) - 50) / 2;
  }
}
