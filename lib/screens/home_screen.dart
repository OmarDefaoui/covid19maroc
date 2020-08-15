import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/services/service_data.dart';
import 'package:covid19morocco/widgets/city_table_widget.dart';
import 'package:covid19morocco/widgets/data_box_widget.dart';
import 'package:covid19morocco/widgets/global_table_widget.dart';
import 'package:covid19morocco/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr');

    return FutureBuilder<ModelData>(
        future: ServiceData.getData(),
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
              title: HeaderWidget(
                horizontalMargin: horizontaleMargin,
                date: data.date,
              ),
            ),
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: horizontaleMargin,
                          bottom: 25,
                        ),
                        child: Text(
                          "Le bilan du ${DateFormat('dd/MM/yyyy').format(DateTime.parse(data.date))}",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        children: [
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Active",
                            cases: data.totalActive,
                            newCases: data.newActive,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Cases",
                            cases: data.totalCases,
                            newCases: data.newCases,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Deaths",
                            cases: data.totalDeaths,
                            newCases: data.newDeaths,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Recovred",
                            cases: data.totalRecovred,
                            newCases: data.newRecovred,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Tests",
                            cases: data.totalTests,
                            newCases: data.newTests,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Critical",
                            cases: data.totalCritical,
                            newCases: data.newCritical,
                            isPhone: isPhone,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "ArtificialRespiration",
                            cases: data.totalArtificialRespiration,
                            newCases: data.newArtificialRespiration,
                            isPhone: isPhone,
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          horizontal: horizontaleMargin,
                          vertical: 25,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            GlobalTableWidget(
                              regions: regions,
                              width: width,
                            ),
                            CityTableWidget(),
                          ],
                        ),
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
