import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ImageSwiper extends StatelessWidget {
  List<String> imgUrlList;
  Size swiperSize;
  ImageSwiper(this.imgUrlList,this.swiperSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: swiperSize.width,
      height: swiperSize.height,
      child: Swiper(
          itemCount: imgUrlList.length,
          itemBuilder:(context,index) {
            return Image.network(imgUrlList[index],fit:BoxFit.cover);
          },
          autoplay:imgUrlList.length>1?true:false,
          pagination:imgUrlList.length>1?SwiperPagination():null,
      ),
    );
  }
}
