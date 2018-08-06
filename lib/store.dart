import 'package:flutter/material.dart';
import 'model/product.dart';
import 'package:intl/intl.dart';
import 'backdrop.dart';
import 'colors.dart';
import 'category_menu_page.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category c){
    setState((){
      _currentCategory = c;
    });
  }
  List<Card> _buildGridCards(BuildContext context){
    List<Product> products = ProductRepository().getProducts(_currentCategory);

    if (products == null || products.isEmpty){
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString()
    );

    return products.map((Product product) {
      return Card(
        elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.asset('assets/diamond.png')
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(product.name, style: theme.textTheme.button, maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4.0),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.caption
                      )
                    ],
                  )
              )
            ],
          )
      );
    }).toList();

  }

  @override
  Widget build(BuildContext context){
    return Backdrop(
      category: _currentCategory,
      frontTitle: Text('SHRINE'),
      backTitle: Text('Menu'),
      frontLayer: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context)
      ),
      backLayer: CategoryMenuPage(
        currentCategory: _currentCategory,
        onCategoryTap: _onCategoryTap,
      )
    );
  }
}