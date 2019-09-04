import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreGoods extends StatefulWidget {
  String title;
  List<Map> goodsDataList;
  int rowCount;
  
  MoreGoods(this.title,this.goodsDataList,this.rowCount);
  
  @override
  _MoreGoodsState createState() => _MoreGoodsState();
}

class _MoreGoodsState extends State<MoreGoods> {
  
  String _title;
  List<Map> _goodsDataList;
  int _rowCount;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _title = widget.title;
    _goodsDataList = widget.goodsDataList;
    _rowCount = widget.rowCount;
  }
  
  Widget _goodsHeader() {
    return Container(
      height: 38,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(_title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
    );
  }
  
  Widget _wrapGoods() {
    if (_goodsDataList.length > 0) {
      List<Widget> _goodsItemList = _goodsDataList.map((itemData) {
        return Container(
          width: ScreenUtil().setWidth((750-(_rowCount+1)*3)/_rowCount),
          padding: EdgeInsets.all(3.0),
          margin: EdgeInsets.only(bottom:3.0),
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(itemData['image']),
                Text(
                  itemData['name'],
                  style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),
                  textAlign:TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(itemData['mallPrice'].toString(),style: TextStyle(fontSize: 14,),),
                    Text(itemData['price'].toString(),style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: _rowCount.toDouble(),
        children: _goodsItemList,
      );
    }else {
      return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _goodsHeader(),
          _wrapGoods(),
        ],
      ),
    );
  }
}
