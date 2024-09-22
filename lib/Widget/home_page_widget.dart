import 'package:flutter/material.dart';
import 'package:sf_app/Shared_preference/local_storage_data.dart';
import 'package:sf_app/Shared_preference/storage_utils.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 35,
            child: Image.asset(
              "assets/images/person.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StorageUtils.getString(localStorageData.NAME),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              Text(
                StorageUtils.getString(localStorageData.ADDRESS),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
