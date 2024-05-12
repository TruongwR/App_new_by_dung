import 'package:get/get.dart';
import 'package:news_app_ui/data/model/news_model.dart';
import 'package:news_app_ui/data/model/pagination.dart';
import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';
import 'package:news_app_ui/screen/add_profile_health/views/add_profile_health_view.dart';
import 'package:news_app_ui/screen/home/home_page.dart';
import 'package:news_app_ui/screen/page/page.dart';
import 'package:news_app_ui/screen/search/search_page.dart';

class MainTabController extends PaginationController<NewsModel> {
  final authProvider = AuthProvider();
  final newModel = NewsModel().obs;
  final pages = [
    HomePage(),
    const SearchPage(),
    const SamplePage(
      title: 'Book Mark Page',
    ),
    const AddProfileHealthView(),
  ];
  final pageIndex = 0.obs;

  void setSelectedIndex(value) {
    pageIndex.value = value;
  }

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
    return authProvider.fetchNew(page: 0, limit: 10, newest: false);
  }
}
