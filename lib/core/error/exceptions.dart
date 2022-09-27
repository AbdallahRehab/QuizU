
import '../network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMassageModel errorMassageModel;

  ServerException({required this.errorMassageModel});
}
class LocalException implements Exception {
  final ErrorMassageModel errorMassageModel;

  LocalException({required this.errorMassageModel});
}

class PhoneException implements Exception {
  final ErrorMassageModel errorMassageModel;

  PhoneException({required this.errorMassageModel});
}
