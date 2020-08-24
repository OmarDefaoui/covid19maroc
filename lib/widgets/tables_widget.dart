import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:covid19morocco/widgets/city_table_widget.dart';
import 'package:covid19morocco/widgets/global_table_widget.dart';
import 'package:flutter/material.dart';

class TablesWidget extends StatelessWidget {
  final double horizontalMargin, width;
  final AppLocalizations lang;
  final List<ModelRegion> regions;

  const TablesWidget({
    Key key,
    @required this.horizontalMargin,
    @required this.width,
    @required this.lang,
    @required this.regions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
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
    );
  }
}
