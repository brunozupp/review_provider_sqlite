import 'package:firebase_auth/firebase_auth.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository.dart';
import 'package:review_provider_sqlite/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  
  final UserRepository _userRepository;
  final TasksRepository _tasksRepository;

  UserServiceImpl({
    required UserRepository userRepository,
    required TasksRepository tasksRepository,
  })  : _userRepository = userRepository,
        _tasksRepository = tasksRepository;

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
  
  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    return await _userRepository.forgotPassword(
      email: email,
    );
  }
  
  @override
  Future<User?> googleLogin() async {
    return await _userRepository.googleLogin();
  }
  
  @override
  Future<void> logout() async {
    await _userRepository.logout();
    await _tasksRepository.deleteAll();
  }
  
  @override
  Future<void> updateDisplayName({
    required String name,
  }) async {
    return await _userRepository.updateDisplayName(
      name: name,
    );
  }

}