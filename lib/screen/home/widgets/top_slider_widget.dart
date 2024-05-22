import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class TopSliderWidget extends StatelessWidget {
  const TopSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xffbdbdbd),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            Assets.images.rectangle6537Bg.path,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const Text(
              'Quốc hội sẽ phê chuẩn miễn nhiệm chức Bộ trưởng Công an với đại tướng Tô Lâm',
              style: TextStyle(

                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: Color(0xffffffff),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Text(
                //   'By Nakamura',
                //   style: TextStyle(

                //     fontSize: 12,
                //     fontWeight: FontWeight.w400,
                //     height: 1.4,
                //     color: Color(0xffffffff),
                //   ),
                // ),
                Image.asset(
                  Assets.images.slider.path,
                  width: 48,
                  height: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}