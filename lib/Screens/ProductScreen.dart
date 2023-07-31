// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  List products = [];

  int limit = 10;

  int skip = 0;

  bool isLoadMore = false;

  ScrollController scrollController = ScrollController();

  fetchProduct() async {
    var uri =
        Uri.parse("https://dummyjson.com/products?limit=$limit&skip=$skip");

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)['products'] as List;

      setState(() {
        products.addAll(json);
      });
    }
  }

  @override
  void initState() {
   
    fetchProduct();
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadMore = true;
        });

        skip = skip + limit;
        await fetchProduct();
        setState(() {
          isLoadMore = false;
        });
      }
    });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        controller: scrollController,
        itemCount: isLoadMore ? products.length + 1 : products.length,
        itemBuilder: (context, index) {
          if (index >= products.length) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {


            //Product Card design---------------------------------------------
            return Container(
              height: 300,
              width: double.maxFinite,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      //Image Design-------------------------------------------
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(products[index]['thumbnail']),
                              fit: BoxFit.fitHeight),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                      ),
                      //title design---------------------------------------------------

                      Container(
                        
                        padding: EdgeInsets.only(bottom: 30),
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        height: 80,
                        width: 150,
                        
                        child: Center(
                            child: Text(
                          products[index]['title'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        )),
                      ),
                      //stock design--------------------------------------------
                       Padding(
                         padding: const EdgeInsets.only(bottom: 10),
                         child: RichText(
                              text: TextSpan(
                                  text: 'Stock : ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                     TextSpan(
                                      text: products[index]['stock'].toString(),style: TextStyle(color: Colors.red)
                                    ),
                                    
                                    ]
                              )
                         ),
                       )
                      
                    ],
                  ),
                  Column(
                    children: [
                      //price column---------------------------------------------

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 40,
                        width: 150,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                text: 'PRICE : ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: products[index]['price'].toString(),
                                  )
                                ]),
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),

                      //Discount column----------------------------------
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10),
                        padding: EdgeInsets.only(bottom: 20),
                        height: 40,
                        width: 180,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                text: 'DISCOUNT : ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: products[index]['discountPercentage']
                                        .toString(),
                                  )
                                ]),
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),

                      //Rating design-------------------------------------------
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 60,
                        width: 150,
                        child: Center(
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'RATING : ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: products[index]['rating']
                                            .toString(),
                                      )
                                    ]),
                                textDirection: TextDirection.ltr,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                      //  Descritpion------------------------------------------
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 70),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            height: 100,
                            width: 170,
                            child: Text(
                              products[index]['description'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
