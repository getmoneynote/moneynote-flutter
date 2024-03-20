import '/app/modules/accounts/data/account_repository.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';

class AccountOverviewController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<num> data = [];

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    try {
      status = LoadDataStatus.progress;
      update();
      data = await AccountRepository.balanceView();
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

}