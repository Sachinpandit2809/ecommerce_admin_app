import 'dart:io';

import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/controllers/storage_services.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:ecommerce_admin_app/models/promos_banner_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:ecommerce_admin_app/utils/ext/ext.dart';
import 'package:ecommerce_admin_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ModifyPromoBanner extends StatefulWidget {
  const ModifyPromoBanner({super.key});

  @override
  State<ModifyPromoBanner> createState() => _ModifyPromoBannerState();
}

class _ModifyPromoBannerState extends State<ModifyPromoBanner> {
  late String promoId = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  late XFile? image = null;

  bool _isInitialized = false;
  bool isPromo = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        final arguments = ModalRoute.of(context)?.settings.arguments;
        if (arguments != null && arguments is Map<String, dynamic>) {
          if (arguments['detail'] is PromosBannerModel) {
            setData(arguments["detail"] as PromosBannerModel);
          }
          isPromo = arguments['promo'] ?? true;
        }
        debugPrint(" Promo $isPromo");
        _isInitialized = true;
        setState(() {});
      }
    });
  }

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
  setData(PromosBannerModel data) {
    promoId = data.id;
    titleController.text = data.title;

    categoryController.text = data.category;
    imageController.text = data.image;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(promoId.isNotEmpty
              ? isPromo
                  ? "Update promo "
                  : "update banner"
              : isPromo
                  ? "Add promo"
                  : "Add banner")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                  decoration: InputDecoration(
                    hintText: "promo banner Name",
                    labelText: "promo banner Name",
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
                              title: Text("Select Category"),
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
                // TextFormField(
                //   controller: descriptionController,
                //   validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                //   decoration: InputDecoration(
                //     hintText: "Description",
                //     labelText: "Description",
                //     fillColor: Colors.deepPurple.shade50,
                //     filled: true,
                //   ),
                //   maxLines: 6,
                // ),
                // 10.heightBox,
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
                        height: 200,
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
                    name: promoId.isNotEmpty
                        ? isPromo
                            ? "Update Promo"
                            : "Update Banner"
                        : isPromo
                            ? "Add Promo"
                            : "Add Banner",
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "title": titleController.text,
                          "category": categoryController.text,
                          "image": imageController.text,
                        };

                        if (promoId.isNotEmpty) {
                          DbServices().updatePromos(
                              docId: promoId, data: data, isPromo: isPromo);
                          Navigator.pop(context);
                          Utils.toastSuccessMessage(
                              "${isPromo ? "Promo" : "Banner"} Updated");
                        } else {
                          DbServices()
                              .createPromos(data: data, isPromo: isPromo);
                          Navigator.pop(context);
                          Utils.toastSuccessMessage(
                              "${isPromo ? "Promo" : "Banner"} Added");
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
