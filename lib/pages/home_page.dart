import 'package:flutter/material.dart';
import 'service/service_dataFactory.dart';
import 'image_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'graphic_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'more_hot_goods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  int _moreGoodsPage;
  List<Map> _moreGoodsDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _moreGoodsPage = 1;
    _moreGoodsDataList = [];

    requestData('post', 'homeHotGoods', {'page':_moreGoodsPage}).then((data){
      var jsonData = json.decode(data.toString());
      List<Map> newMoreGoodsList = (jsonData['data'] as List).cast();
      setState(() {
        _moreGoodsDataList.addAll(newMoreGoodsList);
        _moreGoodsPage++;
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
        appBar:AppBar(title: Text('百姓生活+'),centerTitle: true,),
        body:Container(
          child:FutureBuilder(
              future: requestData('post','homeContent',{'lon':'115.02932','lat':'35.76189'}),
              builder:(BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final jsonData = json.decode(snapshot.data)['data'];
                  List slideData = jsonData['slides'];
                  List categoryData = jsonData['category'];
                  String adImage = jsonData['advertesPicture']['PICTURE_ADDRESS'];
                  String shopImg = jsonData['shopInfo']['leaderImage'];
                  String shoperTel = jsonData['shopInfo']['leaderPhone'];
                  List<Map> hotGoodsList = (jsonData['recommend'] as List).cast();

                  String floor1Header = jsonData['floor1Pic']['PICTURE_ADDRESS'];
                  List<Map> floor1Data = (jsonData['floor1'] as List).cast();

                  String floor2Header = jsonData['floor2Pic']['PICTURE_ADDRESS'];
                  List<Map> floor2Data = (jsonData['floor2'] as List).cast();

                  String floor3Header = jsonData['floor3Pic']['PICTURE_ADDRESS'];
                  List<Map> floor3Data = (jsonData['floor3'] as List).cast();

                  List<String> swiperImgUrl = List();
                  List<Map> grapListData = List();
                  for (int x=0;x<slideData.length;x++) {
                    var item = slideData[x];
                    swiperImgUrl.add(item['image']);
                  }
                  for (int x=0;x<categoryData.length;x++) {
                    var item = categoryData[x];
                    var itemData = {'image':item['image'],'text':item['mallCategoryName']};
                    grapListData.add(itemData);
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ImageSwiper(swiperImgUrl,Size(ScreenUtil().setWidth(750),ScreenUtil().setHeight(333))),
                        GraphicGrid(grapListData,4,10,10,80),
                        AdBanner(adImage, Size(ScreenUtil.screenWidth, ScreenUtil().setHeight(80))),
                        ShopInfoImgV(shopImg, shoperTel),
                        HotGoods(hotGoodsList),
                        floor1Data.length>1?FloorGoodsV(floor1Header, floor1Data):null,
                        floor2Data.length>1?FloorGoodsV(floor2Header, floor2Data):null,
                        floor3Data.length>1?FloorGoodsV(floor3Header, floor3Data):null,
                        MoreGoods('火爆专区', _moreGoodsDataList, 2),
                      ],
                    ),
                  );
                }else {
                  return Center(
                    child: Text('加载中'),
                  );
                }
              },
          ),
        ),
      ),
    );
  }
  
}

class AdBanner extends StatelessWidget {
  String adImage;
  Size adSize;
  AdBanner(this.adImage,this.adSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adSize.width,
      height: adSize.height,
      child:Image.network(adImage,fit:BoxFit.contain),
    );
  }
}

class ShopInfoImgV extends StatelessWidget {
  String shopImg;
  String shoperTelephone;

  ShopInfoImgV(this.shopImg,this.shoperTelephone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _shopClick,
        child: Image.network(shopImg),
      ),
    );
  }

  void _shopClick() async {
    String openUrl = 'tel:'+shoperTelephone;
    if (await canLaunch(openUrl)) {
      await launch(openUrl);
    }else {
      throw Exception('Url不能打开');
    }
  }
}

//商品推荐
class HotGoods extends StatelessWidget {
  List<Map> hotGoodsList;

  HotGoods(this.hotGoodsList);

  Widget _hotHeader() {
    return Container(
      height: ScreenUtil().setHeight(50),
      alignment:Alignment.centerLeft,
      padding:EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration:BoxDecoration(
        color:Colors.white,
        border:Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12),
        ),
      ),
      child:Text('商品推荐',style:TextStyle(color:Colors.pink),),
    );
  }
  
  Widget _hotItem(itemData) {
    return Container(
      width: ScreenUtil().setWidth(750/3),
      height: ScreenUtil().setHeight(280),
      decoration:BoxDecoration(
        color: Colors.white,
        border: Border(
          left:BorderSide(width: 0.5,color: Colors.black12),
        ),
      ),
      child:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          Image.network(itemData['image']),
          Text(itemData['mallPrice'].toString(),style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
          Text(itemData['price'].toString(),style:TextStyle(fontWeight: FontWeight.normal,color: Colors.grey[400],fontSize: 14,decoration:TextDecoration.lineThrough),),
        ],
      ),
    );
  }

  Widget _hotItemList() {
    return Container(
      height:ScreenUtil().setHeight(280),
      child:ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hotGoodsList.length,
          itemBuilder: (context,index) {
            return _hotItem(hotGoodsList[index]);
          },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          _hotHeader(),
          _hotItemList(),
        ],
      )
    );
  }
}


//楼层组件
class FloorGoodsV extends StatefulWidget {
  String floorTitle;
  List<Map> floorData;

  FloorGoodsV(this.floorTitle,this.floorData);

  @override
  _FloorGoodsVState createState() => _FloorGoodsVState();
}

class _FloorGoodsVState extends State<FloorGoodsV> {
  String _title;
  List<Map> _goodsData;

  @override
  void initState() {
    super.initState();

    _title = widget.floorTitle;
    _goodsData = widget.floorData;
  }

  Widget _floorHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding:EdgeInsets.all(8),
      child:Image.network(_title),
    );
  }

  Widget _firstRow() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child:Row(
        children: <Widget>[
          _goodsItem(_goodsData[0]),
          Column(
            children: <Widget>[
              _goodsItem(_goodsData[1]),
              _goodsItem(_goodsData[2]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _otherRow() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          _goodsItem(_goodsData[3]),
          _goodsItem(_goodsData[4]),
        ],
      ),
    );
  }

  Widget _goodsItem(itemData) {
    return Container(
      width: ScreenUtil().setWidth(750/2),
      child: InkWell(
        onTap: () {},
        child: Image.network(itemData['image']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _floorHeader(),
          _firstRow(),
          _otherRow()
        ],
      ),
    );
  }
}





