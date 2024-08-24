import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant/logic/branch_product/cubit/product_cubit.dart';
import 'package:merchant/logic/branch_product/repos/branch_product_repo_imp.dart';
import 'package:merchant/logic/store_branches/cubit/store_branches_cubit.dart';
import 'package:merchant/logic/store_branches/repos/store_branches_repo_imp.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/util/api_services.dart';
import 'package:merchant/util/routes.dart';
import 'util/theme.dart';

Future<void> main() async {
  ApiService apiService = ApiService(Dio());
  // var x = await apiService.post(endPoint: "v1/companies/loginsearch", data: {});
  var x = await apiService.post(
      endPoint: "v1/branches/searchData",
      data: {
        "search": {"companyCode": 1, "LangId": 1},
      },
      authToken:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVlYTQzZjIyLTI5MzktNDc4YS04OTcxLWFhM2U2ZWVlYmFhZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQHJvb3QuY29tIiwiZnVsbE5hbWUiOiJyb290IEFkbWluIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InJvb3QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zdXJuYW1lIjoiQWRtaW4iLCJpcEFkZHJlc3MiOiI0MS4yMzkuMTMxLjE4MyIsInRlbmFudCI6InJvb3QiLCJpbWFnZV91cmwiOiIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IiIsImV4cCI6MTcyNDcwMzU2NH0.44gsIR65MKahwFLPBlYNwsTkvPKZXpyH2vZClJCkOs8");
  // var x = await apiService.post(endPoint: "tokens", data: {"userNameOrEmail": "admin", "password": "123Pa\$\$word!"},headers: {
  //   "Tenant":"root"
  // });
  log('==================$x=============');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              StoreBranchesCubit(StoreBranchesRepoImp(apiService))
                ..showBranches(),
        ),
        BlocProvider(
          create: (context) =>
              ProductCubit(BranchProductRepoImp(apiService))..showProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yomy Merchant',
        theme: theme(),
        initialRoute: LoginScreen.routeName,
        routes: routes,
      ),
    );
  }
}
