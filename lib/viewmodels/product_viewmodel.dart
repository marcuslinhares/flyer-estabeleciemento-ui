import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final pb = PocketBase('api.flyer.marcuslinhares.ip-ddns.com');

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final records = await pb.collection('produtos').getFullList(
            sort: '-posicao',
          );

      _products = records
          .map((record) => ProductModel.fromJson(record.toJson()))
          .toList();
    } catch (e) {
      print('Erro ao buscar produtos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> createProduct(ProductModel product) async {
    try {
      await pb.collection('produtos').create(body: product.toJson());
      await fetchProducts(); // Atualiza a lista após cadastro
      return "Produto cadastrado";
    } catch (e) {
      return "Erro ao cadastrar produto: $e";
    }
  }

  Future<String> deleteProduct(String id) async {
    try {
      await pb.collection('produtos').delete(id);
      await fetchProducts(); // Atualiza a lista após exclusão
      return "Produto excluído";
    } catch (e) {
      return "Erro ao excluir produto: $e";
    }
  }
}
