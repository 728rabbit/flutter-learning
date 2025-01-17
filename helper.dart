import 'package:flutter/material.dart';

double setFontSize(BuildContext context, double fontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  double baseWidth = 500;
  return screenWidth * (fontSize / baseWidth);
}

extension DialogExtensions on BuildContext {
  void showAlertDialog({
    required String message,
    String okText = 'OK',
    VoidCallback? onOkPressed,
  }) {
    showDialog(
      context: this,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 480,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border(
              top: BorderSide(color: Colors.blue, width: 4),
            ),
          ),
          padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: setFontSize(context, 20), fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text(okText, style: TextStyle(fontSize: setFontSize(context, 16), fontWeight: FontWeight.bold, color: Colors.black)),
                    onPressed: () {
                      Navigator.pop(context);
                      if(onOkPressed != null) {
                        onOkPressed();
                      }
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension SnackBarExtension on BuildContext {
  void showTipsgBar({
    required String message,
    VoidCallback? onClosePressed,
  }) {
    if (onClosePressed != null) {
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(days: 1),
        action: SnackBarAction(
          label: 'x',
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
            onClosePressed();
          },
        ),
      ));
    }
    else {
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(message)
      ));
    }
  }
}
