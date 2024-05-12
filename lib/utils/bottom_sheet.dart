import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownItem<T> {
  T key;
  String title;

  DropdownItem(this.key, this.title);
}

void displayBottomSheet<T>(
    void Function(DropdownItem<T>) onTap, List<DropdownItem<T>> items,
    {EdgeInsets? padding}) {
  showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext ctx) {
        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (ctx, idx) => GestureDetector(
              child: Padding(
                padding:
                    padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  items[idx].title,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              onTap: () => onTap(items[idx])),
          separatorBuilder: (ctx, idx) => const Divider(),
        );
      });
}


/// Muốn fit content sử dụng child là ListView và shinkWrap = true
Future<T?> openBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? percent,
  bool fullHeight = false,
  bool isDismissible = false,
}) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: fullHeight,
    isDismissible: isDismissible,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      // final padding = MediaQuery.of(context).viewInsets;
      return child;
    },
  );
}

