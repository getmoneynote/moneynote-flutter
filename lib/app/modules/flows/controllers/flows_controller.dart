import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/values/app_const.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';
import '../../login/controllers/auth_controller.dart';

class FlowsController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic> query = {
    AppConst.pageSizeParameter: AppConst.defaultPageSize
  };

  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    reset();
    reload();
  }

  void reset() {
    query = {
      AppConst.pageSizeParameter: AppConst.defaultPageSize
    };
    query['book'] = Get.find<AuthController>().initState['book'];
    update();
  }

  void reload() async {
    try {
      status = LoadDataStatus.progress;
      update();
      query[AppConst.pageParameter] = AppConst.pageStart;
      items = await BaseRepository.query1('balance-flows', buildQuery());
      if (items.length < AppConst.defaultPageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      if (items.isNotEmpty) {
        status = LoadDataStatus.success;
      } else {
        status = LoadDataStatus.empty;
      }
      update();
    } catch (_) {
      _.printError();
      status = LoadDataStatus.failure;
      update();
    }
  }

  void loadMore() async {
    try {
      query[AppConst.pageParameter] = query[AppConst.pageParameter] + 1;
      final newItems = await BaseRepository.query('balance-flows', buildQuery());
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

  void queryChanged(Map<String, dynamic> newQuery) {
    query = {
      ...query,
      ...newQuery
    };
    reload();
  }

  void changeSort(value) {
    query = {
      ...query,
      ...{
        AppConst.sortParameter: value
      }
    };
    reload();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  Map<String, dynamic> buildQuery() {
    Map<String, dynamic> newQuery = { ...query };
    if (query['book']?['value'] != null) {
      newQuery['book'] = query['book']?['value'];
    }
    if (query['account']?['value'] != null) {
      newQuery['account'] = query['account']?['value'];
    }
    if (query['payees']?['value'] != null) {
      newQuery['payees'] = [query['payees']?['value']];
    }
    if (!(query['categories']?.isEmpty ?? true)) {
      newQuery['categories'] = query['categories'].map((e) => e['value']).toList();
    }
    if (!(query['tags']?.isEmpty ?? true)) {
      newQuery['tags'] = query['tags'].map((e) => e['value']).toList();
    }
    return newQuery;
  }

}