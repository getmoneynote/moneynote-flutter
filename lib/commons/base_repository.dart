import '/commons/index.dart';

class BaseRepository {

  static Future<List<Map<String, dynamic>>> query(String prefix, Map<String, dynamic> form) async {
    List<dynamic> data = (await HttpClient().get(prefix, params: {
      ...form,
      ...{
        'enable': true,
      }
    }))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<bool> delete(String prefix, int id) async {
    return (await HttpClient().delete('$prefix/$id'))['success'];
  }

  static Future<bool> toggle(String prefix, int id) async {
    return (await HttpClient().patch('$prefix/$id/toggle'))['success'];
  }

  static Future<bool> action(String uri) async {
    return (await HttpClient().patch(uri))['success'];
  }

  static Future<Map<String, dynamic>> get(String prefix, int id) async {
    return (await HttpClient().get('$prefix/$id'))['data'];
  }

  static Future<bool> add(String prefix, Map<String, dynamic> form) async {
    return (await HttpClient().post(prefix, data: form))['success'];
  }

  static Future<bool> update(String prefix, int id, Map<String, dynamic> form) async {
    return (await HttpClient().put('$prefix/$id', data: form))['success'];
  }

  static Future<List<Map<String, dynamic>>> queryAll(String prefix, Map<String, dynamic> query) async {
    List<dynamic> data = (await HttpClient().get('$prefix/all', params: {
      ...query,
      ...{
        'enable': true,
      }
    }))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

}