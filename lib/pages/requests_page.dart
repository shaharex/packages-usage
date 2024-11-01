import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:platform_channel/models/products_model.dart';
import 'package:platform_channel/models/todo_model.dart';
import 'package:platform_channel/services/dio_services.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  // this is http
  late Future<List<Product>> _productFuture;

  // this is dio
  final dio = Dio();
  List<Todo> todosList = [];
  List<Product> productsList = [];
  List<Review> reviewsList = [];

  void getProducts() async {
    try {
      final response = await dio.get("https://dummyjson.com/products");
      for (var product in response.data["products"]) {
        productsList.add(Product.fromJson(product));
      }

      log("this is the data: ${productsList[1].reviews}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getReviews() async {
    try {
      final response = await dio.get("https://dummyjson.com/products");
      for (var product in response.data["products"]) {
        for (var review in product["reviews"]) {
          reviewsList.add(Review.fromJson(review));
        }
      }

      debugPrint("this is reviews ${reviewsList}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _productFuture = getProductsHttp();
    super.initState();
  }

  Future<List<Product>> getProductsHttp() async {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/products"));

    if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data["products"] as List<dynamic>).map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // dio package
            const Text(
              'Data using the Dio Package',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                DioServices.fetchData();
              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[900]),
                child: const Text(
                  'Use Dio',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // http package
            const Text(
              'Data using http Package',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                getProductsHttp();
              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green[900]),
                child: const Text(
                  'Use http',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            FutureBuilder(
                future: _productFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final products = snapshot.data!;

                    return Text(" This is data ${products[1].description}");
                  } else {
                    return const Text("no ddata");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
