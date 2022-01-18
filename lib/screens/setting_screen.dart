import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/fire_base/fire_base_auth.dart';
import 'package:fooderlich/screens/sign_in_screen.dart';
import 'package:fooderlich/state_management/theme_management.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EmailAndPassWordAuth _emailAndPassWordAuth = EmailAndPassWordAuth();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Xin chào : ',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  _firebaseAuth.currentUser!.email.toString(),
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
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
            const Text('''Sản phẩm demo project I qua quá trình tìm hiểu về Flutter,
      - Ứng dụng giúp các bạn nấu ăn ngon hơn !!! 
      - Đặc biệt còn giúp mọi người yêu thích nấu ăn hơn !!!
      - Hãy nấu ăn ngay cho người thân của mình đi nào !!
              ''',
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
            ElevatedButton(
              onPressed: () async {
                await _emailAndPassWordAuth.logOut();
                //savedBooksProvider.resetList();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    const SignInScreen(),)
                );
              },
              child: Text('Đăng xuất'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 20),
                primary: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
