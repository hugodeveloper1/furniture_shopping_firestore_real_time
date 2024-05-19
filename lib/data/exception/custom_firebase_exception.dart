// ignore_for_file: use_super_parameters

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomFirebaseException extends FirebaseException {
  CustomFirebaseException({
    required String plugin,
    required String message,
  }) : super(plugin: plugin, message: message);

  @override
  String toString() {
    return 'CustomFirebaseException: $message';
  }
}
