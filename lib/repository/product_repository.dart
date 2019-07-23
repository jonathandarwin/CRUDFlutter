import 'package:sqflite_example/repository/base_repository.dart';
import 'package:sqflite_example/model/product.dart';

class ProductRepository extends BaseRepository{  
  Future<int> insertProduct(Product product) async{
    final db = await database;
    var result = await db.rawInsert('INSERT INTO msProduct(name, qty) VALUES (?,?)', [product.getName(), product.getQty()]);
    return result;
  }

  Future<List<Product>> getAllProduct() async {
    final db = await database;
    // var result = await db.query('msProduct');
    var result = await db.rawQuery('SELECT * FROM msProduct');
    List<Product> listProduct = result.isNotEmpty ? result.map((c) => Product.fromMap(c)).toList() : [];
    return listProduct;
  }

  Future<int> updateProduct(Product product) async {
    final db = await database;
    int result = await db.update('msProduct', product.toMap(), where: 'id = ${product.getId()}');
    return result;
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete('msProduct');
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('msProduct', where: 'id = $id');
  }
}