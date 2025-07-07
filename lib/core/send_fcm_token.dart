// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:untitled/core/utils/notifications/get_fcm_token.dart';

class SendFcmToken {
  final Dio dio;
  SendFcmToken({required this.dio});

  Future<void> sendFcmToken() async {
    try {
      await dio.post(
        'https://azure-production.up.railway.app/api/v1/fcm-token',
        data: {'fcmToken': PushNotificationsService.token},
      );

      log("Successfully sent FCM token");
    } on DioException catch (e) {
      throw Exception('Failed to send FCM token: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
