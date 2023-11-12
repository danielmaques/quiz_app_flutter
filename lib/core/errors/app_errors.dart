


// ignore_for_file: overridden_fields

import 'package:quiz_anac/core/errors/base_error.dart';

class AppError extends BaseError {
  @override
  final String message;

  AppError(this.message) : super(message);
}
