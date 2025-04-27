// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/core/cache/cache_helper.dart';

class RemoteDataSource {
  // FirebaseAuth fireauth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> register(String userName, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        CacheHelper().saveData(
          key: 'userId',
          value: userCredential.user!.uid,
        );
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': userName,
          'email': email,
          'createdAt': DateTime.now(),
        });
        print('User added to Firestore successfully ');
      } else {
        print('UserCredential returned null user ');
      }
    } catch (e) {
      throw Exception('Error during register: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      CacheHelper().saveData(
        key: 'userId',
        value: userCredential.user!.uid,
      );
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}
