import 'dart:io';

import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/controllers/storage_services.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:ecommerce_admin_app/utils/ext/ext.dart';
import 'package:ecommerce_admin_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ModifyProductPage extends StatefulWidget {
  const ModifyProductPage({super.key});

  @override
  State<ModifyProductPage> createState() => _ModifyProductPageState();
}

class _ModifyProductPageState extends State<ModifyProductPage> {
  late String productId = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();
  TextEditingController newPriceController = TextEditingController();
  TextEditingController maxQuantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  late XFile? image = null;

//  FUNCTION TO PICK IMAGE USING IMAGE PICKER

  Future<void> pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String? res = await StorageServices().uploadImage(image!.path, context);
      setState(() {
        if (res != null) {
          imageController.text = res;
          debugPrint("set Imageurl :=> ${res} : ${imageController.text}");
          Utils.toastSuccessMessage("Image uplaoded Succesfully");
        } else {
          Utils.toastErrorMessage("Something went wrong");
        }
      });
    }
  }

  // SET DATA FROM ARGUMENTS
  setData(ProductsModel data) {
    productId = data.id;
    nameController.text = data.name;
    descriptionController.text = data.description;
    oldPriceController.text = data.old_price.toString();
    newPriceController.text = data.new_price.toString();
    maxQuantityController.text = data.maxQuantity.toString();
    categoryController.text = data.category;
    imageController.text = data.image;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is ProductsModel) {
      setData(arguments);
    }
    return Scaffold(
      appBar: AppBar(
          title:
              Text(productId.isNotEmpty ? "Update Product" : "Modify Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    labelText: "Product Name",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                ),
                10.heightBox,
                TextFormField(
                  controller: oldPriceController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Original Price",
                    labelText: "Original Price",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                ),
                10.heightBox,
                TextFormField(
                  controller: newPriceController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Sell Price Name",
                    labelText: "Sell Price",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                ),
                10.heightBox,
                TextFormField(
                  controller: maxQuantityController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Quantity Left",
                    labelText: "Quantity Left",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                ),
                10.heightBox,
                TextFormField(
                  controller: categoryController,
                  readOnly: true,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Category",
                    labelText: "Category",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Select Category"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.heightBox,
                                  Consumer<AdminProvider>(
                                      builder: (context, value, _) =>
                                          SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: value.categories
                                                    .map((e) => TextButton(
                                                        onPressed: () {
                                                          categoryController
                                                              .text = e["name"];
                                                          setState(() {});
                                                          debugPrint(
                                                              categoryController
                                                                  .text
                                                                  .toString());
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(e["name"])))
                                                    .toList()),
                                          ))
                                ],
                              ),
                            ));
                  },
                ),
                10.heightBox,
                TextFormField(
                  controller: descriptionController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Description",
                    labelText: "Description",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                  maxLines: 6,
                ),
                10.heightBox,
                image == null
                    ? imageController.text.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.all(20),
                            height: 100,
                            width: double.infinity,
                            color: Colors.deepPurple.shade100,
                            child: Image.network(
                              imageController.text,
                              fit: BoxFit.contain,
                            ),
                          )
                        : const SizedBox()
                    : Container(
                        margin: const EdgeInsets.all(20),
                        height: 200,
                        width: double.infinity,
                        color: Colors.deepPurple.shade100,
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                const SizedBox(height: 10),
                HomeButton(
                    name: "Pick Image",
                    onPress: () {
                      pickImage();
                    }),
                10.heightBox,
                TextFormField(
                  controller: imageController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Image Link",
                    labelText: "Image Link",
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                  ),
                ),
                20.heightBox,
                HomeButton(
                    name:
                        productId.isNotEmpty ? "Update Product" : "Add Product",
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "name": nameController.text,
                          "description": descriptionController.text,
                          "old_price": int.parse(oldPriceController.text),
                          "new_price": int.parse(newPriceController.text),
                          "maxQuantity": int.parse(maxQuantityController.text),
                          "category": categoryController.text,
                          "image": imageController.text,
                        };

                        if (productId.isNotEmpty) {
                          DbServices()
                              .updateProducts(docId: productId, data: data);
                          Navigator.pop(context);
                          Utils.toastSuccessMessage("Product Updated");
                        } else {
                          DbServices().createProducts(data: data);
                          Navigator.pop(context);
                          Utils.toastSuccessMessage("Product Added");
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
