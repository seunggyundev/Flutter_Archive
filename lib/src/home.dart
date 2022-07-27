import 'package:archive/src/provider/count_provider.dart';
import 'package:archive/src/ui/count_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  CountProvider? _countProvider;

  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context); //provider 불러오기
    return Scaffold(
      appBar: AppBar(
        title: Text('provider sample'),
      ),
      body: CountHomeWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: () {
            _countProvider?.add();
          }, icon: Icon(Icons.add)),
          IconButton(onPressed: () {
            _countProvider?.remove();
          }, icon: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
