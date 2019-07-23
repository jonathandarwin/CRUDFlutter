import 'dart:convert';

Product fromJson(String str){
  final jsonData = json.decode(str);
  return Product.fromMap(jsonData);
}

String toJson(Product product){
  final dyn = product.toMap();
  return json.encode(dyn);
}

class Product{
  int id;
  String name;
  int qty;

  Product({
    this.id,
    this.name,
    this.qty
  });

  int getId(){
    return id;
  }

  Product setId(int id){
    this.id = id;
    return this;
  }

  Product setName(String name){
    this.name = name;
    return this;
  }

  String getName(){
    return name;
  }

  Product setQty(int qty){
    this.qty = qty;
    return this;
  }

  int getQty(){
    return qty;
  }

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id : json['id'],
    name : json['name'],
    qty : json['qty']
  );

  Map<String, dynamic> toMap() => {
    'id' : id,
    'name' : name,
    'qty' : qty
  };
}