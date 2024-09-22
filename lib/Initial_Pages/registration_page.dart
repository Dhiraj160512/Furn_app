import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sf_app/Mixin/validate_mixin.dart';
import 'package:sf_app/Utils/common_code.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with ValidateMixin {
  final _nameFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailConroller = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _addressController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  final confirmPassFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  bool checkInternet = false;

  _clickOnSubmitButton() async {
    if (_nameController.text.isEmpty) {
      _getCommonDialog("Name is compulsary");
    } else if (_passController.text.isEmpty) {
      _getCommonDialog("Mobile is Compulsary");
    } else if (_emailConroller.text.isEmpty) {
      _getCommonDialog("Email is Compulsary");
    } else if (_passController.text.isEmpty) {
      _getCommonDialog("Fill Password");
    } else if (_addressController.text.isEmpty) {
      _getCommonDialog("Fill Password");
    } else {
      if (!_nameFormKey.currentState!.validate()) {
        _getCommonDialog('Enter Valid Name');
      } else if (!_phoneFormKey.currentState!.validate()) {
        _getCommonDialog("Enter Valid Mobile Number");
      } else if (!_emailFormKey.currentState!.validate()) {
        _getCommonDialog("Enter valid Email");
      } else if (!_passFormKey.currentState!.validate()) {
        _getCommonDialog("Enter valid Password");
      } else if (!_addressFormKey.currentState!.validate()) {
        _getCommonDialog("Enter valid Password");
      } else {
        addUser(
          name: _nameController.text,
          phone: _phoneController.text,
          email: _emailConroller.text,
          password: _passController.text,
          address: _addressController.text,
        );
      }
    }
  }

  Future<void> addUser(
      {String? uid,
      String? name,
      String? phone,
      String? email,
      String? password,
      String? address}) async {
    try {
      EasyLoading.show(dismissOnTap: false);
      var res =
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        "address": address
      });
      log("Upload Successfully");
      EasyLoading.dismiss();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
          return AlertDialog(
            title: const Text(
              "Congratulation",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Your are Successfully Register",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          );
        },
      );
    } catch (e) {
      log("Error Occur in Upload : $e");
      throw "Something went wrong $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text("Registration"),
          // ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCEL"),
              ),
              ElevatedButton(
                onPressed: (_confirmPassController.text != _passController.text)
                    ? null
                    : (_confirmPassController.text.isEmpty)
                        ? null
                        : () {
                            _clickOnSubmitButton();
                          },
                child: const Text("SUBMIT"),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Registration From",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Enter Name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      Form(
                        key: _nameFormKey,
                        child: TextFormField(
                          controller: _nameController,
                          focusNode: nameFocusNode,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Enter Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: nameValidator,
                          onChanged: (value) {
                            _nameFormKey.currentState!.validate();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Enter Mobile Number",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      Form(
                        key: _phoneFormKey,
                        child: TextFormField(
                          controller: _phoneController,
                          focusNode: phoneFocusNode,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Enter Mobile number",
                            border: OutlineInputBorder(),
                          ),
                          validator: phoneValidator,
                          onChanged: (value) {
                            _phoneFormKey.currentState!.validate();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Enter Email ID",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      Form(
                        key: _emailFormKey,
                        child: TextFormField(
                          controller: _emailConroller,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Enter Email",
                            border: OutlineInputBorder(),
                          ),
                          validator: emailValidator,
                          onChanged: (value) {
                            _emailFormKey.currentState!.validate();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _passFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Enter Password",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        TextFormField(
                          controller: _passController,
                          focusNode: passFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Enter Password",
                            border: OutlineInputBorder(),
                          ),
                          validator: passwordValidator,
                          onChanged: (value) {
                            _passFormKey.currentState!.validate();
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Confirm Password",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _confirmPassController,
                          focusNode: confirmPassFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (_confirmPassController.text !=
                                _passController.text) {
                              return "Password not Match";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _passFormKey.currentState!.validate();
                            setState(() {});
                          },
                        ),

                        // Form(
                        //   key: ,
                        //   child:  ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Enter Address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      Form(
                        key: _addressFormKey,
                        child: TextFormField(
                          controller: _addressController,
                          focusNode: addressFocusNode,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Enter address",
                            border: OutlineInputBorder(),
                          ),
                          validator: emailValidator,
                          onChanged: (value) {
                            _addressFormKey.currentState!.validate();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getCommonDialog(String msg) {
    CommonCode.commonDialogBuild(
      context,
      msg: msg,
      barrierDismisable: false,
      seconds: 3,
    );
  }
}
