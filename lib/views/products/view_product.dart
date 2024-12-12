import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:ecommerce_admin_app/utils/ext/ext.dart';
import 'package:ecommerce_admin_app/views/products/discount.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  ProductsModel product;
  ViewProduct({super.key, required this.product});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  widget.product.image ??
                      "https://demofree.sirv.com/nope-not-here.jpg",
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              10.heightBox,
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              8.heightBox,
              Row(
                children: [
                  Text(
                    "₹${widget.product.old_price.toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  10.widthBox,
                  Text(
                    "₹${widget.product.new_price.toString()}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  8.widthBox,
                  Icon(
                    Icons.arrow_downward_sharp,
                    color: Colors.green,
                    size: 20,
                  ),
                  Text(
                    "${discountPrice(widget.product.old_price, widget.product.new_price)}% off",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.green),
                  ),
                ],
              ),
              widget.product.maxQuantity == 0
                  ? Text("Out of Stock",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red))
                  : Text("Only ${widget.product.maxQuantity} are left in stock",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green)),
              8.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${widget.product.description}",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 55,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Add to cart"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder()))),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 55,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Buy Now"),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder()))),
        ],
      ),
    );
  }
}
