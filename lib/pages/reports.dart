import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recyclean_03/category_selection_widget.dart';

class Reports extends StatefulWidget {
  Reports({Key key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String category;
  String userName;
  String id;
  String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Reportar una incidencia',style: TextStyle(color: Color.fromRGBO(12, 20, 61, 1.0),),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey,),
            onPressed:(){
              Navigator.of(context).pop();
            } ,
          )
        ],
      ),
      body: _body(),
      bottomNavigationBar: _submit(),
    );
  }

  Widget _body(){
     return ListView(
         children: <Widget>[
           _categorySelector(),
           _userData(),
           _problemDescription(),
           _addPhoto(),
         ],
     );
  }

   Widget _categorySelector(){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Container(child: Text('Tipo de Incidencia')),
           Container(
             height: 80.0,
             child: CategorySelectorWidget(
               categories:{
                 'Basura en\nCalle':Icons.closed_caption,
                 'Tipo02':Icons.close,
                 'Tipo03':Icons.close,
                 'Tipo04':Icons.close,
                 'Tipo05':Icons.close,
                 'Tipo06':Icons.close,
               },
               onValueChanged: (newCategory)=>category=newCategory,
             ),
           ),
         ],
     );
   }
   Widget _userData(){
     return Column();
   } 
   Widget _problemDescription() =>Placeholder(fallbackHeight: 100,);
   Widget _addPhoto() =>Placeholder(fallbackHeight: 100,);
   Widget _submit(){
     return BottomAppBar(
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color.fromRGBO(56, 39, 180,1.0),Color.fromRGBO(108, 24, 164, 1.0)]
            )
          ),
          child: MaterialButton(
            child: Text(
              'Enviar Reporte',
              style: TextStyle(color: Colors.white,fontSize: 15.0),
            ),
            onPressed: (){

            },
          ),
        ),
        
      );
   }

}