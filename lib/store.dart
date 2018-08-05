import 'package:flutter/material.dart';
import 'model/product.dart';
import 'package:intl/intl.dart';

class Store extends StatelessWidget {
  List<Card> _buildGridCards(BuildContext context){
    List<Product> products = ProductRepository().getProducts(Category.all);

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
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('SHRINE'),
        leading: IconButton(
          icon: Icon(Icons.menu, semanticLabel: 'menu',),
          onPressed: (){},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, semanticLabel: 'search',),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.tune, semanticLabel: 'filter',),
            onPressed: (){},
          ),
        ],
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context)
      )
    );
  }
}