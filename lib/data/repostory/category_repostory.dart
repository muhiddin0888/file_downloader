import '../api/api_provider.dart';
import '../models/fileModel.dart';

class FileRepository {
  FileRepository({required ApiProvider apiProvider})
      : _apiProvider = apiProvider;

  final ApiProvider _apiProvider;

  Future<List<FileItem>> getAllFiles() async => _apiProvider.getAllFiles();
}
