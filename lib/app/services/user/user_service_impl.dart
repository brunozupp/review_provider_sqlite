import 'package:firebase_auth/firebase_auth.dart';
import 'package:review_provider_sqlite/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  
  final UserRepository _userRepository;

  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    return await _userRepository.register(
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    return await _userRepository.login(
      email: email,
      password: password,
    );
  }

}