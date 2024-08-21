import 'package:expense_tracker/src/modal_bsheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _data = [];
  double total = 0;

  Icon iconsAra(int index) {
    if (_data[index]['category'] == 'Shopping') {
      return Icon(
        Icons.shopping_cart_rounded,
        color: Colors.purple,
      );
    } else if (_data[index]['category'] == 'Travel') {
      return Icon(
        Icons.luggage,
        color: Colors.grey,
      );
    } else if (_data[index]['category'] == 'Grocery') {
      return Icon(
        Icons.shopping_basket,
        color: Colors.green,
      );
    } else if (_data[index]['category'] == 'Entertainment') {
      return Icon(
        Icons.videogame_asset,
        color: Colors.blueAccent,
      );
    } else
      return Icon(
        Icons.more_horiz,
        color: Colors.black,
      );
  }

  void deleteExp(int index) {
    setState(() {
      var removedData = _data.removeAt(index);

      total -= removedData['amount'];
    });
  }

  void totalExp(double t) {
    total += t;
    print(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.only(top: 55, bottom: 30),
              height: 200,
              width: 200,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      total.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Spacer(),
                    Text('Total Expense',
                        style:
                            TextStyle(color: Colors.yellowAccent, fontSize: 15))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.blueAccent, width: 10),
              ),
            ),


            
            ElevatedButton(
              onPressed: () async {
                final result =
                    await showModalBottomSheet<List<Map<String, dynamic>>>(
                  context: context,
                  builder: (context) => ModalBsheet(
                    data: _data,
                    getTotal: totalExp,
                  ),
                );
                if (result != null) {
                  setState(() {
                    _data = result;

                      });
                  print(_data);
                }
              },
              child: Text('Add Expense'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.lightGreen.shade400),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Text(
                        'Expense Overview',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 65,
                                width: 350,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black38)),
                                ),
                                child: Row(
                                  children: [
                                    iconsAra(index),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _data[index]['category'].toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.currency_rupee_rounded,
                                    ),
                                    Text(
                                      _data[index]['amount'].toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteExp(index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
