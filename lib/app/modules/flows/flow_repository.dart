import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '/app/core/values/app_values.dart';
import '../../network/http.dart';


class FlowRepository {

  static Future<List<Map<String, dynamic>>> getFiles(int id) async {
    List<dynamic> data = (await Http.get('balance-flows/$id/files'))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<bool> uploadFile(int id, String filePath) async {
    MultipartFile file = await MultipartFile.fromFile(filePath, contentType: MediaType('image', 'jpeg'));
    return (await Http.post('balance-flows/$id/addFile', data: FormData.fromMap({
      'id': id,
      'file': file
    })))['success'];
  }

  static String buildUrl(Map<String, dynamic> file) {
    return '${AppValues.apiUrl}/api/v1/flow-files/view?id=${file['id']}&createTime=${file['createTime']}';
  }

}