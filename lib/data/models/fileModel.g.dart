// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileItem _$FileItemFromJson(Map<String, dynamic> json) => FileItem(
      categoryId: json['category_id'] as int? ?? 0,
      fileUrl: json['file_url'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
    );

Map<String, dynamic> _$FileItemToJson(FileItem instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'price': instance.price,
      'file_url': instance.fileUrl,
    };
