import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityTableWidget extends StatelessWidget {
  final AppLocalizations lang;

  const CityTableWidget({
    Key key,
    @required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSelectedRegion>(
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
                DataColumn(label: Text("${lang.translate('cities')}")),
                DataColumn(
                    label: Text("${lang.translate('h24')}"), numeric: true),
              ],
              rows: selectedRegion.getCityCases
                  .map(
                    (city) => DataRow(
                      cells: [
                        DataCell(Text('${city.name}')),
                        DataCell(Text('${city.newCases}')),
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
}
