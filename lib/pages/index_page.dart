import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';
import 'shop_cart.dart';
import 'search_page.dart';
import 'me_page.dart';

class InPage extends StatefulWidget {
  @override
  _InPageState createState() => _InPageState();
}

class _InPageState extends State<InPage> {
  List<BottomNavigationBarItem> myBottom = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      title: Text('会员中心'),
    ),
  ];

  List<Widget> myTabPages = [
    HomePage(),
    SearchPage(),
    ShopCartPage(),
    MePage(),
  ];

  int _currentBottomIndex;

  @override
  void initState() {
    _currentBottomIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width:750,height:1334)..init(context);

    return Scaffold(
      backgroundColor:Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar:BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          backgroundColor:Colors.orangeAccent,
          currentIndex:_currentBottomIndex,
          items:myBottom,
          onTap:(index) {
            setState(() {
              _currentBottomIndex = index;
            });
          },
      ),
      body:Container(
        child:IndexedStack(
          index:_currentBottomIndex,
          children:myTabPages,
        ),
      ),
    );
  }
}
