import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser {
  Future<void> addUserData(
    String uid,
    String username,
    String email,
    bool isSetup,
    DateTime createdAt,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).set({
        'userName': username,
        'email': email,
        'isComplete': isSetup,
        'createdAt': createdAt,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  Future<void> gander(String uid, String gander, int pageComplete) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).update({
        'gander': gander,
        'pageComplete': pageComplete,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  Future<void> exerciseInfo(
    String uid,
    String location,
    List days,
    int duration,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).update({
        'location': location,
        'days': days,
        'duration': duration,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  Future<void> userGoals(
    String uid,
    String currentLevel,
    String goal,
    num wightGoal,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).update({
        'currentLevel': currentLevel,
        'goal': goal,
        'wightGoal': wightGoal,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  Future updateUserDataBody(
    String uid,
    num bmi,
    num bmr,
    num activityFactor,
    num tdee,
    num targetCalories,
    num weightDifference,
    num weightChangePercentage,
    num targetBmi,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).update({
        'bmi': bmi,
        'bmr': bmr,
        'activityFactor': activityFactor,
        'targetCalories': targetCalories,
        'weightChangePercentage': weightChangePercentage,
        'weightDifference': weightDifference,
        'targetBmi': targetBmi,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  Future<void> userBody(String uid, num wight, num height, int age) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).update({
        'wight': wight,
        'height': height,
        'age': age,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
    }
  }
}
