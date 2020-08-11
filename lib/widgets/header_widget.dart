import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String date;

  const HeaderWidget({Key key, @required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('images/covid19.png'),
        SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(6),
          child: Text(
            'Le bilan du $date',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8),
        Visibility(
          visible: true,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              'Aujourd\'hui',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
