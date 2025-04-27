// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:untitled/features/eco_zone/data/data_source/remote_data_source.dart';

class Repo {
  RemoteDataSource remoteDataSource;
  Repo({required this.remoteDataSource});

  Future<void> register(String userName, String email, String password) async {
    try {
      await remoteDataSource.register(userName, email, password);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await remoteDataSource.login(email, password);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
