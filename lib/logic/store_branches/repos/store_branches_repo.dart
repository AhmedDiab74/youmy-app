import 'package:merchant/data/model/Branch.dart';

abstract class StoreBranchesRepo {
  Future<List<Branch>> showBranches();
}
