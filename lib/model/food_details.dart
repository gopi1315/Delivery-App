
class FoodDetails {
   String? foodTitle;
   String? foodDesc;
   String? price;
   String? calories;
   String? image;

  FoodDetails({this.foodTitle, this.foodDesc, this.price, this.calories,this.image});

  FoodDetails.fromJson(Map<String, dynamic> json) {
        foodTitle = json["food_title"];
        foodDesc = json["food_desc"];
        price = json["price"];
        calories = json["calories"];
        image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_title'] = this.foodTitle;
    data['food_desc'] = this.foodDesc;
    data['price'] = this.price;
    data['calories'] = this.calories;
    data['image'] = this.image;
    return data;
  }
}
