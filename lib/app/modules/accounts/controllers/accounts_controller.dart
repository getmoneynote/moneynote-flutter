import 'package:moneynote/app/core/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/values/app_const.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';

class AccountsController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic> query = {
    AppConst.pageSizeParameter: AppConst.defaultPageSize
  };
  late RefreshController refreshController;
  int tabIndex = 0;

  void tabClick(int index) {
    tabIndex = index;
    update();
    reload();
  }

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    reload();
  }

  void reload() async {
    try {
      status = LoadDataStatus.progress;
      update();
      query[AppConst.pageParameter] = AppConst.pageStart;
      query['type'] = accountTabIndexToType(tabIndex);
      items = await BaseRepository.query1('accounts', query);
      if (items.length < AppConst.defaultPageSize) {
        refreshController.loadNoData();
      }
      if (items.isNotEmpty) {
        status = LoadDataStatus.success;
      } else {
        status = LoadDataStatus.empty;
      }
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

  void loadMore() async {
    try {
      query[AppConst.pageParameter] = query[AppConst.pageParameter] + 1;
      query['type'] = accountTabIndexToType(tabIndex);
      final newItems = await BaseRepository.query1('accounts', query);
      if (newItems.isNotEmpty) {
        items = List.of(items)..addAll(newItems);
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      update();
    } catch (_) {
      refreshController.loadFailed();
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

}