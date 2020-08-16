import 'package:covid19morocco/providers/provider_language.dart';
import 'package:covid19morocco/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  final double horizontalMargin;
  final String date;
  final AppLocalizations lang;

  const HeaderWidget({
    Key key,
    @required this.horizontalMargin,
    @required this.date,
    @required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        bottom: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: [
                Text(
                  "${lang.translate('bilan')} ${DateFormat(lang.translate('dateFormat').toString()).format(DateTime.parse(date))}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                Consumer<ProviderLanguage>(
                  builder: (context, providerLanguage, _) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Français'),
                      Switch(
                        value: providerLanguage.isFirstLanguage,
                        onChanged: (value) {
                          providerLanguage.setLocal(value);
                        },
                      ),
                      Text('العربية'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${lang.translate('source')}",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
