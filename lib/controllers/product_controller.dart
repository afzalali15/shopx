import 'package:get/state_manager.dart';
import 'package:shopx_updated/models/product.dart';
import 'package:shopx_updated/services/remote_services.dart';


class ProductController extends GetxController {
  var isLoading = true.obs;
  RxList<Product> productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.assignAll(products);
      }
    } finally {
      isLoading(false);
    }
  }
}
