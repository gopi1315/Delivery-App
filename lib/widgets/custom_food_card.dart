import 'package:delivery_app/utils/color.dart';
import 'package:flutter/material.dart';

class CustomFoodCard extends StatelessWidget {
  CustomFoodCard(this.foodTitle, this.priceInDollars, this.imageUrl);

  final String foodTitle;
  final String priceInDollars;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Stack(
        children: [
          foodInfo(context),

          foodImage(),

        ],
      ),
    );
  }

  Widget foodImage() {
    return new Container(
      padding: const EdgeInsets.only(top:5.0),
      alignment: FractionalOffset.topCenter,
      child: new Image(
        image: new AssetImage(imageUrl),
        height: 150.0,
        width: 150.0,
      ),
    );
  }

  Widget foodInfo(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height/4,
      margin: new EdgeInsets.only(top: 40.0),
      decoration: new BoxDecoration(
        color: ksecondaryColorThree,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(10.0),

      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Container(
              width : MediaQuery.of(context).size.width/1.5,
              padding: const EdgeInsets.only(left: 20.0,top:20.0,bottom: 20.0),
              child: Text(foodTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kLabelTextStyleBlack),
            ),

            Container(
                width: 70,
                decoration: new BoxDecoration(
                  color: Colors.black,
                  borderRadius: new BorderRadius.circular(14),
                ),
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 20),
                  child: Text( "\$" "$priceInDollars" , style: kLabelTextStyleWhite),))
          ],
        ),
      ),
    );
  }
}
