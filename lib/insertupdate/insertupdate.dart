import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_example/insertupdate/insertupdate_bloc.dart';
import 'package:sqflite_example/model/product.dart';
import 'package:sqflite_example/util/SnackBarUtil.dart';

class InsertUpdateLayout extends StatelessWidget{
  final InsertUpdateBloc _bloc = InsertUpdateBloc();
  final Product product;

  InsertUpdateLayout(this.product);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context){   
    String title = '';
    if(product.getId() == 0){
      title = "Insert";      
    }
    else{
      title = "Update";
      nameController.text = product.getName();
      qtyController.text = product.getQty().toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLite"),
      ),
      body: Builder(
        builder: (context) => Padding(         
          padding: EdgeInsets.all(20.0),                       
          child: Column(              
            children: <Widget>[
              Container(                  
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Name"
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Quantity"                            
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => onSave(context),
                        child: Text("Save"),
                      )
                    ],
                  )
                ),
              )
            ],
          ),          
        )
      )
    );
  }

  void onSave(BuildContext context) async {
    String name = nameController.text;
    String qty = qtyController.text;    

    if(name != "" && qty != ""){
      int result = -1;
      Product product = Product().setName(name).setQty(int.parse(qty));
      if(this.product.getId() == 0){
        // INSERT
        product.setId(0);
        result = await _bloc.addProduct(product);      
      }      
      else{
        // UPDATE
        product.setId(this.product.getId());
        result = await _bloc.updateProduct(product);
      }

      if(result > 0){
        Navigator.pop(context);
      }
      else{
        SnackBarUtil.errorSnackBar(context);
      }
    }
    else{
      SnackBarUtil.showSnackbar(context, "Please fill all the field");
    }
  }
}