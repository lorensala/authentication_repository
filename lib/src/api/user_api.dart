import '../models/user.dart';

/// {@template user_api}
/// The interface for an API that provides access to the app user's data.
/// {@endtemplate}
abstract class UserApi {
  /// {@macro user_api}
  const UserApi();

  /// Provides a [Stream] of the current user.
  Stream<User> getUser();

  /// Updates [User]
  ///
  /// If the user is not signed in, this method will throw [UserNotAuthenticated].
  Future<void> updateUser();

  /// Creates [User]
  ///
  /// If the user is not signed in, this method will throw [UserNotAuthenticated].
  Future<User> createUser();
}

class UserNotAuthenticated implements Exception {
  final String message;

  UserNotAuthenticated({this.message = 'User is not authenticated'});

  @override
  String toString() => message;
}
