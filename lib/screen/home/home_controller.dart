import 'package:news_app_ui/data/model/news_model.dart';
import 'package:news_app_ui/data/model/pagination.dart';
import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';

class HomeController extends PaginationController<NewsModel> {
  final AuthProvider authProvider = AuthProvider();

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  @override
  Future<PaginationData<NewsModel>?> fetchApi(int page) {
    return authProvider.fetchNew(page: page, limit: 10, newest: false);
  }
}
