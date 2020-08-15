import 'package:covid19morocco/data.dart';
import 'package:covid19morocco/models/model_data.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

class ServiceData {
  static Future<ModelData> getData(bool isArabic) async {
    try {
      DocumentSnapshot ref =
          await firestore().collection('covid19maroc').doc('data').get();
      print(ref.data());
      return ModelData.fromJson(ref.data(), isArabic);
    } catch (error) {
      throw Exception('error $error');
    }
  }

  static Future<ModelData> getHistoryData(String date, bool isArabic) async {
    // date must be: yyyy-MM-dd
    try {
      DocumentSnapshot ref = await firestore()
          .collection('covid19maroc')
          .doc('history')
          .collection(date)
          .doc('data')
          .get();
      print(ref.data());
      return ModelData.fromJson(ref.data(), isArabic);
    } catch (error) {
      throw Exception('error $error');
    }
  }

  static Future<ModelData> getLocalData(bool isArabic) async {
    return Data.modelData;
  }
}
