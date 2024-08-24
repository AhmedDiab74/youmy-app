// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:merchant/data/model/Branch.dart';

import 'package:merchant/logic/store_branches/repos/store_branches_repo.dart';
import 'package:meta/meta.dart';

part 'store_branches_state.dart';

class StoreBranchesCubit extends Cubit<StoreBranchesState> {
  StoreBranchesCubit(this.storeBranchRepo) : super(StoreBranchesInitial());
  final StoreBranchesRepo storeBranchRepo;
  List<Branch> branches = [];
  Future<void> showBranches() async {
    emit(StoreBranchesLoading());
    try {
      var result = await storeBranchRepo.showBranches();
      branches.addAll(result);
      print(branches[0].name);
      emit(StoreBranchesSuccess());
    } catch (e) {
      print(e.toString());
      emit(StoreBranchesFailure());
    }
  }
}
