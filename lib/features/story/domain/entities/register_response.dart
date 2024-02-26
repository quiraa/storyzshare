import 'package:equatable/equatable.dart';

class RegisterResponseEntity extends Equatable {
  final bool? error;
  final String? message;

  const RegisterResponseEntity({
    this.error,
    this.message,
  });

  @override
  List<Object?> get props {
    return [
      error,
      message,
    ];
  }
}
