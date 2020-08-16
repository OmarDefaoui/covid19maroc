import 'package:covid19morocco/services/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double horizontalMargin, width;
  final String date;
  final AppLocalizations lang;

  const CustomAppBar({
    Key key,
    @required this.horizontalMargin,
    @required this.width,
    @required this.date,
    @required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNewData = isUpToDate(date);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin + 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/covid19.png'),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isNewData ? Colors.green : Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Visibility(
              // visible: width > 307,
              visible: true,
              child: Text(
                isNewData
                    ? "${lang.translate('today')}"
                    : "${lang.translate('notToday')}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isUpToDate(String date) {
    return date.split(' ')[0] == DateTime.now().toString().split(' ')[0];
  }
}
