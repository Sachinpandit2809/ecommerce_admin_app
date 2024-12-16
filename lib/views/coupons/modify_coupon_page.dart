import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:ecommerce_admin_app/utils/ext/ext.dart';
import 'package:ecommerce_admin_app/utils/utils.dart';
import 'package:ecommerce_admin_app/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModifyCouponPage extends StatefulWidget {
  final String id, code, desc;
  final int discount;
  ModifyCouponPage(
      {super.key,
      required this.id,
      required this.code,
      required this.discount,
      required this.desc});

  @override
  State<ModifyCouponPage> createState() => _ModifyCouponPageState();
}

class _ModifyCouponPageState extends State<ModifyCouponPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  void initState() {
    descController.text = widget.desc;
    codeController.text = widget.code;
    discountController.text = widget.discount.toString();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descController.dispose();
    codeController.dispose();
    discountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.id.isNotEmpty ? "Update Coupon" : "Add Coupon"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("All will be converted to uppercase"),
              10.heightBox,
              TextFormField(
                controller: codeController,
                validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                decoration: InputDecoration(
                  hintText: "Coupon Code",
                  labelText: "Coupon Code",
                  fillColor: Colors.deepPurple.shade50,
                  filled: true,
                ),
              ),
              10.heightBox,
              TextFormField(
                controller: descController,
                validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                decoration: InputDecoration(
                  hintText: "Descreption",
                  labelText: "Descreption",
                  fillColor: Colors.deepPurple.shade50,
                  filled: true,
                ),
              ),
              10.heightBox,
              TextFormField(
                controller: discountController,
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "this can't be empty" : null,
                decoration: InputDecoration(
                  hintText: "Discount",
                  labelText: "Discount",
                  fillColor: Colors.deepPurple.shade50,
                  filled: true,
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              var data = {
                "code": codeController.text.toUpperCase(),
                "desc": descController.text,
                "discount": int.parse(discountController.text)
              };
              if (widget.id.isNotEmpty) {
                DbServices().updateCoupon(data: data, docId: widget.id);
                Utils.toastSuccessMessage("Coupon code updated");
                Navigator.pop(context);
              } else {
                DbServices().createCoupon(data: data);
                Utils.toastSuccessMessage("Coupon code created");

                Navigator.pop(context);
              }
            }
          },
          child: Text(widget.id.isNotEmpty ? "Update Coupon" : "Add Coupon"),
        )
      ],
    );
  }
}
