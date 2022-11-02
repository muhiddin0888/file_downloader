import 'package:dio/dio.dart';
import '../models/fileModel.dart';
import 'api_client.dart';

class ApiProvider {
  final ApiClient apiClient;

  ApiProvider({required this.apiClient});

  Future<List<FileItem>> getAllFiles() async {
    Response response = await apiClient.dio.get(apiClient.dio.options.baseUrl);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<FileItem> files = (response.data["data"] as List?)
              ?.map((e) => FileItem.fromJson(e))
              .toList() ??
          [];
      print("Files $files");
      return files;
    } else {
      throw Exception();
    }
  }
}
