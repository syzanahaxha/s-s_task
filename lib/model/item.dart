import 'dart:convert';

ItemModel itemModelFromJson(String str) {
  return ItemModel.fromJson(json.decode(str));
}

class ItemModel {
  int? id;
  String? name;
  int? parent;
  String? logo;

  ItemModel({this.id, this.name, this.parent, this.logo});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['logo'] = this.logo;
    return data;
  }
}
