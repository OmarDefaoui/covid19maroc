import 'package:covid19morocco/models/model_data.dart';
import 'package:firebase/firebase.dart';

class AddDataService {
  static Future<bool> addData(ModelData data) async {
    try {
      await firestore()
          .collection('covid19maroc')
          .doc('data')
          .set(data.toJson());

      await firestore()
          .collection('covid19maroc')
          .doc('history')
          .collection(data.date.split(' ')[0].trim())
          .doc('data')
          .set(data.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }
}
