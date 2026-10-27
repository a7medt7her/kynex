import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:kynex/core/helper/firebase_handel.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';
import 'package:kynex/core/services/app_dependencies.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';

class UserDataSources {
  Future<String> _getUid() async {
    final uid = await getIt.get<SecureStorageService>().getUid();

    if (uid == null || uid.isEmpty) {
      throw Exception('User UID not found');
    }

    return uid;
  }

  Future<Either<String, String>> gander(String gander, int pageComplete) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).update({
        'gander': gander,
        'pageComplete': pageComplete,
      });
      return right('data saved successful');
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return left(fireBaseHandel(e));
    }
  }

  Future<Either<String, String>> exerciseInfo(
    String location,
    List<WeekDay> days,
    String duration,
    int pageComplete,
    String activityLevel,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).update({
        'location': location,
        'days': days.map((day) => day.name).toList(),
        'duration': duration,
        'pageComplete': pageComplete,
        'activityLevel': activityLevel,
      });
      return right('data saved successful');
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return left(fireBaseHandel(e));
    }
  }

  Future<Either<String, String>> userGoals(
    String currentLevel,
    String goal,
    int pageComplete,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).update({
        'currentLevel': currentLevel,
        'goal': goal,
        'pageComplete': pageComplete,
      });
      return right('data saved successful');
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return left(fireBaseHandel(e));
    }
  }

  Future<Either<String, String>> updateUserDataBody(
    num bmi,
    num bmr,
    num tdee,
    num targetCalories,
    num weightDifference,
    num weightChangePercentage,
    num targetBmi,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).update({
        'bmi': bmi,
        'bmr': bmr,
        'targetCalories': targetCalories,
        'weightChangePercentage': weightChangePercentage,
        'weightDifference': weightDifference,
        'targetBmi': targetBmi,
        'tdee': tdee,
      });
      return right('data saved successful');
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return left(fireBaseHandel(e));
    }
  }

  Future<Either<String, String>> userBody(
    num weight,
    num height,
    int age,
    String weightUnite,
    String heightUnite,
    String tWeightUnite,
    num targetWeight,
    int pageComplete,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).update({
        'weight': weight,
        'height': height,
        'age': age,
        'targetWeight': targetWeight,
        'pageComplete': pageComplete,
        'weightUnite': weightUnite,
        'heightUnite': heightUnite,
        'tWightUnite': tWeightUnite,
      });
      return right('data saved successful');
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return left(fireBaseHandel(e));
    }
  }

  Future<Map<String, dynamic>> getUserdata() async {
    final uid = await _getUid();
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!userDoc.exists) {
      throw Exception('data not founded');
    }
    final Map<String, dynamic>? data = userDoc.data();
    if (data == null) {
      throw Exception('User data is empty');
    }

    return data;
  }

  Future<Either<String, String>> isSetupComplete(bool isComplete) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).update({'isComplete': isComplete});
      return right('data saved successful');
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return left(fireBaseHandel(e));
    }
  }
}
