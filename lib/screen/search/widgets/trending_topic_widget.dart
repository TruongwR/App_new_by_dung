import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class TrendingTopicWidget extends StatelessWidget {
  const TrendingTopicWidget({
    super.key, required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(

                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: Color(0xff1a434e),
              ),
            ),
            const Text(
              // articlesnx8 (4:190)
              '1204 articles',
              style: TextStyle(

                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.8,
                color: Color(0xff95a6aa),
              ),
            ),
          ],
        ),


        Image.asset(
          Assets.icons.icVuesaxLinearSend.path,
          width: 20,
          height: 20,
        ),
      ],
    );
  }
}