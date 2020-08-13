import 'package:covid19morocco/data.dart';
import 'package:covid19morocco/models/model_data.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

class ServiceData {
  static Future<ModelData> getData() async {
    DocumentSnapshot ref =
        await firestore().collection('covid19maroc').doc('data').get();
    print(ref.data());
    return ModelData.fromJson(ref.data());
  }

  static Future<ModelData> getLocalData() async {
    return Data.modelData;
  }
}
