import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/laptops.dart';
import 'package:flutter_complete_guide/providers/mobiles.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/womens.dart';
//import 'package:flutter_complete_guide/providers/laptops.dart';
import 'package:flutter_complete_guide/views/homepage.dart';
import 'package:flutter_complete_guide/views/splash_screen.dart';
import 'package:provider/provider.dart';
import './providers/electronics.dart';
import './views/cart_overview.dart';
import './views/product_overview.dart';
import './views/product_detail.dart';
import './providers/providers.dart';
import './providers/cart.dart';
import './providers/order.dart';
import './views/order_screen.dart';
import './views/user_product.dart';
import './views/laptops.dart';
import './views/mobiles.dart';
import './views/women.dart';
import './views/auth_screen.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
          ChangeNotifierProvider.value(
          value: Providermobile(),
        ),
          ChangeNotifierProvider.value(
          value: Providerlaptop(),
        ),
          ChangeNotifierProvider.value(
          value: Providerwomen(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        //ChangeNotifierProxyProvider<Auth,Products>(
          //builder: (ctx,auth,previousProducts)=>Products(auth.token,
          //previousProducts==null? [] :previousProducts.items,
          //),
        
        ChangeNotifierProvider.value(
          value: Products(),
        ),
      
        
        
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
         
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
              title: 'E-cart',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              home:  auth.isAuth?Homepage(): AuthScreen(),
                    
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                //EditProductScreen.routeName: (ctx) => EditProductScreen(),
                ProductsOverviewScreen.routeName:(ctx)=>ProductsOverviewScreen(),
                Electronics.routeName:(ctx)=>Electronics(),
                Mobile.routeName:(ctx)=>Mobile(),
                Laptops.routeName:(ctx)=>Laptops(),
                Women.routeName:(ctx)=>Women(),
              },
            ),
      ),
    );
  }
}

