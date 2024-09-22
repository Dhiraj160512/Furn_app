import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sf_app/Initial_Pages/home_page.dart';
import 'package:sf_app/Initial_Pages/registration_page.dart';
import 'package:sf_app/Shared_preference/local_storage_data.dart';
import 'package:sf_app/Shared_preference/storage_utils.dart';
import 'package:sf_app/Utils/common_code.dart';
import 'package:sf_app/bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileFormKey = GlobalKey<FormState>();
  final passFormKey = GlobalKey<FormState>();

  final _mobileConroller = TextEditingController();
  final _passConroller = TextEditingController();

  final mobileFocusNode = FocusNode();
  final passFocusNode = FocusNode();

  bool isShowPass = false;

  @override
  void dispose() {
    super.dispose();
    _mobileConroller.dispose();
    _passConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          //  backgroundColor: Colors.grey[100],
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: 200,
                  width: 250,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/login.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "LOGIN",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Form(
                    key: mobileFormKey,
                    child: TextFormField(
                      controller: _mobileConroller,
                      focusNode: mobileFocusNode,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Mobile Number",
                        hintText: "Enter Mobile Number",
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: passFormKey,
                    child: TextFormField(
                      controller: _passConroller,
                      obscureText: !isShowPass,
                      obscuringCharacter: "*",
                      focusNode: passFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShowPass = !isShowPass;
                            });
                          },
                          icon: isShowPass
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        labelText: "Password",
                        hintText: "Enter Password",
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text("For Registration "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegistrationPage(),
                              ),
                            );
                          },
                          child: const Text("Click Here"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      _clickOnLoginButton();
                    },
                    child: const Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _clickOnLoginButton() async {
    if (_mobileConroller.text.isEmpty) {
      _getCommonDialog("Enter Mobile Number");
    } else if (_passConroller.text.isEmpty) {
      _getCommonDialog("Enter Password");
    } else {
      if (!mobileFormKey.currentState!.validate()) {
        _getCommonDialog("Enter Valid Mobile number");
      } else if (!passFormKey.currentState!.validate()) {
        _getCommonDialog("Enter valid Password");
      } else {
        var success = await globalBloc.loginUser(
            _mobileConroller.text, _passConroller.text);

        if (success.docs.isNotEmpty) {
          log("${success.docs.first["name"]}");
          await StorageUtils.putString(
              localStorageData.NAME, success.docs.first["name"]);
          StorageUtils.putString(
              localStorageData.PHONE, success.docs.first["phone"]);
          StorageUtils.putString(
              localStorageData.EMAIL, success.docs.first["email"]);
          StorageUtils.putString(
              localStorageData.ADDRESS, success.docs.first["address"]);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        } else {
          _getCommonDialog("Something went wrong");
        }
      }
    }
  }

  _getCommonDialog(String msg) {
    CommonCode.commonDialogBuild(
      context,
      msg: msg,
      barrierDismisable: false,
      seconds: 2,
    );
  }
}
