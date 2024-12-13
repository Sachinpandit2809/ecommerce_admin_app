import 'package:ecommerce_admin_app/containers/additional_conferm.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/models/coupon_model.dart';
import 'package:ecommerce_admin_app/views/coupons/modify_coupon_page.dart';
import 'package:flutter/material.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coupon")),
      body: StreamBuilder(
        stream: DbServices().readCouponCode(),
        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.hasData) {
            List<CouponModel> coupons =
                CouponModel.fromJsonList(snapshot.data!.docs)
                    as List<CouponModel>;
            if (coupons.isEmpty) {
              return Center(
                child: Text("No Coupons Found"),
              );
            }

            return ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("What do you want to do?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AdditionalConferm(
                                                    contentText:
                                                        "Are you sure want to delete?",
                                                    onYes: () {
                                                      DbServices().deleteCoupon(
                                                          docId: coupons[index]
                                                              .id);
                                                      Navigator.pop(context);
                                                    },
                                                    onNo: () {
                                                      Navigator.pop(context);
                                                    }));
                                      },
                                      child: Text(
                                        "Delete Coupon",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ModifyCouponPage(
                                                    id: coupons[index].id,
                                                    code: coupons[index].code,
                                                    discount:
                                                        coupons[index].discount,
                                                    desc: coupons[index].desc));
                                      },
                                      child: Text(
                                        "Update Coupon",
                                        style: TextStyle(),
                                      )),
                                ],
                              ));
                    },
                    title: Text("${coupons[index].code}"),
                    subtitle: Text("${coupons[index].desc}"),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => ModifyCouponPage(
                                  id: coupons[index].id,
                                  code: coupons[index].code,
                                  discount: coupons[index].discount,
                                  desc: coupons[index].desc));
                        },
                        icon: Icon(Icons.edit)),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) =>
                    ModifyCouponPage(id: "", code: "", desc: "", discount: 0));
          }),
    );
  }
}
