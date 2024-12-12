import 'package:ecommerce_admin_app/containers/additional_conferm.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/models/promos_banner_model.dart';
import 'package:flutter/material.dart';

class PromoBannersPage extends StatefulWidget {
  const PromoBannersPage({super.key});

  @override
  State<PromoBannersPage> createState() => _PromoBannersPageState();
}

class _PromoBannersPageState extends State<PromoBannersPage> {
  bool isPromo = true;
  bool isInitialized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isInitialized) {
        final arguments = ModalRoute.of(context)?.settings.arguments;
        if (arguments != null && arguments is Map<String, dynamic>) {
          isPromo = arguments['promo'] ?? true;
        }
        debugPrint(" Promo $isPromo");
        isInitialized = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isPromo ? "Promos" : "Banners"),
      ),
      body: isInitialized
          ? StreamBuilder(
              stream: DbServices().readPromos(isPromo),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<PromosBannerModel> promos =
                      PromosBannerModel.fromJsonList(snapshot.data!.docs)
                          as List<PromosBannerModel>;
                  if (promos.isEmpty) {
                    return Center(
                      child: Center(
                          child: Text(
                              "No ${isPromo ? "Promos" : "Banners "} Found")),
                    );
                  }
                  return ListView.builder(
                      itemCount: promos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Choose what do you want?"),
                                      content: Text(
                                          "Delete action cannot be undone"),
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
                                                        DbServices()
                                                            .deletePromos(
                                                                isPromo:
                                                                    isPromo,
                                                                docId: promos[
                                                                        index]
                                                                    .id);
                                                        Navigator.pop(context);
                                                      },
                                                      onNo: () {
                                                        Navigator.pop(context);
                                                      });
                                                });
                                          },
                                          child: Text(
                                              "Delete ${isPromo ? "promo" : "banner"}",
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context,
                                                  '/modify_promo_banner',
                                                  arguments: {
                                                    "detail": promos[index],
                                                    "promo": isPromo
                                                  });
                                            },
                                            child: Text(
                                                "Edit ${isPromo ? "promo" : "banner"}")),
                                      ],
                                    ));
                          },
                          leading: Container(
                            height: 50,
                            width: 50,
                            child:
                                Image.network(promos[index].image.toString()),
                          ),
                          title: Text(
                            promos[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(promos[index].category),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/modify_promo_banner',
                                    arguments: {
                                      "detail": promos[index],
                                      "promo": isPromo
                                    });
                              },
                              icon: Icon(Icons.edit)),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
          : SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/modify_promo_banner',
            arguments: {"promo": isPromo},
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
