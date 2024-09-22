import 'dart:developer';

import 'package:sf_app/Shared_preference/local_storage_data.dart';
import 'package:sf_app/Shared_preference/storage_utils.dart';

class SessionManager {
  Future<void> updateLastLoggedTimeAndStatus() async {
    final currentTime = DateTime.now();
    await StorageUtils.putString(localStorageData.ISLOGGEDIN, "TRUE");
    await StorageUtils.putString(
        localStorageData.LASTLOGGEDINTIME, currentTime.toIso8601String());

    var loginStatus = StorageUtils.getString(localStorageData.ISLOGGEDIN);
    var loggedTime = StorageUtils.getString(localStorageData.LASTLOGGEDINTIME);

    log('islogged: $loginStatus --- loggedONTIME: $loggedTime');
  }

  Future<void> logout() async {
    await StorageUtils.remove(localStorageData.ISLOGGEDIN);
    await StorageUtils.remove(localStorageData.LASTLOGGEDINTIME);
  }

  void updateLoggedInTimeAndLoggedStatus() {}
}

SessionManager sessionManager = SessionManager();
