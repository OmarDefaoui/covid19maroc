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
    TextStyle headerStyle = TextStyle(
      color: Colors.blue,
      fontSize: 15,
    );

    return Consumer<ProviderSelectedRegion>(
      builder: (context, selectedRegion, widget) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '${selectedRegion.getRegion}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: 1,
              sortAscending: true,
              columns: [
                DataColumn(
                    label: Text(
                  "${lang.translate('cities')}",
                  style: headerStyle,
                )),
                DataColumn(
                    label: Text(
                      "${lang.translate('h24')}",
                      style: headerStyle,
                    ),
                    numeric: true),
              ],
              rows: selectedRegion.getCityCases
                  .map(
                    (city) => DataRow(
                      cells: [
                        DataCell(Text(
                          '${city.name}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Text(
                          '+${city.newCases}',
                          style: TextStyle(color: Colors.orange),
                        )),
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
