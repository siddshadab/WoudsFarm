import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/item.dart';
import 'package:wouds_farm/widgets/TextInputDecoration.dart';

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
                    backgroundColor: const Color.fromARGB(255, 244, 237, 232),
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
                    color: const Color.fromARGB(255, 244, 237, 232)),
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
                            color: isOrder
                                ? Colors.white
                                : const Color.fromARGB(255, 244, 237, 232),
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
                            color: isOrder
                                ? const Color.fromARGB(255, 244, 237, 232)
                                : Colors.white,
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
                    )
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
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersistantBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersistantBottomSheetCallBack = _displayModalBottomSheet;
  }
  void addItemToCart(Map items) async {
    print("here");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList('cart') == null) {
      sharedPreferences.setStringList('cart', [json.encode(items)]);
    } else {
      List<String> cart = sharedPreferences.getStringList('cart');
      cart.add(json.encode(items));
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

  String type;
  int optionId;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Container(
                color: const Color.fromARGB(255, 244, 237, 232),
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
                      GestureDetector(
                        onTap: _showPersistantBottomSheetCallBack,
                        child: Padding(
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
                          color: const Color.fromARGB(255, 244, 237, 232),
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
                                primary:
                                    const Color.fromARGB(255, 244, 237, 232),
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
  void _displayModalBottomSheet() {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 200.0,
            width: size.width,
            color: const Color.fromARGB(255, 244, 237, 232),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,

                      padding: EdgeInsets.only(left: 10.0),
                      child: new Center(
                        child: Text("Live To Live Chicken Menus Options"),)),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/liveChickenOrderListTrader');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://cdn2.iconfinder.com/data/icons/restaurant-outline-3/64/food-menu-order-restaurant-1024.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Order Details")
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/placeLiveChickenOrder');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://www.kindpng.com/picc/m/757-7574661_logo-logo-order-now-brown-png-transparent-png.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Order Now")
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        });

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
      List<String> cart = sharedPreferences.getStringList('cart');
      cart.remove(json.encode(items));
      sharedPreferences.setStringList('cart', cart);
      print(cart);
      print("Homepage khatam");
    }
  }

  var total = 0;
  var cart;

  Future getaCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> cart = sharedPreferences.getStringList('cart');
    print(cart);
    print("CART CHECK KARLE");
    List cartitems = [];
    for (var item in cart) {
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
      List<String> cart = sharedPreferences.getStringList('cart');

      cartitems = [];
      for (var item in cart) {
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
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 244, 237, 232),
                                ),
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
