import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';


class Providermobile with ChangeNotifier {
  List<Product> _items = [
     Product(
       id: 'p20',
       title: 'Honor 9i',
       description: 'BoAt BASSHEAD On-Ear Wired Headphone',
       price: 2500,
       imageUrl:
           'https://cdn.pixabay.com/photo/2016/11/29/09/08/headphone-1868612__340.jpg',
     ),
    
     Product(
       id: 'p21',
       title: 'Wired Headphone',
       description: 'awdadakldalkDjldjlad',
       price: 500,
       imageUrl:
           'https://cdn.pixabay.com/photo/2014/07/31/23/38/headphones-407190__340.jpg',
     ),
     Product(
       id: 'p22',
       title: 'JBL Bluetooh Speaker',
       description: '',
       price: 500,
       imageUrl:
           'https://assetscdn1.paytm.com/images/catalog/product/C/CO/COMJBL-PORTABLEKORA1127039CCBBD42F/1579781964750_0.jpg',
     ),
     Product(
       id: 'p23',
       title: 'A Pan',
       description: 'Prepare any meal you want.',
       price: 49.99,
       imageUrl:
           'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
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

  Future<void> fetchAndSetProduct() async {
    const url = 'https://eshop-38e41.firebaseio.com/products.json';
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
    const url = 'https://eshop-38e41.firebaseio.com/products.json';
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
      final url = 'https://eshop-38e41.firebaseio.com/products/$id.json';
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
    final url = 'https://eshop-38e41.firebaseio.com/products/$id.json';
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
