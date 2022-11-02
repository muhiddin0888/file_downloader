import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_task/data/repostory/category_repostory.dart';
import 'package:flutter_git_task/data/api/api_client.dart';
import 'package:flutter_git_task/data/api/api_provider.dart';
import 'package:flutter_git_task/services/local_notification_service.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'cubit/file_manager_cubit.dart';
import 'data/models/fileModel.dart';

class SingleFileDownload extends StatelessWidget {
  SingleFileDownload({Key? key, required this.fileInfo}) : super(key: key);

  final FileItem fileInfo;
  FileManagerCubit fileManagerCubit = FileManagerCubit(
      fileRepository:
          FileRepository(apiProvider: ApiProvider(apiClient: ApiClient())));

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileManagerCubit,
      child: BlocConsumer<FileManagerCubit, FileManagerState>(
        listener: (context, state) {
          print(state.isDownloaded);
          if (state.isDownloaded) {
            LocalNotificationService.localNotificationService
                .showNotification(state.newFileLocation);
          }
        },
        builder: (context, state) {
          return ListTile(
            leading: state.newFileLocation.isEmpty
                ? const Icon(CupertinoIcons.cloud_download)
                : const Icon(CupertinoIcons.cloud_download_fill),
            title: Text(
              "Downloaded: ${(state.progress * 100).toStringAsFixed(2)} %",
            ),
            subtitle: LinearProgressIndicator(
              value: state.progress,
              backgroundColor: Colors.grey,
            ),
            onTap: () {
              context
                  .read<FileManagerCubit>()
                  .downloadIfExists(fileInfo: fileInfo);
            },
            trailing: IconButton(
              onPressed: () {
                if (state.newFileLocation.isNotEmpty) {
                  print(state.newFileLocation);
                  OpenFile.open(state.newFileLocation);
                }
              },
              icon: const Icon(CupertinoIcons.doc),
            ),
          );
        },
      ),
    );
  }
}
