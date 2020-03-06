import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../widgets/vertical_view.dart';

import '../widgets/app_drawer.dart';

import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_overview.dart';


enum FilterOptions {
  Favorites,
  All,
}
class Homepage extends StatefulWidget{
  @override
  _Homepagestate createState()=>_Homepagestate();
}

class _Homepagestate extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
     Widget imageCarousel=new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          
          AssetImage('images/w3.jpeg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/c1.jpg'),
          AssetImage('images/w4.jpeg'),
          AssetImage('images/m2.jpg'),

        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),

    );

    return Scaffold(
      appBar: AppBar(
        title: Text('E-cart'),
        elevation: 0.1,
        actions: <Widget>[
          PopupMenuButton(
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
      ListView(
        children:<Widget>[
              imageCarousel,
              new Padding(padding: const EdgeInsets.all(4.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: new Text('Categories')),
                  ),
              Verticalview(),

              
              
        ]
      )
      );
        
  }
}
