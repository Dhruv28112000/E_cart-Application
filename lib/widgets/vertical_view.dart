import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter_complete_guide/providers/electronics.dart';
import 'package:flutter_complete_guide/providers/mobiles.dart';
import 'package:flutter_complete_guide/views/laptops.dart';

import 'package:flutter_complete_guide/views/product_overview.dart';
import 'package:flutter_complete_guide/views/mobiles.dart';
//import 'package:flutter_complete_guide/providers/mobiles.dart';
import 'package:flutter_complete_guide/views/women.dart';


class Verticalview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = 250.0;

    return Column(children: <Widget>[
      new Container(
        width: size,
        height: size,
        child: new GestureDetector(
          onTap: () {
              
            Navigator.of(context).pushNamed(
              ProductsOverviewScreen.routeName,
            );
          },
          child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/electronics.jpg'),
                  ))),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            alignment: Alignment.center,
            child: new Text(
              'Electronics',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            )),
      ),
      new Container(
        width: size,
        height: size,
        child: new GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              Laptops.routeName,);
          },
          child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/laptop.jpg'),
                  ))),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            alignment: Alignment.center,
            child: new Text(
              'Laptops',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            )),
      ),
      new Container(
        width: size,
        height: size,
        child: new GestureDetector(
          onTap: () {
              Navigator.of(context).pushNamed(
              Mobile.routeName,
              );

          },
          child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/mobile.jpg'),
                  ))),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            alignment: Alignment.center,
            child: new Text(
              'Mobiles',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            )),
      ),
      new Container(
        width: size,
        height: size,
        child: new GestureDetector(
          onTap: () {
              Navigator.of(context).pushNamed(
              Women.routeName,
              );

          },
          child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/women.jpg'),
                  ))),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            alignment: Alignment.center,
            child: new Text(
              'Women\'s Fashion',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            )),
      ),
    ]);
  }
}
