import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_task/cubit/file_manager_cubit.dart';
import 'package:flutter_git_task/services/local_notification_service.dart';
import 'package:flutter_git_task/single_file_download.dart';
import 'package:formz/formz.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int doublePress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File download"),
      ),
      body: BlocBuilder<FileManagerCubit, FileManagerState>(
        builder: (context, state) {
          var st = state.status;
          var fileItem = state.fileItem;

          if (st == FormzStatus.submissionInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (st == FormzStatus.submissionSuccess) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: List.generate(fileItem.length, (index) {
                var singleFile = fileItem[index];
                return SingleFileDownload(fileInfo: singleFile);
              }),
            );
          } else {
            return Center(child: Text(state.errorText));
          }
        },
      ),
    );
  }
}
