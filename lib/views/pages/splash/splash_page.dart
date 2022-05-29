import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: () {
              Get.toNamed(Routes.LOGIN_IN_PAGE);
            },
            child: Text(
              'To page 2',
              style: TextStyle(color: Colors.white, fontSize: 30),
            )),
      ),
    );
  }
}
