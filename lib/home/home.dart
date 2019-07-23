import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_example/home/home_bloc.dart';
import 'package:sqflite_example/insertupdate/insertupdate.dart';
import 'package:sqflite_example/model/product.dart';
import 'package:sqflite_example/util/SnackBarUtil.dart';

class HomeLayout extends StatefulWidget{
  @override
  HomeLayoutState createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout>{
  final HomeBloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {     
    _bloc.getAllProduct();  

    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLite"),        
      ),
      body: StreamBuilder(
        stream: _bloc.list,
        initialData: List<Product>(),
        builder: (context, snapshot) {                                      
          if(snapshot.hasData){
            List<Product> listProduct = snapshot.data; 
            if(listProduct.length == 0) {
              return Center(
                child: Text('No Data'),
              );
            }
            
            return ListView.separated(
              separatorBuilder: (context, i) => Divider(
                color: Colors.grey,              
              ),
              itemCount: listProduct.length,
              itemBuilder: (context, i) {
                return ListItem(_bloc, listProduct[i]);
              },
            );
          }         
          else{
            return Center(
              child: Text('No Data'),
            );
          }                     
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => InsertUpdateLayout(Product().setId(0))
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }  
}

class ListItem extends StatelessWidget{

  final Product product;
  final HomeBloc _bloc;

  ListItem(this._bloc, this.product);

  @override
  Widget build(BuildContext context){            
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(product.getName()),          
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(product.getQty().toString()),
            ),
          ),
          Expanded(                        
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(                  
                    onTap: () => gotoInsertUpdate(context, product),
                    child: Icon(Icons.edit,
                      color: Colors.blue
                      ),
                  ),
                ),
                GestureDetector(
                  onTap: () => dialogDelete(context, product),
                  child: Icon(Icons.delete,
                    color: Colors.red
                    ),
                ),
              ],
            )
          )
        ],
      ),      
    );
  }

  void gotoInsertUpdate(BuildContext context, Product product){
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => InsertUpdateLayout(product)
      ));
  }

  void dialogDelete(BuildContext context, Product product) {    
    showDialog(
      context: context,      
      builder: (ctx) => AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure want to delete "${product.getName()}"?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              int result = await _bloc.deleteProduct(product.getId());
              if(result > 0){
                _bloc.getAllProduct();
              }
              Navigator.pop(context);
              SnackBarUtil.successSnackBar(context);
            },
            child: Text("Yes"),
          ),
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
        ],
      )
    );
  }
}