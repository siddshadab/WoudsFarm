import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/item.dart';
// import 'package:lokalgrub/utilities/colors.dart';
// import 'package:lokalgrub/widgets/common_widgets.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isOrder = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:  const Color.fromARGB(255, 244, 237, 232),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text("User"),
                  subtitle: Text("Wouds Farm"),
                ),
              ),
              Container(
                height: 30,
                width: size.width * 0.83,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color:  const Color.fromARGB(255, 244, 237, 232)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isOrder = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: Container(
                          height: 20,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: isOrder ? Colors.white :  const Color.fromARGB(255, 244, 237, 232),
                          ),
                          child: Center(
                            child: Text(
                              "New Order",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isOrder = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: Container(
                          height: 20,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: isOrder ?  const Color.fromARGB(255, 244, 237, 232) : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Cart",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       isOrder = false;
                    //     });
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(0.8),
                    //     child: Container(
                    //       height: 20,
                    //       width: size.width * 0.4,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         color: isOrder ? Color(0xFfe8d6c8) : Colors.white,
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           "Order Status",
                    //           style: TextStyle(
                    //             fontSize: 15.0,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.85,
                child: isOrder ? NewOrder() : OrderStatus(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  void addItemToCart(Map items) async {
    print("here");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList('cart') == null) {
      sharedPreferences.setStringList('cart', [json.encode(items)]);
    } else {
      List<String>? cart = sharedPreferences.getStringList('cart');
      cart!.add(json.encode(items));
      sharedPreferences.setStringList('cart', cart);
      print(cart);
      print("Homepage khatam");
    }
  }

  List<ItemModel> items = [
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
    ItemModel(
        "chicken",
        150,
        Uri.parse(
            "https://thumbs.dreamstime.com/z/fresh-raw-chicken-legs-19961106.jpg")),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 244, 237, 232),
      //backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Container(
                color:  const Color.fromARGB(255, 244, 237, 232),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Text("Deliver to Shefali - Mumbai 400016 "),
                    Spacer(),
                    Text("Payments")
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "https://img.pngio.com/clipartistnet-clip-art-chicken-svg-png-black-and-white-chicken-999_1034.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Live Chicken")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "http://clipart-library.com/img/1378302.jpg",
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Chicken pices")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "https://img.pngio.com/clipartistnet-clip-art-chicken-svg-png-black-and-white-chicken-999_1034.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Eggs")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "https://img.pngio.com/clipartistnet-clip-art-chicken-svg-png-black-and-white-chicken-999_1034.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Seafood")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "https://img.pngio.com/clipartistnet-clip-art-chicken-svg-png-black-and-white-chicken-999_1034.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Meat")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "https://img.pngio.com/clipartistnet-clip-art-chicken-svg-png-black-and-white-chicken-999_1034.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Ready to Cook")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //       height: MediaQuery.of(context).size.height * 0.12,
            //       width: MediaQuery.of(context).size.width,
            //       child: Text("Thanksgiving Chicken Image")),
            // ),
            Container(
              width: size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          color:  const Color.fromARGB(255, 244, 237, 232),
                        ),
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Payment Options")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://img2.pngio.com/paytm-wikipedia-paytm-png-675_225.png",
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Paytm")
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://purepng.com/public/uploads/large/purepng.com-google-pay-gpay-logobrandlogobrand-logoiconssymbolslogosgoogle-681522937443muxmx.png",
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Google Pay")
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://www.searchpng.com/wp-content/uploads/2018/11/phone-pe-1024x1024.png",
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Paytm")
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://www.searchpng.com/wp-content/uploads/2019/01/UPI-Logo-PNG-1024x490.png",
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Bhim Upi")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 38,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Deals Of the day",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            // Container(
            //   height: 35,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(color: Colors.transparent),
            //   child: Center(
            //     child: Text(
            //       "FRESH DEALS EVERYDAY - GRAB YOURS NOW!",
            //       style: TextStyle(
            //         fontSize: 16,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            // Container(
            //   color: Colors.white,
            //   height: MediaQuery.of(context).size.height * 0.2,
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Container(
            //           child: Image.network(
            //               "https://freshtocart.s3.ap-south-1.amazonaws.com/Merchant1/Large/A6A8E.jpg"),
            //         ),
            //       ),
            //       // Column(
            //       //   children: [
            //       //     Padding(
            //       //       padding: const EdgeInsets.only(top: 18.0),
            //       //       child: Image.network(
            //       //           "https://firebasestorage.googleapis.com/v0/b/food-3e371.appspot.com/o/Screenshot%202021-07-05%20124701.jpg?alt=media&token=37ea8095-dd40-413f-8763-b9da0fac517a"),
            //       //     ),
            //       //     Padding(
            //       //       padding: const EdgeInsets.all(15.0),
            //       //       child: Text(
            //       //         "Curry Cut - Large pcs \n 5kg at Rs. 256 only/-",
            //       //         style: TextStyle(
            //       //           fontSize: 13,
            //       //           color: Colors.black,
            //       //           fontWeight: FontWeight.bold,
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ],
            //       // )
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(items[index].image.toString()),
                          title: Text(items[index].name),
                          subtitle: Text(
                            "₹ ${items[index].price}",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:  const Color.fromARGB(255, 244, 237, 232),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                              ),
                              onPressed: () {
                                addItemToCart({
                                  'name': items[index].name,
                                  'price': items[index].price,
                                  'image': items[index].image.toString(),
                                });
                              },
                              child: Text("Add to Cart")),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: items.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatus extends StatefulWidget {
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  void initState() {
    getaCart();

    // TODO: implement initState
    super.initState();
  }

  void deleteItemToCart(Map items) async {
    print("here");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList('cart') == null) {
      sharedPreferences.setStringList('cart', [json.encode(items)]);
    } else {
      List<String>? cart = sharedPreferences.getStringList('cart');
      cart!.remove(json.encode(items));
      sharedPreferences.setStringList('cart', cart);
      print(cart);
      print("Homepage khatam");
    }
  }

  var total = 0;
  var cart;

  Future getaCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? cart = sharedPreferences.getStringList('cart');
    print(cart);
    print("CART CHECK KARLE");
    List cartitems = [];
    for (var item in cart!) {
      print(item.runtimeType);
      print(item);
      cartitems.add(json.decode(item));
    }
    print(cartitems);
    for (var item in cartitems) {
      setState(() {
        total += int.parse(item['price'].toString());
      });
      print(item['price']);
      print("ADD KAR RAHA HU");
    }
    print(cartitems);

    return cartitems;
  }

  @override
  Widget build(BuildContext context) {
    var cart;
    List<Map> cartitems;
    bool isChange = false;

    Future getCart() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String>? cart = sharedPreferences.getStringList('cart');

      cartitems = [];
      for (var item in cart!) {
        print(item.runtimeType);
        print(item);
        cartitems.add(json.decode(item));
      }
      print(cartitems);

      return cartitems;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 237, 232),

        // backgroundColor: Colors.red,

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown,
          child: Text('Reset'),
          onPressed: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setStringList('cart', []);
            setState(() {
              cartitems = [];
              total = 0;
            });
          },
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getCart(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                    snapshot.data[index]['image']),
                                title: Text(snapshot.data[index]['name']),
                                subtitle: Text(
                                    snapshot.data[index]['price'].toString()),
                                trailing: ElevatedButton(
                                    onPressed: () {}, child: Text("Remove")),
                              );
                            },
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Cart is Empty",
                                style: TextStyle(color:  const Color.fromARGB(255, 244, 237, 232),),
                              ),
                            ),
                          );
                  },
                ),
              ),
              //  ADDD HERE

              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                    child: Text(
                  "Total Amount: ₹" + total.toString(),
                  style: TextStyle(fontSize: 20),
                )),
              ),
              // displayUpiApps(total.toString())
            ],
          ),
        ),
      ),


    );
  }
}
