import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template user}
/// User model
///
/// [AuthUser.empty] represents an unauthenticated user.
/// {@endtemplate}
///

@JsonSerializable()
class AuthUser extends Equatable {
  /// {@macro user}
  const AuthUser({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  final String id;
  final String? email;
  final String? name;
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = AuthUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AuthUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
      ];
}
