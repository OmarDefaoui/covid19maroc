import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/models/model_statistics.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/services/service_data.dart';
import 'package:covid19morocco/widgets/city_table_widget.dart';
import 'package:covid19morocco/widgets/data_box_widget.dart';
import 'package:covid19morocco/widgets/global_table_widget.dart';
import 'package:covid19morocco/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: HeaderWidget(date: 'dimanche 9 août 2020'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                FutureBuilder<ModelStatistics>(
                    future: ServiceData.getStatistics(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();

                      ModelStatistics statistics = snapshot.data;

                      return Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        children: [
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Active",
                            cases: statistics.totalActive,
                            newCases: statistics.newActive,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Cases",
                            cases: statistics.totalCases,
                            newCases: statistics.newCases,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Deaths",
                            cases: statistics.totalDeaths,
                            newCases: statistics.newDeaths,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Recovred",
                            cases: statistics.totalRecovred,
                            newCases: statistics.newRecovred,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Tests",
                            cases: statistics.totalTests,
                            newCases: statistics.newTests,
                          ),
                          DataBoxWidget(
                            color: Colors.orange,
                            icon: Icons.ac_unit,
                            title: "Critical",
                            cases: statistics.totalCritical,
                            newCases: statistics.newCritical,
                          ),
                        ],
                      );
                    }),
                FutureBuilder<List<ModelRegion>>(
                    future: ServiceData.getRegionsData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();

                      List<ModelRegion> regions = snapshot.data;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Provider.of<ProviderSelectedRegion>(context,
                                listen: false)
                            .selectRegion(regions[0].name, regions[0].cities);
                      });

                      return Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          horizontal: _getHorizontalMargin(context),
                          vertical: 25,
                        ),
                        child: Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            GlobalTableWidget(regions: regions),
                            CityTableWidget(),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getHorizontalMargin(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    int boxCount;
    if (width - 1200 - 100 > 0)
      boxCount = 3;
    else if (width - 800 - 75 > 0)
      boxCount = 2;
    else
      boxCount = 1;
    print(boxCount);

    return (width - 400 * boxCount - 25 * (boxCount - 1) - 50) / 2;
  }
}
