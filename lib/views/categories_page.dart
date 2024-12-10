import 'package:ecommerce_admin_app/models/categories_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: Consumer<AdminProvider>(builder: (context, value, child) {
        List<CategoriesModel> categories =
            CategoriesModel.fromJsonList(value.categories);
        if (value.categories.isEmpty) {
          return Center(
            child: Text(" No Categories Found"),
          );
        }

        return ListView.builder(
            itemCount: value.categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  categories[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("Priority: ${categories[index].priority}"),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

// for editing and modifing the categories

class ModifyCategories extends StatefulWidget {
  final bool isUpdating;
  final String? name;
  final String? image;
  final int? priority;
  final String? categoryId;
  const ModifyCategories(
      {super.key,
      required this.isUpdating,
      this.name,
      this.image,
      this.priority,
      this.categoryId});
 

  @override
  State<ModifyCategories> createState() => _ModifyCategoriesState();
}

class _ModifyCategoriesState extends State<ModifyCategories> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      // 46 : 44 sec

      title: Text(widget.isUpdating ? "Update Category" : "Add Category"  )
    );
  }
}
