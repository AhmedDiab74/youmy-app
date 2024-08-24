import 'package:merchant/data/model/Branch.dart';
import 'package:merchant/data/model/Product.dart';
import 'package:merchant/logic/branch_product/repos/branch_product_repo.dart';

import 'package:merchant/logic/store_branches/repos/store_branches_repo.dart';
import 'package:merchant/util/api_services.dart';

class BranchProductRepoImp implements BranchProductRepo {
  final ApiService apiService;

  BranchProductRepoImp(this.apiService);

  @override
  Future<List<Product>> showProducts() async {
    var response = await apiService.post(
      endPoint: "v1/items/searchProductStock",
      data: {
        "search": {"companyCode": 1, "branchCode": 1, "LangId": 1},
      },
      authToken:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVlYTQzZjIyLTI5MzktNDc4YS04OTcxLWFhM2U2ZWVlYmFhZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQHJvb3QuY29tIiwiZnVsbE5hbWUiOiJyb290IEFkbWluIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InJvb3QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zdXJuYW1lIjoiQWRtaW4iLCJpcEFkZHJlc3MiOiI0MS4yMzkuMTMxLjE4MyIsInRlbmFudCI6InJvb3QiLCJpbWFnZV91cmwiOiIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IiIsImV4cCI6MTcyNDcwMzU2NH0.44gsIR65MKahwFLPBlYNwsTkvPKZXpyH2vZClJCkOs8",
    );

    // Initialize an empty list
    List<Product> product = [];

    if (response.statusCode == 200 && response.data != null) {
      var dataList = response.data["data"] as List<dynamic>;

      // Convert each element in the data list to a StoreBranchModel instance
      product = dataList.map((item) {
        return Product.fromMap(item as Map<String, dynamic>);
      }).toList();
    } else {
      // Handle error or empty response
      print('Error: ${response.statusCode}');
    }

    return product;
  }
}
