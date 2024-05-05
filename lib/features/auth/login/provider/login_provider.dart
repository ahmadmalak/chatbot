import 'package:ask_pdf/core/firebase/auth.dart';
import 'package:ask_pdf/services/constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService;

  LoginProvider({required AuthService authService})
      : _authService = authService;

  bool isPasswordVisible = false;

  Future<bool> onLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    BotToast.showLoading();
    UserCredential? userCredential =
        await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );
    if (userCredential != null) {
      box.write('isUserLogged', true);
      box.write('userEmail', userCredential.user!.email);
      box.write('userId', userCredential.user!.uid.toString());
      return true;
    }

    BotToast.closeAllLoading();

    return false;
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final loginProvider = ChangeNotifierProvider<LoginProvider>(
    (ref) => LoginProvider(authService: ref.read(authServiceProvider)));
