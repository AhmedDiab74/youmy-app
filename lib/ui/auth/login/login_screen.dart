import 'package:merchant/ui/auth/login/components/body.dart';
import 'package:flutter/material.dart';

import '../../../util/size_config.dart';

class LoginScreen extends StatelessWidget {
  static var routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(resizeToAvoidBottomInset: false,

      body: Body(),
    );
  }
}
