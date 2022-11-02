import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_task/cubit/file_manager_cubit.dart';
import 'package:flutter_git_task/home_page.dart';
import 'package:flutter_git_task/data/repostory/category_repostory.dart';
import 'package:flutter_git_task/data/api/api_client.dart';
import 'package:flutter_git_task/data/api/api_provider.dart';
import 'package:flutter_git_task/services/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.localNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiProvider apiProvider = ApiProvider(apiClient: ApiClient());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => FileManagerCubit(
                fileRepository: FileRepository(apiProvider: apiProvider))),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
