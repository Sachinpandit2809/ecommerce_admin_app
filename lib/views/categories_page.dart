import 'dart:io';

import 'package:ecommerce_admin_app/containers/additional_conferm.dart';
import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/controllers/storage_services.dart';
import 'package:ecommerce_admin_app/models/categories_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:ecommerce_admin_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    categories[index].image == null ||
                            categories[index].image == ""
                        ? "https://demofree.sirv.com/nope-not-here.jpg"
                        : categories[index].image,
                    // fit: BoxFit.contain,
                  ),
                ),
                title: Text(
                  categories[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("Priority: ${categories[index].priority}"),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    debugPrint(
                        " id = ${categories[index].id} \n name = ${categories[index].name} \n image = ${categories[index].image} \n priority = ${categories[index].priority} \n ${categories[index]}");
                    showDialog(
                        context: context,
                        builder: (context) => ModifyCategories(
                              isUpdating: true,
                              categoryId: categories[index].id,
                              priority: categories[index].priority,
                              name: categories[index].name,
                              image: categories[index].image,
                            ));
                  },
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Choose what do you want to do?"),
                      content: Text("Delete action cannot be undone"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) => AdditionalConferm(
                                      contentText:
                                          "Are you sure you want to delete this category?",
                                      onYes: () {
                                        DbServices().deleteCategories(
                                            docId: categories[index].id);
                                        Navigator.pop(context);
                                      },
                                      onNo: () {
                                        Navigator.pop(context);
                                      }));
                              // DbServices().deleteCategories(
                              //     docId: categories[index].id);
                              // Navigator.pop(context);
                            },
                            child: Text("Delete Category")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);

                              showDialog(
                                  context: context,
                                  builder: (context) => ModifyCategories(
                                        isUpdating: true,
                                        categoryId: categories[index].id,
                                        priority: categories[index].priority,
                                        name: categories[index].name,
                                        image: categories[index].image,
                                      ));
                            },
                            child: Text("Update Category")),
                      ],
                    ),
                  );
                },
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) => ModifyCategories(
                    isUpdating: false,
                    categoryId: "",
                    priority: 0,
                    name: "",
                    image: "",
                  ));
        },
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
  final int priority;
  final String categoryId;
  const ModifyCategories(
      {super.key,
      required this.isUpdating,
      this.name,
      this.image,
      required this.priority,
      required this.categoryId});

  @override
  State<ModifyCategories> createState() => _ModifyCategoriesState();
}

class _ModifyCategoriesState extends State<ModifyCategories> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  late XFile? image = null;
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdating && widget.name != null) {
      categoryController.text = widget.name!;
      priorityController.text = widget.priority.toString();
      imageController.text = widget.image!;
    }
    // TODO: implement initState
    super.initState();
  }

  // FUNCTION TO PICK IMAGE USING IMAGE PICKER
  Future<void> pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String? res = await StorageServices().uploadImage(image!.path, context);
      setState(() {
        if (res != null) {
          imageController.text = res;
          debugPrint("Set Image URl :=> $res : ${imageController.text}");
          Utils.toastSuccessMessage("Image Uploaded Successfully");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isUpdating ? "Update Category" : "Add Category"),
      content: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("All will be converted to lower"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: categoryController,
                    validator: (v) => v!.isEmpty ? "This can't be empty" : null,
                    decoration: InputDecoration(
                        hintText: "categories Name",
                        labelText: "Category Name",
                        fillColor: Colors.grey.shade100,
                        filled: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("This will br used in ordering categories"),
                  TextFormField(
                    controller: priorityController,
                    validator: (v) => v!.isEmpty ? "This can't be empty" : null,
                    decoration: InputDecoration(
                        hintText: "Priority Name",
                        labelText: "Priority Name",
                        fillColor: Colors.grey.shade100,
                        filled: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  image == null
                      ? imageController.text.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              color: Colors.deepPurple.shade100,
                              child: Image.network(
                                imageController.text,
                                fit: BoxFit.contain,
                              ),
                            )
                          : SizedBox()
                      : Container(
                          margin: EdgeInsets.all(20),
                          height: 300,
                          width: double.infinity,
                          color: Colors.deepPurple.shade100,
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.contain,
                          ),
                        ),
                  SizedBox(height: 10),
                  HomeButton(
                      name: "Pick Image",
                      onPress: () {
                        pickImage();
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: imageController,
                    validator: (v) => v!.isEmpty ? "This can't be empty" : null,
                    decoration: InputDecoration(
                        hintText: "Image Link",
                        labelText: "Image Link",
                        fillColor: Colors.grey.shade100,
                        filled: true),
                  ),
                ],
              ))),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (widget.isUpdating) {
                  debugPrint("......................... i a m here ");
                  if (widget.categoryId.isEmpty) {
                    Utils.toastErrorMessage("Invalid category ID for update");
                    return;
                  }
                  await DbServices()
                      .updateCategories(docId: widget.categoryId, data: {
                    "name": categoryController.text.toLowerCase(),
                    "image": imageController.text,
                    "priority": int.parse(priorityController.text),
                  });
                  // Utils.toastSuccessMessage("Category Updated");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Category Updated"),
                  ));
                  Navigator.pop(context);
                } else {
                  await DbServices().createCategories(data: {
                    "name": categoryController.text.toLowerCase(),
                    "image": imageController.text,
                    "priority": int.parse(priorityController.text),
                  });
                  Utils.toastSuccessMessage("Category Added");
                  Navigator.pop(context);
                }
              }
            },
            child: Text(widget.isUpdating ? "Update" : "Add")),
      ],
    );
  }
}
