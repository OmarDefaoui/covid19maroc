import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalTableWidget extends StatelessWidget {
  final List<ModelRegion> regions;

  const GlobalTableWidget({
    Key key,
    @required this.regions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderSelectedRegion _selectedRegion =
        Provider.of<ProviderSelectedRegion>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tableau de répartition des cas par Région'),
                  Text('Mise à jour : (09-08-2020 à 18h06)'),
                ],
              ),
              SizedBox(width: 4),
              Text('site link'),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: 1,
              sortAscending: true,
              columns: [
                DataColumn(label: Text('Region')),
                DataColumn(label: Text('Total'), numeric: true),
                DataColumn(label: Text('En 24h'), numeric: true),
                DataColumn(label: Text('Details'), numeric: true),
              ],
              rows: regions
                  .map(
                    (region) => DataRow(
                      cells: [
                        DataCell(Text('${region.name}')),
                        DataCell(Text('${region.totalCases}')),
                        DataCell(Text('${region.newCases}')),
                        DataCell(Icon(Icons.navigate_next),
                            onTap: () =>
                                _showRegionCities(region, _selectedRegion)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegionCities(
      ModelRegion region, ProviderSelectedRegion selectedRegion) {
    selectedRegion.selectRegion('${region.name}', region.cities);
  }
}
