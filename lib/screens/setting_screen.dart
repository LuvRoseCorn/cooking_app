import 'package:flutter/material.dart';
import 'package:fooderlich/state_management/theme_management.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chế độ tối :',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Switch(
                  value: Provider.of<ThemeManagement>(context, listen: false).darkMode,
                  onChanged: (value) {
                    Provider.of<ThemeManagement>(context, listen: false).darkMode = value;
                  },
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Thông tin về ứng dụng :',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 8),
            const Text(
              'Ứng dụng giúp các bạn nấu ăn ngon hơn !!!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16,),
            Expanded(
              child: Center(
                child: FittedBox(
                  child: Image.asset('assets/illus_pics/cooking.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
