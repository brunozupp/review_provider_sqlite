import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/app_widget.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:review_provider_sqlite/app/repositories/user/user_repository.dart';
import 'package:review_provider_sqlite/app/repositories/user/user_repository_impl.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';
import 'package:review_provider_sqlite/app/services/user/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false, // When run the app it will create the database and all the executions needed
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
      ],
      child: const AppWidget(),
    );
  }
}