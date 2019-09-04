import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _editingController = TextEditingController();
  String _showText = '美好人间欢迎您';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
        appBar:AppBar(title: Text('美好人间'),),
        body:Container(
          child:Column(
            children: <Widget>[
              TextField(
                scrollPadding:EdgeInsets.all(10),
                controller:_editingController,
                decoration:InputDecoration(
                  helperText:'选择小姐姐类型',
                  labelText:'美好人间',
                  contentPadding:EdgeInsets.all(20),
                ),
                autofocus:false,
              ),
              IconButton(
                icon:Icon(Icons.record_voice_over),
                onPressed:() {
                    _finishChoose();
                },
              ),
              Text(
                _showText,
                overflow:TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _finishChoose() {
    var girlType = _editingController.text.toString();
    print(girlType);
    if (girlType == '') {
      showDialog(
          context:context,
          builder:(context) {
            return AlertDialog(
              title:Text('美女类型不能为空'),
            );
          }
      );
    }else {
      getMM(girlType).then((data){
        setState(() {
          _showText = data['data']['name'];
        });
      });
    }
  }

  Future getMM(String girlType) async {
    try {
      Response rsp;
      var params = {'name':girlType};
      rsp = await Dio().post(
        'https://easy-mock.com/mock/5d6de4c0d8dee02e96bb3243/flutterShop/serviceForYou',
        queryParameters:params
      );
      return rsp.data;
    } catch(err) {
      return err;
    }
  }
}
