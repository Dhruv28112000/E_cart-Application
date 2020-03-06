import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';


class Providerlaptop with ChangeNotifier {
  List<Product> _items = [
     Product(
       id: 'p51',
       title: 'Lenovo Ideapad',
       description: 'i5 10th gen with NVEDIA',
       price: 35000,
       imageUrl:
           'https://cdn.pixabay.com/photo/2014/05/02/21/49/home-office-336373__340.jpg',
     ),
    
     Product(
       id: 'p52',
       title: 'Lenovo Ligion',
       description: 'i7 10th ',
       price: 50000,
       imageUrl:
           'https://assetscdn1.paytm.com/images/catalog/product/L/LA/LAPDELL-INSPIROBEST101858425903F96/1562414417098_0.jpg',
     ),
     Product(
       id: 'p53',
       title: 'MSI',
       description: 'i7 10th',
       price: 75000,
       imageUrl:
           'https://assetscdn1.paytm.com/images/catalog/product/L/LA/LAPMSI-GAMING-GKIDA31583776D5093/1581682926708_2..jpg',
     ),
     Product(
       id: 'p54',
       title: 'Apple mac book',
       description: 'Apple mac book pro',
       price: 49.99,
       imageUrl:
           'https://assetscdn1.paytm.com/images/catalog/product/L/LA/LAPMICROSOFT-SUSUPE46222FD00F68C/1562415166801_0..jpg',
     ),
  ];
   var _showFavoritesOnly = false;

  List<Product> get items {
     if (_showFavoritesOnly) {
       return _items.where((prodItem) => prodItem.isFavorite).toList();
     }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://eshop-38e41.firebaseio.com/laptops.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://eshop-38e41.firebaseio.com/laptops.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://eshop-38e41.firebaseio.com/laptops/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://eshop-38e41.firebaseio.com/laptops/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
