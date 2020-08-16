import 'package:covid19morocco/services/app_localizations.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class BottomWidget extends StatelessWidget {
  final double horizontaleMargin;
  final AppLocalizations lang;

  const BottomWidget({
    Key key,
    @required this.horizontaleMargin,
    @required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontaleMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    html.window.open(
                        'https://docs.google.com/document/d/1v2A_ABMgk5Qtbjf8BGNxIPs182wzc4NEPst1zOKkL4g/edit?usp=sharing',
                        'new tab');
                  },
                  child: Text(
                    "${lang.translate('privacyPolicy')}",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    html.window.open('mailto:omardev06@gmail.com', 'new tab');
                  },
                  child: Text(
                    "${lang.translate('reportError')}",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${lang.translate('disclaimer')}",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
