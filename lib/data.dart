import 'package:covid19morocco/models/model_city.dart';
import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/models/model_statistics.dart';

class Data {
  static ModelStatistics modelStatistics = ModelStatistics(
    date: '11/08/2020',
    totalCases: '35195',
    newCases: '1132',
    totalDeaths: '533',
    newDeaths: '17',
    totalRecovred: '25385',
    newRecovred: '861',
    totalTests: '1458901',
    newTests: '20869',
    totalActive: '9277',
    newActive: '254',
    totalCritical: '50',
    newCritical: '1',
  );

  static List<ModelRegion> listRegions = [
    ModelRegion(
      name: 'Casa Settat​',
      totalCases: '9436',
      newCases: '392',
      cities: [
        ModelCity(
          name: 'Casa',
          cases: '100',
        ),
        ModelCity(
          name: 'Settat',
          cases: '20',
        ),
      ],
    ),
    ModelRegion(
      name: 'Tanger Tetouan Al Hoceima',
      totalCases: '7690',
      newCases: '138',
      cities: [
        ModelCity(
          name: 'Tanger',
          cases: '54',
        ),
        ModelCity(
          name: 'Tetouan',
          cases: '74',
        ),
        ModelCity(
          name: 'Hoceima',
          cases: '25',
        ),
      ],
    ),
    ModelRegion(
      name: 'Fès meknes',
      totalCases: '5635',
      newCases: '164',
      cities: [
        ModelCity(
          name: 'Fès',
          cases: '44',
        ),
        ModelCity(
          name: 'meknes',
          cases: '7',
        ),
      ],
    ),
    ModelRegion(
      name: 'Marrakech Safi',
      totalCases: '5487',
      newCases: '194',
      cities: [
        ModelCity(
          name: 'Marrakech',
          cases: '74',
        ),
        ModelCity(
          name: 'Marrakech',
          cases: '47',
        ),
        ModelCity(
          name: 'Safi',
          cases: '58',
        ),
        ModelCity(
          name: 'Safi',
          cases: '85',
        ),
      ],
    ),
    ModelRegion(
      name: 'Rabat Salé Kenitra​',
      totalCases: '3241',
      newCases: '63',
      cities: [
        ModelCity(
          name: 'Rabat',
          cases: '14',
        ),
        ModelCity(
          name: 'Rabat',
          cases: '41',
        ),
        ModelCity(
          name: 'Salé',
          cases: '25',
        ),
        ModelCity(
          name: 'Salé',
          cases: '52',
        ),
      ],
    ),
    ModelRegion(
      name: '​​Daraa-tafilalet',
      totalCases: '1063',
      newCases: '51',
      cities: [
        ModelCity(
          name: '​​Daraa',
          cases: '01',
        ),
        ModelCity(
          name: '​​Daraa',
          cases: '10',
        ),
        ModelCity(
          name: 'tafilalet',
          cases: '5',
        ),
      ],
    ),
  ];
}
