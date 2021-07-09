import 'package:delivery_app/model/cart_model.dart';
import 'package:delivery_app/model/food_details.dart';
import 'package:delivery_app/utils/color.dart';
import 'package:delivery_app/utils/constants.dart';
import 'package:delivery_app/views/cart_screen.dart';
import 'package:delivery_app/widgets/custom_food_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<FoodDetails> foodDetailsList = [];
  List<FoodDetails> filteredfoodDetailsList = [];
  bool _loaded = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = PageController();
  int _counter = 1;
  double totalCost = 0;

  final foodTitle = [
    'Two Slices of Pizza with delicious salami',
    'Salad with Egg & Cheese',
    'Grilled Chicken Platter',
    'Cream of Mushroom'
  ];

  final priceInDollars = [
    '30',
    '15',
    '50',
    '10',
  ];

  final foodImageUrl = [
    'assets/images/pizza.png',
    'assets/images/salad.png',
    'assets/images/grilled_chicken.png',
    'assets/images/soup.png'
  ];

  Future<String> _loadFoodAsset() async {
    return await rootBundle.loadString('assets/json/food_items.json');
  }

  Future<List<FoodDetails>> loadFoodItems() async {
    await wait(1);
    String jsonString = await _loadFoodAsset();
    var parsed = json.decode(jsonString.toString());
    foodDetailsList = List<FoodDetails>.from(
        parsed.map((i) => FoodDetails.fromJson(i)).toList());
    return foodDetailsList;
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  @override
  void initState() {
    super.initState();
    loadFoodItems().then((s) => setState(() {
          _loaded = true;
        }));
  }

  @override
  void dispose() {
    super.dispose();
    _counter =1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(TITLE_NAME, style: kappbarTitleTextStyle),
        centerTitle: true,
        leading: (new IconButton(
            icon: const Icon(
              Icons.menu,
              size: 25.0,
            ),
            color: Colors.white,
            onPressed: () {})),
      ),
      body: _loaded ? Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0, 5.0),
              child: Text(DASHBOARD_TITLE, style: kTitleTextStyle),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              padding: EdgeInsets.only(left: 5, right: 5),
              width: MediaQuery.of(context).size.width,
              child: widgetWeekCard(),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: foodTitle.length,
                  effect: SlideEffect(
                      spacing: 4.0,
                      radius: 4.0,
                      dotWidth: 80.0,
                      dotHeight: 3.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodDetailsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => bottomSheetFoodItemDetails(
                          context, foodDetailsList[index]),
                      child: Column(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  foodDetailsList[index].image!,
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                          foodDetailsList[index].foodTitle!,
                                          maxLines: 2,
                                          style: kLabelTextStyleBlackLight),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            width: 90,
                                            decoration: new BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  new BorderRadius.circular(14),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  right: 10,
                                                  bottom: 5,
                                                  left: 20),
                                              child: Text(
                                                  "\$"
                                                  "${foodDetailsList[index].price}",
                                                  style: kLabelTextStyleBlack),
                                            )),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                            foodDetailsList[index].calories ??
                                                '100kcal',
                                            style: kLabelTextStyleGrayLight),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ) : new Center(
        child: new CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }

  Widget widgetWeekCard() {
    return PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemCount: foodTitle.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomFoodCard(
              foodTitle[index], priceInDollars[index], foodImageUrl[index]);
        });
  }

  void bottomSheetFoodItemDetails(BuildContext context, FoodDetails detail) {
    _counter = 1;
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: Color(0XFF737373),
              child : Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30.0),
                        topRight: const Radius.circular(30.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.clear,
                              size: 25,
                              color: Colors.grey,
                            ))),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      detail.image!,
                      height: 200,
                      width: 250,
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top:10.0),
                    child: Text(
                      detail.foodTitle!,
                      style: kTitleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0,bottom: 20.0),
                    child: Text(
                      detail.foodDesc!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: kLabelTextStyleGrayLight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,top:10.0,),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top:8.0),
                            height : 40.0,
                            width:MediaQuery.of(context).size.width/4,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () {

                                      setState(() {
                                        _counter--;
                                        if (_counter < 2) {
                                          _counter = 1;
                                        }
                                      });
                                      //widget.callback();
                                    },
                                    child: Icon(Icons.remove, color: Colors.black)),

                                Text(
                                  "$_counter",
                                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                                ),

                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _counter++;
                                        if (_counter > 4) {
                                          _counter = 3;
                                        }
                                      });

                                      //widget.callback();
                                    },
                                    child: Icon(Icons.add, color: Colors.black)),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(right: 20.0),
                            height: 35,
                            width: 180,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),

                              onPressed: () {
                                double price = 0.0;
                                setState(() {
                                  price = double.parse(detail.price!);
                                  totalCost =  getPrice(_counter,price);
                                });

                                Navigator.pushNamed(
                                    context, CartScreen.routeName,
                                    arguments: CartModel(
                                         detail.foodTitle,
                                         _counter,
                                         price,
                                         totalCost,
                                         detail.image
                                    ));
                              },
                              child: Text( "Add to Cart  \$"
                              "${detail.price}"),
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
          });
        });
  }

  double getPrice(int counter, double totalPrice) {
    //cartConstant.packageCount = i * priceC;
    return counter * totalPrice;
  }
}
