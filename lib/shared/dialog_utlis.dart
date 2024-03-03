import 'package:flutter/material.dart';

class dialogUtils {
  static void show_loaing_dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 7),
                  Text("loading"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide_loaing_dialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? positiveText,
    String? negativeText,
    void Function()? positiveButton,
    void Function()? negativeButton,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (positiveText != null)
                        TextButton(
                            onPressed: positiveButton,
                            child: Text(positiveText)),
                      if (negativeText != null)
                        TextButton(
                            onPressed: positiveButton,
                            child: Text(negativeText)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
