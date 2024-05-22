import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:news_app_ui/data/model/pagination.dart';
import 'package:news_app_ui/utils/auth_service.dart';
import 'package:news_app_ui/utils/dialog_custom.dart';
import 'package:news_app_ui/utils/loading_dialog.dart';


class BaseController extends GetxController {
  late AuthService authService = AuthService.to;
  LoadingDialog showLoadingDialog({
    isShow = true,
    bool dismissable = false,
  }) {
    final context = Get.context!;
    final loadingDialog = LoadingDialog(context, dismissable: dismissable);
    if (isShow) {
      loadingDialog.show();
    }
    return loadingDialog;
  }

  Future<T?> makeRequest<T>(Future<T?> request, {Function(Response<dynamic>)? onError, bool loading = false}) async {
    LoadingDialog? loadingDialog;
    try {
      if (loading) {
        loadingDialog = showLoadingDialog(dismissable: false);
      }
      var result = await request;
      loadingDialog?.dismiss();
      return result;
    } catch (ex, stacktrace) {
      if (isClosed) {
        return null;
      }
      log(stacktrace.toString());
      loadingDialog?.dismiss();
      if (ex is DioException) {
        log('${ex.requestOptions.path} =======> ${ex.response} ===> $ex');
        final data = ex.response;
        if (data != null) {
          if (onError != null) {
            onError(data);
          } else {
            await handleError(data);
          }
        } else {
          await openDialogError(content: ex.toString());
        }
      } else {
        await openDialogError(content: ex.toString());
      }
      return null;
    }
  }

  Future<List<T?>?> makeRequests<T>(List<Future<T?>> request,
      {Function(Response<dynamic>)? onError, bool loading = false}) async {
    LoadingDialog? loadingDialog;
    try {
      if (loading) {
        loadingDialog = showLoadingDialog(dismissable: false);
      }
      var result = await Future.wait(request);
      loadingDialog?.dismiss();
      return result;
    } catch (ex, stacktrace) {
      log(ex.toString());
      log(stacktrace.toString());
      loadingDialog?.dismiss();
      if (ex is DioException) {
        final data = ex.response;
        if (data != null) {
          if (onError != null) {
            onError(data);
          } else {
            await handleError(data);
          }
        } else {
          await openDialogError(content: ex.toString());
        }
      } else {
        await openDialogError(content: ex.toString());
      }
      return null;
    }
  }

  Future handleError(Response<dynamic> response) async {
    int statusCode = response.statusCode ?? -1;
    if (statusCode == 401) {
      await openDialogError(content: 'An error occurred, please login again!!!');
      AuthService.to.logOut();
    } else {
      final data = response.data;
      if (data != null) {
        final messages = data['message'];
        if (messages is List) {
          await openDialogError(content: messages.join('\n'));
        } else {
          await openDialogError(content: response.toString());
        }
      } else {
        await openDialogError(content: response.toString());
      }
    }
  }

  bool get hasLogin => authService.hasLogin();
}

abstract class PaginationController<T> extends BaseController {
  RxInt page = 0.obs;
  final RxList<T> items = <T>[].obs;
  final endOfPage = false.obs;
  final EasyRefreshController refreshController = EasyRefreshController();
  RxBool loading = false.obs;
  bool firstTime = true;
  RxInt totalCount = 0.obs;

  bool get autoRefresh => true;

  @override
  void onInit() {
    if (autoRefresh) {
      onRefresh();
    }
    super.onInit();
  }

  Future<void> onRefresh() async {
    page.value = -1;
    endOfPage.value = false;
    await _requestApi(true);
  }

  Future<void> onLoad() async {
    await _requestApi(false);
  }

  Future<PaginationData<T>?> fetchApi(int page);

  Future _requestApi(bool refresh) async {
    log('endOfPage ${endOfPage.value}');
    if (endOfPage.value) {
      return;
    }
    final result = await makeRequest(fetchApi(page.value + 1));
    if (firstTime) {
      firstTime = false;
    }
    if (result != null) {
      page.value = page.value + 1;
      final list = result.list;
      final pagination = result.pagination;
      endOfPage.value = pagination.endOfPage;
      totalCount.value = pagination.totalElements;
      if (refresh) {
        items.clear();
      }
      items.addAll(list);
    } else {
      log('result is null');
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}

abstract class PaginationGenerateController<T> extends BaseController {
  final RxList<T> items = <T>[].obs;
  final EasyRefreshController refreshController = EasyRefreshController();
  RxInt page = 1.obs;
  final endOfPage = false.obs;
  RxInt totalCount = 0.obs;
  RxBool loading = false.obs;
  RxInt totalPage = 0.obs;
  RxInt limitPage = 15.obs;
  final RxList<T> itemsLoadPage = <T>[].obs;

  bool get firstPage => page.value == 0;
  bool firstTime = true;
  RxInt subLeft = 0.obs;
  RxInt subRight = 0.obs;

  Future<void> onRefresh({int? limit}) async {
    limitPage.value = limit ?? 15;
    firstTime = true;
    page.value = 0;
    items.clear();
    endOfPage.value = false;
    await requestApi();

    fetchTotalPage();
  }

  Future<void> onLoad() async {
    await requestApi();
  }

  void fetchPage() {
    final page = this.page.value;
    final limit = limitPage.value;
    final totalItem = totalCount.value;
    final loading = this.loading.value;

    subLeft.value = page * limit;
    subRight.value = (page - 1) * limit;
    if (items.isEmpty) {
      itemsLoadPage.clear();
    }

    if (items.isNotEmpty && !loading) {
      if (subLeft > totalItem) {
        subLeft.value = totalItem;
      }
      if (subRight < 0) {
        subRight.value = 0;
      }
      itemsLoadPage.value = items.sublist(subRight.value, subLeft.value);
    }
  }

  Future<void> fetchTotalPage() async {
    final limit = limitPage.value;
    totalPage.value = (totalCount.value / limit).ceil();
  }

  Future<PaginationData<T>?> fetchApi(int page);

  Future requestApi({bool ignorePage = false}) async {
    if (!ignorePage) {
      page.value = page.value + 1;
    }
    if (endOfPage.value) {
      loading.value = false;
      return;
    }
    loading.value = true;
    final result = await makeRequest(fetchApi(page.value));
    if (firstTime) {
      firstTime = false;
    }
    if (result != null) {
      final list = result.list;
      final pagination = result.pagination;
      endOfPage.value = pagination.endOfPage;
      totalCount.value = pagination.totalElements;

      items.addAll(list);
      items.refresh();
    } else {
      log('result is null');
    }
    loading.value = false;
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
