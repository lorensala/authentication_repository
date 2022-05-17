import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

enum LanguageCode { en, es }

/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(
      String code, LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en:
        switch (code) {
          case 'invalid-email':
            return const SignUpWithEmailAndPasswordFailure(
              'Email is not valid or badly formatted.',
            );
          case 'user-disabled':
            return const SignUpWithEmailAndPasswordFailure(
              'This user has been disabled. Please contact support for help.',
            );
          case 'email-already-in-use':
            return const SignUpWithEmailAndPasswordFailure(
              'An account already exists for that email.',
            );
          case 'operation-not-allowed':
            return const SignUpWithEmailAndPasswordFailure(
              'Operation is not allowed.  Please contact support.',
            );
          case 'weak-password':
            return const SignUpWithEmailAndPasswordFailure(
              'Please enter a stronger password.',
            );
          default:
            return const SignUpWithEmailAndPasswordFailure();
        }
      case LanguageCode.es:
        switch (code) {
          case 'invalid-email':
            return const SignUpWithEmailAndPasswordFailure(
              'El email no es válido o tiene un formato incorrecto.',
            );
          case 'user-disabled':
            return const SignUpWithEmailAndPasswordFailure(
              'El usuario ha sido deshabilitado. Contáctese con soporte.',
            );
          case 'email-already-in-use':
            return const SignUpWithEmailAndPasswordFailure(
              'El email ya tiene asociado una cuenta.',
            );
          case 'operation-not-allowed':
            return const SignUpWithEmailAndPasswordFailure(
              'Operación no permitida. Por favor, contáctese con soporte.',
            );
          case 'weak-password':
            return const SignUpWithEmailAndPasswordFailure(
              'Por favor, ingrese una contraseña más fuerte.',
            );
          default:
            return const SignUpWithEmailAndPasswordFailure(
                'Error desconocido.');
        }
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(
      String code, LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en:
        switch (code) {
          case 'invalid-email':
            return const LogInWithEmailAndPasswordFailure(
              'Email is not valid or badly formatted.',
            );
          case 'user-disabled':
            return const LogInWithEmailAndPasswordFailure(
              'This user has been disabled. Please contact support for help.',
            );
          case 'user-not-found':
            return const LogInWithEmailAndPasswordFailure(
              'Email is not found, please create an account.',
            );
          case 'wrong-password':
            return const LogInWithEmailAndPasswordFailure(
              'Incorrect email or password, please try again.',
            );
          default:
            return const LogInWithEmailAndPasswordFailure();
        }
      case LanguageCode.es:
        switch (code) {
          case 'invalid-email':
            return const LogInWithEmailAndPasswordFailure(
              'El email no es válido o tiene un formato incorrecto.',
            );
          case 'user-disabled':
            return const LogInWithEmailAndPasswordFailure(
              'El usuario ha sido deshabilitado. Contáctese con soporte.',
            );
          case 'user-not-found':
            return const LogInWithEmailAndPasswordFailure(
              'El email no esta registrado. Por favor, creese una cuenta.',
            );
          case 'wrong-password':
            return const LogInWithEmailAndPasswordFailure(
              'El email o la contraseña son incorrectos. Por favor, intente nuevamente.',
            );
          default:
            return const LogInWithEmailAndPasswordFailure('Error desconocido.');
        }
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithGoogleFailure.fromPlatformCode(
      String code, LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en:
        switch (code) {
          case 'sign_in_canceled':
            return const LogInWithGoogleFailure('Sign in canceled.');
          default:
            return const LogInWithGoogleFailure();
        }

      case LanguageCode.es:
        switch (code) {
          case 'sign_in_canceled':
            return const LogInWithGoogleFailure('Inicio de sesión cancelado.');
          default:
            return const LogInWithGoogleFailure();
        }
    }
  }

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(
      String code, LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en:
        switch (code) {
          case 'account-exists-with-different-credential':
            return const LogInWithGoogleFailure(
              'Account exists with different credentials.',
            );
          case 'invalid-credential':
            return const LogInWithGoogleFailure(
              'The credential received is malformed or has expired.',
            );
          case 'operation-not-allowed':
            return const LogInWithGoogleFailure(
              'Operation is not allowed.  Please contact support.',
            );
          case 'user-disabled':
            return const LogInWithGoogleFailure(
              'This user has been disabled. Please contact support for help.',
            );
          case 'user-not-found':
            return const LogInWithGoogleFailure(
              'Email is not found, please create an account.',
            );
          case 'wrong-password':
            return const LogInWithGoogleFailure(
              'Incorrect password, please try again.',
            );
          case 'invalid-verification-code':
            return const LogInWithGoogleFailure(
              'The credential verification code received is invalid.',
            );
          case 'invalid-verification-id':
            return const LogInWithGoogleFailure(
              'The credential verification ID received is invalid.',
            );
          default:
            return const LogInWithGoogleFailure();
        }

      case LanguageCode.es:
        switch (code) {
          case 'account-exists-with-different-credential':
            return const LogInWithGoogleFailure(
              'La cuenta existe con credenciales diferentes.',
            );
          case 'invalid-credential':
            return const LogInWithGoogleFailure(
              'La credencial recibida es malformada o ha expirado.',
            );
          case 'operation-not-allowed':
            return const LogInWithGoogleFailure(
              'Operación no permitida. Por favor, contáctese con soporte.',
            );
          case 'user-disabled':
            return const LogInWithGoogleFailure(
              'El usuario ha sido deshabilitado. Contáctese con soporte para ayuda.',
            );
          case 'user-not-found':
            return const LogInWithGoogleFailure(
              'El email no esta registrado. Por favor, creese una cuenta.',
            );
          case 'wrong-password':
            return const LogInWithGoogleFailure(
              'El email o la contraseña son incorrectos. Por favor, intente nuevamente.',
            );
          case 'invalid-verification-code':
            return const LogInWithGoogleFailure(
              'El código de verificación de credenciales recibido es inválido.',
            );
          case 'invalid-verification-id':
            return const LogInWithGoogleFailure(
              'El ID de verificación de credenciales recibido es inválido.',
            );

          default:
            return const LogInWithGoogleFailure('Error desconocido.');
        }
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the user delete process if a failure occurs.
class DeleteUserFailure implements Exception {
  const DeleteUserFailure([this.message = 'An unknown exception occurred.']);

  final String message;

  factory DeleteUserFailure.fromCode(String code, LanguageCode languageCode) {
    switch (languageCode) {
      case LanguageCode.en:
        switch (code) {
          case 'requires-recent-login':
            return const DeleteUserFailure(
                'This operation is sensitive and requires recent authentication. Log in again before retrying this request.');
          default:
            return const DeleteUserFailure();
        }
      case LanguageCode.es:
        switch (code) {
          case 'requires-recent-login':
            return const DeleteUserFailure(
                'Esta operación es sensible y requiere autenticación reciente. Inicie sesión de nuevo antes de volver a intentar esta solicitud.');
          default:
            return const DeleteUserFailure();
        }
    }
  }
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    LanguageCode? languageCode,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _languageCode = languageCode ?? LanguageCode.en;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final LanguageCode _languageCode;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [AuthUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthUser.empty] if the user is not authenticated.
  Stream<AuthUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AuthUser.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current user access token.
  Future<String> getAuthToken() async {
    return await _firebaseAuth.currentUser!.getIdToken();
  }

  /// Returns the current cached user.
  /// Defaults to [AuthUser.empty] if there is no cached user.
  AuthUser get currentUser {
    return _cache.read<AuthUser>(key: userCacheKey) ?? AuthUser.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code, _languageCode);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      throw LogInWithGoogleFailure.fromPlatformCode(e.code, _languageCode);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code, _languageCode);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code, _languageCode);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [AuthUser.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> deleteUser() async {
    try {
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw DeleteUserFailure.fromCode(e.code, _languageCode);
    } catch (_) {
      throw const DeleteUserFailure();
    }
  }
}

extension on firebase_auth.User {
  AuthUser get toUser {
    return AuthUser(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
