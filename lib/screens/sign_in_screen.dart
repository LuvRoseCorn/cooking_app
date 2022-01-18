import 'package:flutter/material.dart';
import 'package:fooderlich/components/common_auth_method.dart';
import 'package:fooderlich/components/home.dart';
import 'package:fooderlich/fire_base/fire_base_auth.dart';
import 'package:fooderlich/utils/enum_sign_in_sign_up.dart';
import 'package:fooderlich/utils/reg_email.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();


  final EmailAndPassWordAuth _emailAndPassWordAuth = EmailAndPassWordAuth();

  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: LoaderOverlay(
          useDefaultLoading: _isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: RichText(
                      text: TextSpan(
                        text: 'Cooking',
                        style: Theme.of(context).textTheme.headline3,
                        children: [
                          TextSpan(
                              text: ' App',
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _signInKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        authTextFormField(
                            hintText: 'Email',
                            validator: (inputVal) {
                              if (!emailRegex.hasMatch(inputVal.toString())) {
                                return 'Bạn đã nhập sai email!';
                              }
                              return null;
                            },
                            textEditingController: _email),
                        authTextFormField(
                            hintText: 'Mật khẩu',
                            validator: (inputVal) {
                              if (inputVal!.length < 6) {
                                return 'Mật khẩu phải có ít nhất 6 ký tự';
                              }
                              return null;
                            },
                            textEditingController: _password),
                        logInAuthButton(context: context, buttonName: 'Đăng nhập'),
                        switchToAnotherAuthScreen(
                            context: context,
                            buttonNameFirst: 'Chưa có tài khoản?',
                            buttonNameLast: ' Đăng ký'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logInAuthButton(
      {required BuildContext context, required String buttonName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (_signInKey.currentState!.validate()) {
            print('Validated');

            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }

            context.loaderOverlay.show();

            final EmailSignInResults emailSignInResults =
            await _emailAndPassWordAuth.signInWithEmailAndPassword(
                email: _email.text.trim(), password: _password.text);

            if (emailSignInResults == EmailSignInResults.SignInCompleted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    const Home(),)
              );
            } else if (emailSignInResults ==
                EmailSignInResults.EmailNotVerified) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                  Text('Hãy xác thực tài khoản trước khi tiến hành đăng nhập!')));
            } else if (emailSignInResults ==
                EmailSignInResults.EmailOrPasswordInvalid) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email hoặc mật khẩu sai!')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã xảy ra lỗi!')));
            }

            context.loaderOverlay.hide();

            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          } else {
            print('Errors occurred');
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 60, 30),
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}