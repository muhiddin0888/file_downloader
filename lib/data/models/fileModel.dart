import 'package:json_annotation/json_annotation.dart';

part 'fileModel.g.dart';

// "id": 1,
// "category_id": 1,
// "name": "Macbook",
// "price": 1200,
// "file_url": "https://n.ziyouz.com/books/darsliklar/yangi/7-sinf/Adabiyot.%207-sinf%20(2017,%20Q.Yo'ldoshev,%20B.Qosimov).pdf"

@JsonSerializable()
class FileItem {
  @JsonKey(defaultValue: 0, name: "id")
  int id;

  @JsonKey(defaultValue: 0, name: "category_id")
  int categoryId;

  @JsonKey(defaultValue: "", name: "name")
  String name;

  @JsonKey(defaultValue: 0, name: "price")
  int price;

  @JsonKey(defaultValue: "", name: "file_url")
  String fileUrl;

  FileItem({
    required this.categoryId,
    required this.fileUrl,
    required this.id,
    required this.name,
    required this.price,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) =>
      _$FileItemFromJson(json);

  Map<String, dynamic> toJson() => _$FileItemToJson(this);
}
