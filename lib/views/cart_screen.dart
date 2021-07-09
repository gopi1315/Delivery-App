import 'package:delivery_app/model/payment_list.dart';
import 'package:delivery_app/utils/color.dart';
import 'package:delivery_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  String? foodTitle;
  String? image;
  int? counter;
  double? price;
  double? totalPrice;

  CartScreen(
      {
        required this.foodTitle,
        required this.counter,
        required this.price,
        required this.totalPrice,
        required this.image,
        });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  Position? _currentPosition;
  String? _currentAddress;
  double? deliveryCharges = 0.00;
  int selected=1;
  double? price,totalCost,payAmount;

  List<PaymentList> pList = [
    PaymentList("Credit/Debit Card", 1),
    PaymentList("Net Banking", 2),
    PaymentList("UPI", 3),
    PaymentList("Wallets", 5)
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    setState(() {
      price = widget.price;
      totalCost = widget.totalPrice;
      deliveryCharges = totalCost! <= 30 ? 5 : 0;
      payAmount = totalCost! + deliveryCharges!;
    });
  }

  Future<void> _getCurrentLocation() async{
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best,forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,
          _currentPosition!.longitude
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
        print("_currentAddress : $_currentAddress");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top:50),
                width: MediaQuery.of(context).size.width/1.2,
                child: Text(DELIVERY_MESSAGE,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kTitleTextStyle.copyWith(fontSize: 20),),
              ),

              SizedBox(width: 10.0,height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_currentAddress ?? 'Warangal,Telangana',
                    style: kLabelTextStyleBlackLight,),

                  Text(CHANGE_ADDRESS_TEXT,style: kLabelTextStyleGrayLight,)
                ],
              ),

              SizedBox(height: 30.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Image.asset(
                      widget.image!,
                      height: 80,
                      width: 80,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top:10.0,left:20.0),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width/2.3,
                          child: Text(
                              widget.foodTitle!,
                              maxLines: 2,
                              style: kLabelTextStyleBlackLight),
                        ),

                        SizedBox(height: 8.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height : 35.0,
                              width:35.0,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child:InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.counter = widget.counter! - 1;
                                      if (widget.counter! < 2) {
                                        widget.counter = 1;
                                        //price = price/widget.counter;
                                      }
                                      totalCost =  getPrice(widget.counter!,price!);
                                      deliveryCharges = totalCost! <= 30 ? 5 : 0;
                                      payAmount = totalCost! + deliveryCharges!;
                                    });
                                  },
                                  child: Icon(Icons.remove, color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:5.0,left:8.0),
                              child: Text(
                                "${widget.counter!}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                            SizedBox(width:8.0),
                            Container(
                              height : 35.0,
                              width:35.0,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child:InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.counter = widget.counter! + 1;
                                      if (widget.counter! > 4) {
                                        widget.counter = 3;
                                      }
                                      totalCost =  getPrice(widget.counter!,price!);
                                      deliveryCharges = totalCost! <= 30 ? 5 : 0;
                                      payAmount = totalCost! + deliveryCharges!;
                                    });
                                  },
                                  child: Icon(Icons.add, color: Colors.black)),
                            ),

                          ],
                        ),


                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top:10.0,left:10.0),
                    child: Text(
                        "\$"
                            "$price",
                        style: kLabelTextStyleBlack),
                  ),
                ],
              ),

              SizedBox(height:25.0),

              Divider(
                height: 1,
                color: Color.fromRGBO(204, 204, 204, 30),
                thickness: 1,
              ),

              SizedBox(height:15.0),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DELIVERY_TEXT,style: kTitleTextStyle,),

                      Padding(
                        padding: const EdgeInsets.only(top:3.0),
                        child: Text(FREE_DELIVERY_TEXT,style: kLabelTextStyleGrayLight,),
                      )
                    ],
                  ),

                  Text(
                      "\$""$deliveryCharges",
                      style: kLabelTextStyleBlack),
                ],
              ),

              SizedBox(height:30.0),

              Text(PAYMENT_METHOD_TEXT,style: kTitleTextStyle,),

              Container(
                height: 220.0,
                child: Column(
                  children:
                  pList.map((data) => RadioListTile(
                    dense: true,
                    title: Text("${data.paymentPlatform}",style: kLabelTextStyleBlackLight,),
                    groupValue: selected,
                    value: data.index,
                    activeColor: Colors.black,
                    onChanged: (val) {
                      setState(() {
                        selected = data.index;
                      });
                    },
                  )).toList(),
                ),
              ),

              Container(
                  //padding: const EdgeInsets.only(left:20.0,right: 20.0),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),

                    onPressed: () {

                    },
                    child: Text( "Pay                                       24min.  \$"
                          "${payAmount!.toStringAsFixed(2)}"),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  double getPrice(int counter, double totalPrice) {
    //cartConstant.packageCount = i * priceC;
    return counter * totalPrice;
  }
}
