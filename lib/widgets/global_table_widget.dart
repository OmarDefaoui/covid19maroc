import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalTableWidget extends StatelessWidget {
  final List<ModelRegion> regions;
  final double width;

  const GlobalTableWidget({
    Key key,
    @required this.regions,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text('Tableau de répartition des cas par Région'),
        ),
        Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Consumer<ProviderSelectedRegion>(
              builder: (context, selectedRegion, widget) => DataTable(
                sortColumnIndex: 1,
                columnSpacing: _getColumnSpacing(width),
                sortAscending: true,
                columns: [
                  DataColumn(label: Text('Region')),
                  DataColumn(label: Text('Total'), numeric: true),
                  DataColumn(label: Text('En 24h'), numeric: true),
                  DataColumn(label: Text('Details'), numeric: true),
                ],
                rows: regions
                    .asMap()
                    .map(
                      (index, region) => MapEntry(
                        index,
                        DataRow(
                          cells: [
                            DataCell(Text('${region.name}')),
                            DataCell(Text('${region.totalCases}')),
                            DataCell(Text('${region.newCases}')),
                            DataCell(Icon(Icons.navigate_next),
                                onTap: () => _showRegionCities(
                                    index, region, selectedRegion)),
                          ],
                          selected: index == selectedRegion.selectedIndex,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showRegionCities(
      int index, ModelRegion region, ProviderSelectedRegion selectedRegion) {
    selectedRegion.selectRegion(index, '${region.name}', region.cities);
  }

  double _getColumnSpacing(double width) {
    if (width >= 875)
      return 56;
    else if (width >= 450 && width < 875)
      return 29;
    else if (width < 450 && width > 363)
      return 0; //TODO: find operation
    else
      return 0;
  }
}
