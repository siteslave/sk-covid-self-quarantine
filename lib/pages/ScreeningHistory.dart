import 'package:covid_self_quarantine/Utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../Api.dart';

class ScreeningHistory extends StatefulWidget {
  @override
  _ScreeningHistoryState createState() => _ScreeningHistoryState();
}

class _ScreeningHistoryState extends State<ScreeningHistory> {
  Api api = Api();
  Utils utils = Utils();
  
  final storage = new FlutterSecureStorage();
  List items = [];
  List tempLists = [];

  String temp = '';

  TextEditingController ctrlQuery = TextEditingController();

  Future getScreening(String query) async {
    try {
      String token = await storage.read(key: "token");
      Response rs = await api.getScreening(token, query);

      if (rs.statusCode == 200) {
        setState(() {
          items = rs.data;
        });
      } else {
        print('HTTP Error');
      }
    } catch (error) {
      print(error);
    }
  }

  Future getTempList() async {
    try {
      String token = await storage.read(key: "token");
      Response rs = await api.getTempList(token);

      if (rs.statusCode == 200) {
        setState(() {
          tempLists = rs.data;
        });
      } else {
        print('HTTP Error');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getScreening('');
    getTempList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text(
          'ประวัติการคัดกรอง',
          style: TextStyle(color: Colors.white),
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: ctrlQuery,
                  onFieldSubmitted: (value) {
                    getScreening(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[100],
                    labelText: 'ค้นหา....',
                    suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {
                      String _query = ctrlQuery.text ?? '';
                      getScreening(_query);
                    },)
                  ),
                ),
                DropDownFormField(
                  titleText: 'อุณหภูมิ',
                  hintText: 'เลือกอุณหภูิม',
                  value: temp,
                  onChanged: (value) {
                    getScreening(value.toString());
                  },
                  dataSource: tempLists,
                  textField: 'display',
                  valueField: 'value',
                ),
                Divider(),
                Text(
                  'ประวัติการคัดกรอง',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                var item = items[index];
                DateTime date = DateTime.parse(item['serve_date']);
                
                return ListTile(
                  title:
                      Text('${utils.toThaiDate(date)} เวลา ${item['serve_time']}'),
                  leading: CircleAvatar(
                    child: Text(
                      '${item['temp']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor:
                        item['temp'] >= 37.5 ? Colors.red : Colors.green,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('มีไข้'),
                          Text(
                            '${item['fever'] == 'Y' ? 'ใช่' : 'ไม่'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ไอ'),
                          item['cough'] == 'Y'
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('หอบ เหนื่อย'),
                          Text(
                            '${item['tiredness'] == 'Y' ? 'ใช่' : 'ไม่'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: items.length,
            ),
          )
        ],
      ),
    );
  }
}
