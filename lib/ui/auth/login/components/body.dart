import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant/components/form_error.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/ui/auth/signup/signup_screen.dart';
import 'package:merchant/util/api_services.dart';
import 'package:merchant/util/extensions.dart';
import 'package:merchant/util/keyboard.dart';
import '../../../../components/colored_custom_text.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../util/Constants.dart';
import '../../../../util/size_config.dart';
import '../../../home/home_screen.dart';
import '../../forget_password/forget_password_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables
  final String TAG = "LOG IN: ";
  final _formKey = GlobalKey<FormState>();
  String? username, password;
  List<String?> errors = [];

  //endregion

  //region helper functions
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      onPressed: (value) {
        password = value;
      },
      onChange: (value) {
        password = value;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      hintText: 'Password',
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      suffixIcon: const Icon(Icons.visibility_off),
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      textInputType: TextInputType.emailAddress,
      hintText: 'Email/Phone No',
      onPressed: (value) {
        username = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (value.toString().isValidEmail()) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        username = value;
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
    );
  }

  //endregion

  //region events
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 222,
                  decoration: const BoxDecoration(
                    color: KOpacityPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/trans.png',
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 40),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const CustomText(
                    text: 'Welcome to Yomy - Merchant,',
                    fontSize: 25,
                    fontColor: KPrimaryColor,
                    fontFamily: 'Roboto Italic',
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  buildEmailField(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  buildPasswordField(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ForgetPasswordScreen.routeName),
                    child: const CustomText(
                      text: 'Forget Password?',
                      fontFamily: 'Roboto Bold',
                      fontSize: 16,
                      fontColor: KPrimaryColor,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(60)),
                  CustomButton(
                    text: "Login",
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        KeyboardUtil.hideKeyboard(context);

                        try {
                          var response = await apiService.post(
                            endPoint: "tokens",
                            data: {
                              "userNameOrEmail": username,
                              "password": password,
                            },
                            headers: {"Tenant": "root"},
                          );

                          // if (response.statusCode == 200) {
                            print(
                                '================${response.data['isHasPermission']}========');
                            // if (response.data['isHasPermission']) {
                            Navigator.popAndPushNamed(
                                context, HomeScreen.routeName);
                            // } else {
                            //   // Handle error response
                            //   addError(error: "You don't have permission");
                            // }
                          // } else {
                            // Handle error response
                            // addError(error: "Login failed. Please try again.");
                          // }
                        } catch (e) {
                          addError(
                              error: "An error occurred. Please try again.");
                        }
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              child: const CustomRichText(
                align: Alignment.center,
                text1: 'Don\'t have an account?',
                text2: ' SignUp',
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
          ],
        ),
      ),
    );
  }
  //endregion
}
