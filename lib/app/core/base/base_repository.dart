import '../../network/http.dart';

class BaseRepository {

  static Future<List<Map<String, dynamic>>> query(String prefix, Map<String, dynamic> query) async {
    List<dynamic> data = (await Http.get(prefix, params: {
      ...query,
    }))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<List<Map<String, dynamic>>> query1(String prefix, Map<String, dynamic> query) async {
    List<dynamic> data = (await Http.get(prefix, params: {
      ...query,
      ...{
        'enable': true,
      }
    }))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<bool> toggle(String prefix, int id) async {
    return (await Http.patch('$prefix/$id/toggle'))['success'];
  }

  static Future<bool> delete(String prefix, int id) async {
    return (await Http.delete('$prefix/$id'))['success'];
  }

  static Future<Map<String, dynamic>> get(String prefix, int id) async {
    return (await Http.get('$prefix/$id'))['data'];
  }

  static Future<List<Map<String, dynamic>>> queryAll(String prefix, {Map<String, dynamic>? params}) async {
    List<dynamic> data = (await Http.get('$prefix/all', params: params))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<bool> add(String prefix, Map<String, dynamic> form) async {
    return (await Http.post(prefix, data: form))['success'];
  }

  static Future<bool> update(String prefix, int id, Map<String, dynamic> form) async {
    return (await Http.put('$prefix/$id', data: form))['success'];
  }

  static Future<Map<String, dynamic>> update2(String prefix, int id, Map<String, dynamic> form) async {
    return (await Http.put('$prefix/$id', data: form));
  }

  static Future<bool> action(String uri) async {
    return (await Http.patch(uri))['success'];
  }

}