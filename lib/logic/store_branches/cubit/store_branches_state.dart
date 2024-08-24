part of 'store_branches_cubit.dart';

@immutable
sealed class StoreBranchesState {}

final class StoreBranchesInitial extends StoreBranchesState {}
final class StoreBranchesLoading extends StoreBranchesState {}
final class StoreBranchesSuccess extends StoreBranchesState {}
final class StoreBranchesFailure extends StoreBranchesState {}
