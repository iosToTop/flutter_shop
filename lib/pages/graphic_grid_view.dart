import 'package:flutter/material.dart';

class GraphicGrid extends StatelessWidget {
  List<Map> itemDataList;
  int itemCount;
  double itemHorPadding;
  double itemVerPadding;
  double itemHeight;

  GraphicGrid(this.itemDataList,this.itemCount,this.itemHorPadding,this.itemVerPadding,this.itemHeight);

  Widget _createItem(itemData,itemWidth) {

    return InkWell(
      onTap: () => print('点击了$itemData'),
      child:Container(
        width: itemWidth,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Image.network(itemData['image'],height:itemHeight-20,width: itemHeight-20,),
            Text(itemData['text']),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double contailerPadding = 10.0;
    var scW = MediaQuery.of(context).size.width;
    var itemWidth = (scW-itemCount*itemHorPadding)/itemCount;

    return Container(
      height: itemHeight+2*contailerPadding,
      color:Colors.white,
      padding:EdgeInsets.fromLTRB(0, contailerPadding, 0, contailerPadding),
      child: GridView.count(
          crossAxisCount: itemCount,
          crossAxisSpacing: itemHorPadding,
          children: itemDataList.map((item) {
            return _createItem(item,itemWidth);
          }).toList(),
      ),
    );
  }
}
