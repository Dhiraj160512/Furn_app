import 'package:flutter/material.dart';

class CommonCode {
  static commonDialogBuild(
    BuildContext context, {
    required String msg,
    required bool barrierDismisable,
    required int seconds,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: seconds), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          content: SizedBox(
            child: Text(
              msg,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
