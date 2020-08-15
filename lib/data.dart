import 'package:covid19morocco/models/model_city.dart';
import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/models/model_region.dart';

class Data {
  static ModelData modelData = ModelData(
    date: '2020-08-14 14:08:58.494',
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
    totalArtificialRespiration: '10',
    newArtificialRespiration: '1',
    regions: listRegions,
  );

  static List<ModelRegion> listRegions = [
    ModelRegion(
      name: 'Casa Settat​',
      totalCases: '9436',
      newCases: '392',
      cities: [
        ModelCity(
          name: 'Casa',
          newCases: '100',
        ),
        ModelCity(
          name: 'Settat',
          newCases: '20',
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
          newCases: '54',
        ),
        ModelCity(
          name: 'Tetouan',
          newCases: '74',
        ),
        ModelCity(
          name: 'Hoceima',
          newCases: '25',
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
          newCases: '44',
        ),
        ModelCity(
          name: 'meknes',
          newCases: '7',
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
          newCases: '74',
        ),
        ModelCity(
          name: 'Marrakech',
          newCases: '47',
        ),
        ModelCity(
          name: 'Safi',
          newCases: '58',
        ),
        ModelCity(
          name: 'Safi',
          newCases: '85',
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
          newCases: '14',
        ),
        ModelCity(
          name: 'Rabat',
          newCases: '41',
        ),
        ModelCity(
          name: 'Salé',
          newCases: '25',
        ),
        ModelCity(
          name: 'Salé',
          newCases: '52',
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
          newCases: '01',
        ),
        ModelCity(
          name: '​​Daraa',
          newCases: '10',
        ),
        ModelCity(
          name: 'tafilalet',
          newCases: '5',
        ),
      ],
    ),
  ];
}
