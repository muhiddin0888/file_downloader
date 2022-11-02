part of 'file_manager_cubit.dart';

class FileManagerState extends Equatable {
  FileManagerState({
    required this.errorText,
    required this.progress,
    required this.status,
    required this.newFileLocation,
    required this.fileItem,
    required this.isDownloaded,
  });

  final double progress;
  final String newFileLocation;
  final FormzStatus status;
  final List<FileItem> fileItem;
  final String errorText;
  final bool isDownloaded;

  FileManagerState copyWith(
          {double? progress,
          bool? isDownloaded,
          String? newFileLocation,
          FormzStatus? status,
          List<FileItem>? fileItem,
          String? errorText}) =>
      FileManagerState(
        isDownloaded: isDownloaded ?? this.isDownloaded,
        errorText: errorText ?? this.errorText,
        fileItem: fileItem ?? this.fileItem,
        progress: progress ?? this.progress,
        newFileLocation: newFileLocation ?? this.newFileLocation,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props =>
      [progress, newFileLocation, status, fileItem, errorText, isDownloaded];
}
