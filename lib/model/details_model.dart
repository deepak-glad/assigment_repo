import 'dart:convert';

DetailModel detailModelFromJson(String str) =>
    DetailModel.fromJson(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
  String name;
  int id;
  String timeToPrepare;
  Ingredients ingredients;

  DetailModel({
    required this.name,
    required this.id,
    required this.timeToPrepare,
    required this.ingredients,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        name: json["name"],
        id: json["id"],
        timeToPrepare: json["timeToPrepare"],
        ingredients: Ingredients.fromJson(json["ingredients"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "timeToPrepare": timeToPrepare,
        "ingredients": ingredients.toJson(),
      };
}

class Ingredients {
  List<Spice> vegetables;
  List<Spice> spices;
  List<Appliance> appliances;

  Ingredients({
    required this.vegetables,
    required this.spices,
    required this.appliances,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
        vegetables:
            List<Spice>.from(json["vegetables"].map((x) => Spice.fromJson(x))),
        spices: List<Spice>.from(json["spices"].map((x) => Spice.fromJson(x))),
        appliances: List<Appliance>.from(
            json["appliances"].map((x) => Appliance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vegetables": List<dynamic>.from(vegetables.map((x) => x.toJson())),
        "spices": List<dynamic>.from(spices.map((x) => x.toJson())),
        "appliances": List<dynamic>.from(appliances.map((x) => x.toJson())),
      };
}

class Appliance {
  String name;
  String image;

  Appliance({
    required this.name,
    required this.image,
  });

  factory Appliance.fromJson(Map<String, dynamic> json) => Appliance(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}

class Spice {
  String name;
  String quantity;

  Spice({
    required this.name,
    required this.quantity,
  });

  factory Spice.fromJson(Map<String, dynamic> json) => Spice(
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
      };
}
