import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sf_app/Initial_Pages/home_page.dart';
import 'package:sf_app/Initial_Pages/login_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sf_app/Shared_preference/local_storage_data.dart';
import 'package:sf_app/Shared_preference/storage_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? version;
  @override
  void initState() {
    super.initState();

    _loadPage();
  }

  _loadPage() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
    });
    var period = const Duration(seconds: 3);
    return Timer(period, navigatePage);
  }

  navigatePage() async {
    final isLoggedIn =
        StorageUtils.getString(localStorageData.ISLOGGEDIN) != "";
    final lastloggedOut =
        StorageUtils.getString(localStorageData.LASTLOGGEDINTIME);
    log("Is Login In : $isLoggedIn");
    if (isLoggedIn) {
      if (lastloggedOut != null) {
        final lastLoginDate = DateTime.parse(lastloggedOut);
        final timeDifference = DateTime.now().difference(lastLoginDate);

        // Check if the last login time is within the last 24 hours
        if (timeDifference.inHours <= 24) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
          return;
        }
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/icon/app_logo.jpeg",
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                version ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
