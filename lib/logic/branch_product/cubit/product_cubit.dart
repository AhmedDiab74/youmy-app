import 'package:bloc/bloc.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/logic/branch_product/repos/branch_product_repo.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.branchProductRepo) : super(ProductInitial());
    final BranchProductRepo branchProductRepo;
  List<Product> products = [];
  Future<void> showProducts() async {
    emit(ProductLoading());
    try {
      var result = await branchProductRepo.showProducts();
      products.addAll(result);
      print(products[0].title);
      emit(ProductSuccess());
    } catch (e) {
      print(e.toString());
      emit(ProductFailure());
    }
  }
}
