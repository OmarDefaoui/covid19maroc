import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:covid19morocco/widgets/data_box_widget.dart';
import 'package:flutter/material.dart';

class OverViewWidget extends StatelessWidget {
  final double horizontalMargin;
  final AppLocalizations lang;
  final ModelData data;
  final bool isPhone;

  const OverViewWidget({
    Key key,
    @required this.horizontalMargin,
    @required this.lang,
    @required this.data,
    @required this.isPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Wrap(
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
    );
  }
}
