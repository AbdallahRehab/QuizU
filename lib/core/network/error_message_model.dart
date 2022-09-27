import 'package:equatable/equatable.dart';

class ErrorMassageModel extends Equatable {
  final int statusCode;
  final String statusMessage;
  final bool success;

  const ErrorMassageModel(
      {required this.statusCode,
      required this.statusMessage,
      required this.success});

  factory ErrorMassageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMassageModel(
      statusCode: json["status_code"] ?? 400,
      statusMessage: json["msg"] ?? "",
      success: json["success"] ?? false,
    );
  }

  @override
  List<Object> get props => [statusCode, statusMessage, success];
}
