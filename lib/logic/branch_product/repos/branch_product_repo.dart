import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/data/model/Product.dart';

abstract class BranchProductRepo {
  Future<List<Product>> showProducts();
}
