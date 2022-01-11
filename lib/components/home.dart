import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/components/recipe_page/recipe_list.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'package:fooderlich/screens/favorite_screen.dart';
import 'package:fooderlich/screens/setting_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  List<Widget> pages = <Widget> [
    ExploreScreen(),
    const RecipeList(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        currentIndex: _index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Công thức',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
        onTap: (index){
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}

