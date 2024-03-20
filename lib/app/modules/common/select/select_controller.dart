import '/app/core/base/base_controller.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/base/enums.dart';

class SelectController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<dynamic> options = [];

  void load(String prefix, {Map<String, dynamic>? params}) async {
    try {
      status = LoadDataStatus.progress;
      options = [];
      update();
      options = await BaseRepository.queryAll(prefix, params: params);
      if (options.isEmpty) {
        status = LoadDataStatus.empty;
      } else {
        status = LoadDataStatus.success;
      }
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

  void clear() {
    status = LoadDataStatus.empty;
    options = [];
    update();
  }

}