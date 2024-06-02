import 'package:get/get.dart';
import 'package:news_app_ui/data/model/new_model.dart';
import 'package:news_app_ui/data/model/pagination.dart';
import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';

class BookmarkController extends PaginationController<NewsModel> {
  final authProvider = AuthProvider();
  final newModel = NewsModel().obs;
  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  @override
  Future<PaginationData<NewsModel>?> fetchApi(int page) {
    return authProvider.fetchBookMark(page: page, limit: 10);
  }
}
