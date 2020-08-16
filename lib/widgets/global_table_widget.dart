import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/providers/provider_selected_region.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GlobalTableWidget extends StatelessWidget {
  final List<ModelRegion> regions;
  final double width;
  final AppLocalizations lang;

  const GlobalTableWidget({
    Key key,
    @required this.regions,
    @required this.width,
    @required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    TextStyle headerStyle = TextStyle(
      color: Colors.blue,
      fontSize: 15,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "${lang.translate('tableDesc')}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
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
                  DataColumn(
                      label: Text(
                    "${lang.translate('regions')}",
                    style: headerStyle,
                  )),
                  DataColumn(
                    label: Text(
                      "${lang.translate('total')}",
                      style: headerStyle,
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "${lang.translate('h24')}",
                      style: headerStyle,
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "${lang.translate('details')}",
                      style: headerStyle,
                    ),
                    numeric: true,
                  ),
                ],
                rows: regions
                    .asMap()
                    .map(
                      (index, region) => MapEntry(
                        index,
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                '${region.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () => _showRegionCities(
                                  index, region, selectedRegion),
                            ),
                            DataCell(
                              Text(
                                "${NumberFormat('###,###,###', 'fr').format(int.parse(region.totalCases))}",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () => _showRegionCities(
                                  index, region, selectedRegion),
                            ),
                            DataCell(
                              Text(
                                "+${NumberFormat('###,###,###', 'fr').format(int.parse(region.newCases))}",
                                style: TextStyle(color: Colors.orange),
                              ),
                              onTap: () => _showRegionCities(
                                  index, region, selectedRegion),
                            ),
                            DataCell(
                              Icon(Icons.navigate_next),
                              onTap: () => _showRegionCities(
                                  index, region, selectedRegion),
                            ),
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
