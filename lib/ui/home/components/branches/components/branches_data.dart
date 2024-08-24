import 'package:flutter/material.dart';
import 'package:merchant/components/branch_card.dart';

import '../../../../../data/model/Branch.dart';
import '../../../../../util/size_config.dart';

class BranchesData extends StatelessWidget {
  const BranchesData({Key? key, required this.branches}) : super(key: key);
  final List<Branch> branches;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20))),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                branches.length,
                (index) {
                  return BranchCard(
                      branch: branches[
                          index]); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
