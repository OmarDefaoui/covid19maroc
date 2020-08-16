import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataBoxWidget extends StatelessWidget {
  final String title, cases, newCases;
  final IconData icon;
  final Color color;
  final bool isPhone;

  const DataBoxWidget({
    Key key,
    @required this.title,
    @required this.cases,
    @required this.newCases,
    @required this.icon,
    @required this.color,
    @required this.isPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isPhone ? double.infinity : 400,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.1,
            spreadRadius: 0.0,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text(
                    "${NumberFormat('###,###,###', 'fr').format(int.parse(cases))}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Icon(icon, color: color),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(color: Colors.grey, thickness: 0.5),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, color: Colors.white, size: 18),
                SizedBox(width: 4),
                Text(
                  "${NumberFormat('###,###,###', 'fr').format(int.parse(newCases))}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
