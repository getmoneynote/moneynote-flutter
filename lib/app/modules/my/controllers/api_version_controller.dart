import '/app/network/http.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';

class ApiVersionController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  String version = 'loading...';

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    try {
      status = LoadDataStatus.progress;
      update();
      version = (await Http.get('version'))['data'];
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

}