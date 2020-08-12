import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityTableWidget extends StatelessWidget {
  const CityTableWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Consumer<ProviderSelectedRegion>(
        builder: (context, selectedRegion, widget) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text('${selectedRegion.getRegion}'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortColumnIndex: 1,
                sortAscending: true,
                columns: [
                  DataColumn(label: Text('Villes')),
                  DataColumn(label: Text('En 24h'), numeric: true),
                ],
                rows: selectedRegion.getCityCases
                    .map(
                      (city) => DataRow(
                        cells: [
                          DataCell(Text('${city.name}')),
                          DataCell(Text('${city.cases}')),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
