import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class Image_showPage extends StatelessWidget {
  Image_showPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = Get.arguments;
    return Hero(tag: "image_show", child: Swiper(
        pagination: SwiperPagination(),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Image.network(list[index],fit: BoxFit.contain,),
          onTap: (){Get.back();},
        );
      },
      itemCount: list.length,
      viewportFraction: 0.99,
      scale: 0.99,
      autoplay: true,
    ));
  }


}
