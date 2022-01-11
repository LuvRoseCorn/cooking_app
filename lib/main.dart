import 'package:flutter/material.dart';
import 'package:fooderlich/components/home.dart';
import 'package:fooderlich/app_theme.dart';
import 'package:fooderlich/state_management/favorite_management.dart';
import 'package:fooderlich/state_management/theme_management.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteManagement(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeManagement(),
        )
      ],
      child: Consumer<ThemeManagement>(builder: (context, themeManager, child) {
        ThemeData theme;
        if (themeManager.darkMode) {
          theme = CookingAppTheme.dark();
        } else {
          theme = CookingAppTheme.light();
        }
        return MaterialApp(
          theme: theme,
          title: 'Nấu ăn cùng nhau',
          home: const Home(),
        );
        }
      ),
    );
  }
}

