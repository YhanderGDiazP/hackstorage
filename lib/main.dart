import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/data/datasource/post_datasource.dart';
import 'package:hackstorage/feature/posts/data/repository/post_repository_imp.dart';
import 'package:hackstorage/feature/posts/domain/usecase/create_post_usecase.dart';
import 'package:hackstorage/feature/posts/domain/usecase/delete_post_usecase.dart';
import 'package:hackstorage/feature/posts/domain/usecase/get_post_usecase.dart';
import 'package:hackstorage/feature/posts/domain/usecase/update_post_usecase.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider_offline.dart';
import 'package:hackstorage/feature/users/data/datasource/user_datasource.dart';
import 'package:hackstorage/feature/users/data/repository/user_repository_imp.dart';
import 'package:hackstorage/feature/users/domain/usecase/get_users_usecase.dart';
import 'package:hackstorage/feature/users/domain/usecase/register_user_usecase.dart';
import 'package:hackstorage/feature/users/presentation/pages/init_page.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider_offline.dart';
import 'package:hackstorage/firebase_options.dart';
import 'package:hackstorage/pruebas_provider.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userRemoteDataSource = UserRemoteDataSourceImp();
  final userRepository = UserRepositoryImp(userRemoteDataSource);

  final postRemoteDataSource = PostRemoteDataSourceImp();
  final postRepository = PostRepositoryImp(postRemoteDataSource);

  final registerUserUsecase = RegisterUserUsecase(userRepository);
  final getUserUsecase = GetUserUsecase(userRepository);

  final getPostUsecase = GetPostUsecase(postRepository);
  final createPostUsecase = CreatePostUsecase(postRepository);
  final updatePostUsecase = UpdatePostUsecase(postRepository);
  final deletePostUsecase = DeletePostUsecase(postRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            registerUserUsecase,
            getUserUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(
            getPostUsecase,
            createPostUsecase,
            updatePostUsecase,
            deletePostUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PruebasProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProviderOffline(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProviderOffline(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const InitPage(),
    );
  }
}
