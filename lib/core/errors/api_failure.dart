import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failure.freezed.dart';

@freezed
class ApiFailure with _$ApiFailure {
  const factory ApiFailure.permissionRequired(
    Object e, {
    required String message,
  }) = _PermissionRequired;
  const factory ApiFailure.serverError(
    Object e, {
    required String message,
  }) = _ServerError;
  const factory ApiFailure.clientError(
    Object e, {
    required String message,
  }) = _ClientError;
}
