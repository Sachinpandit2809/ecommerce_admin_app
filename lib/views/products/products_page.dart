import 'package:ecommerce_admin_app/containers/additional_conferm.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:ecommerce_admin_app/views/products/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Consumer<AdminProvider>(builder: (context, value, _) {
        List<ProductsModel> products =
            ProductsModel.fromJsonList(value.products);
        if (products.isEmpty) {
          return Center(
            child: Text("No Products"),
          );
        }
        return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Choose what do you want?"),
                            content: Text("Delete action cannot be undone"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AdditionalConferm(
                                            contentText:
                                                "Are you sure want to delete this product?",
                                            onYes: () {
                                              DbServices().deleteProducts(
                                                  docId: products[index].id);
                                              Navigator.pop(context);
                                            },
                                            onNo: () {
                                              Navigator.pop(context);
                                            });
                                      });
                                },
                                child: Text("Delete Product",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Edit Product")),
                            ],
                          ));
                },
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewProduct(
                                product: products[index],
                              )));
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    products[index].image,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(
                  products[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " ₹ ${products[index].new_price.toString()}",
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        products[index].category.toString().toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add_products",
                          arguments: products[index]);
                    },
                    icon: Icon(Icons.edit_outlined)),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_products');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
