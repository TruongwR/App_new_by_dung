import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/spacer/spacer_custom.dart';

class CardViewWidget extends StatelessWidget {
  const CardViewWidget({
    super.key, required this.image, required this.name, required this.author, this.onTap,
  });

  final String image;
  final String name;
  final String author;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xffbdbdbd),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
            ),

            const CustomWidthSpacer(size: 0.03,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    name,
                    style: const TextStyle (

                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: Color(0xff1a434e),
                    ),
                  ),
                  const CustomHeightSpacer(size: 0.005,),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle (

                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        color: Color(0xff95a6aa),
                      ),
                      children: [
                        const TextSpan(
                          text: 'By ',
                        ),
                        TextSpan(
                          text: author,
                          style: const TextStyle (

                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            color: Color(0xff1a434e),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],),
            )
          ],
        ),
      ),
    );
  }
}


class CardViewWidget2 extends StatelessWidget {
  const CardViewWidget2({
    super.key, required this.image, required this.name, required this.author, this.onTap,
  });

  final Uint8List image;
  final String name;
  final String author;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xffbdbdbd),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(image),
                ),
              ),
            ),

            const CustomWidthSpacer(size: 0.03,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    name,
                    style: const TextStyle (

                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      // height: 1.3,
                      height: 1.8,
                      color: Color(0xff1a434e),
                    ),
                  ),
                  const CustomHeightSpacer(size: 0.005,),

                  RichText(
                    text: const TextSpan(
                      style: TextStyle (

                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        color: Color(0xff95a6aa),
                      ),
                      children: [
                        // const TextSpan(
                        //   text: 'By ',
                        // ),
                        // TextSpan(
                        //   text: author,
                        //   style: const TextStyle (

                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w400,
                        //     height: 1.4,
                        //     color: Color(0xff1a434e),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                ],),
            )
          ],
        ),
      ),
    );
  }
}