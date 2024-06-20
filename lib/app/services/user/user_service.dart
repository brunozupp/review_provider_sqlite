
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserService {
  
  Future<User?> register({
    required String email,
    required String password,
  });
}