import 'package:firebase_auth/firebase_auth.dart';

String fireBaseHandel(Object e) {
  if (e is FirebaseAuthException) {
    return e.code;
  } else {
    return 'something wrong';
  }
}
