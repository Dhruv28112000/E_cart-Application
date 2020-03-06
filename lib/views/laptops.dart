import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/providers.dart';
import 'package:provider/provider.dart';
//import 'package:carousel_pro/carousel_pro.dart';

import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_overview.dart';
//import '../providers/providers.dart';
//import '../providers/laptops.dart';
import '../providers/laptops.dart';

enum FilterOptions {
  Favorites,
  All,
}


class Laptops extends StatefulWidget {
  static const routeName = '/laptop';

  @override
  _Laptopstate createState() => _Laptopstate();

  fetchAndSetProducts() {}
  }
  
  class _Laptopstate extends State<Laptops> {
    var _showOnlyFavorites = false;
  
    var _isInit = true;
  
    var _isLoading = false;
  
    @override
    void initState() {
      // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
      // Future.delayed(Duration.zero).then((_) {
      //   Provider.of<Products>(context).fetchAndSetProducts();
      // });
      super.initState();
    }
  
    @override
    void didChangeDependencies() {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        Provider.of<Providerlaptop>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  
  @override
  Widget build(BuildContext context) {
     
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Laptops'),
      
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:
        
          
       _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    

        
      );
      
        
  }
}

  