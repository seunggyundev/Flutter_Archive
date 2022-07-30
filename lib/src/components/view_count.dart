import 'package:archive/src/provider/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCountWidget extends StatelessWidget {
  const ViewCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build');
    return Center(
      //provider에 접근해서 데이터를 받아와야하는 상위 위젯에서 Consumer로 묶음, 묶어야 매번 새로 빌드메서드가 실행되지 않는다
      child: Consumer<CountProvider>(
        builder: (context, provider, child) {
          return Text(provider.count.toString(), style: TextStyle(fontSize: 80),);
        },
      ),
    );
  }
}
