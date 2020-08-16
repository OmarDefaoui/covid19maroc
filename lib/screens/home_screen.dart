import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:covid19morocco/services/service_data.dart';
import 'package:covid19morocco/widgets/bottom_widget.dart';
import 'package:covid19morocco/widgets/city_table_widget.dart';
import 'package:covid19morocco/widgets/custom_appbar.dart';
import 'package:covid19morocco/widgets/data_box_widget.dart';
import 'package:covid19morocco/widgets/global_table_widget.dart';
import 'package:covid19morocco/widgets/header_widget.dart';
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
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      HeaderWidget(
                        date: data.date,
                        horizontalMargin: horizontaleMargin,
                        lang: lang,
                      ),
                      Wrap(
                        spacing: 25,
                        runSpacing: 20,
                        children: [
                          DataBoxWidget(
                            color: Colors.green,
                            icon: Icons.tag_faces_outlined,
                            title: "${lang.translate('recovred')}",
                            cases: data.totalRecovred,
                            newCases: data.newRecovred,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orangeAccent,
                            icon: Icons.coronavirus_outlined,
                            title: "${lang.translate('cases')}",
                            cases: data.totalCases,
                            newCases: data.newCases,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.red,
                            icon: Icons.person_outline,
                            title: "${lang.translate('deaths')}",
                            cases: data.totalDeaths,
                            newCases: data.newDeaths,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.blueAccent,
                            icon: Icons.check_circle_outline,
                            title: "${lang.translate('negatifTests')}",
                            cases: data.totalTests,
                            newCases: data.newTests,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.yellow[600],
                            icon: Icons.local_hotel_outlined,
                            title: "${lang.translate('active')}",
                            cases: data.totalActive,
                            newCases: data.newActive,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.pinkAccent,
                            icon: Icons.local_hospital_outlined,
                            title: "${lang.translate('critical')}",
                            cases: data.totalCritical,
                            newCases: data.newCritical,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.purpleAccent,
                            icon: Icons.view_carousel_outlined,
                            title: "${lang.translate('artificialRespiration')}",
                            cases: data.totalArtificialRespiration,
                            newCases: data.newArtificialRespiration,
                            isPhone: isPhone,
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: horizontaleMargin,
                          vertical: 25,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.1,
                              spreadRadius: 0.0,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            GlobalTableWidget(
                              regions: regions,
                              width: width,
                              lang: lang,
                            ),
                            CityTableWidget(
                              lang: lang,
                            ),
                          ],
                        ),
                      ),
                      BottomWidget(
                        horizontaleMargin: horizontaleMargin,
                        lang: lang,
                      ),
                    ],
                  ),
                ),
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
