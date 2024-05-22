import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/data/model/new_model.dart';

import 'package:news_app_ui/data/model/pagination.dart';
import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';
import 'package:news_app_ui/screen/add_profile_health/views/mange_profile_view.dart';
import 'package:news_app_ui/screen/home/home_page.dart';
import 'package:news_app_ui/screen/page/page.dart';
import 'package:news_app_ui/screen/search/search_page.dart';

class MainTabController extends PaginationController<NewsModel> {
  final authProvider = AuthProvider();
  final newModel = NewsModel().obs;
  final TextEditingController search= TextEditingController();
  final pages = [
    const HomePage(),
     SearchPage(),
    const SamplePage(
      title: 'Book Mark Page',
    ),
    const AddProfileHealthView(),
  ];
  final pageIndex = 0.obs;

  void setSelectedIndex(value) {
    pageIndex.value = value;
  }

  // @override
  // void onReady() {
  //   onRefresh();
  //   super.onReady();
  // }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  @override
  Future<PaginationData<NewsModel>?> fetchApi(int page) {
    return pageIndex.value==0?  authProvider.fetchNew(page: page, limit: 10, newest: true):authProvider.search(page: page, limit: 10, newest: true, keys: search.text);
  }
}
