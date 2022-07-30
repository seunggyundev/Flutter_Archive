import 'package:archive/src/provider/bottom_navigation_provider.dart';
import 'package:archive/src/provider/count_provider.dart';
import 'package:archive/src/ui/count_home_widget.dart';
import 'package:archive/src/ui/movie_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  CountProvider? _countProvider;
  BottomNavigationProvider? _bottomNavigationProvider;

  Widget _navigationBody() {
    switch (_bottomNavigationProvider!.currentPage) {
      case 0:
        return CountHomeWidget();
      case 1:
        return MovieListWidget();
    }
    return Container();
  }

  Widget _bottomNavigationBarWidget() {
    return Consumer<BottomNavigationProvider> (
      builder: (context, provider, widget) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "movie"),
          ],
          currentIndex: _bottomNavigationProvider!.currentPage,
          selectedItemColor: Colors.redAccent,
          onTap: (index) {
            _bottomNavigationProvider?.updateCurrentPage(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context, listen: false); //provider 불러오기, listen: false해야 매번 새로 빌드메서드가 실행이 안됨(CountHomeWidget의 컨슈머도 해야)
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context, listen: true);
    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  // Consumer<Provider>, <>안의 provider가 변경될 때만 업데이트를 하겠다, 이렇게 하면 listen: false로 둬도 업데이트 가능
  // 만약 provider의 업데이트를 전부 반영해서 사용해야 한다면 굳이 Consumer를 쓰지않고 listen: true로 하는게 효율적
}

/*
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
 */
