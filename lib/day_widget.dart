import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//-------------------------------------------------------------
class DayWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final Map<String,String> rutas;
  final Map<String,String> hora1;
  final Map<String,String> hora2;

  DayWidget({Key key, this.documents})
    :   
    hora1=documents.fold({}, (Map<String, String>map,document){
      if(!map.containsKey(document['RoutNumber'])){
        map[document['RoutNumber']]='';
      }
      map[document['RoutNumber']]=document['Hour1'];
      return map;
    }),

    hora2=documents.fold({}, (Map<String, String>map,document){
      if(!map.containsKey(document['RoutNumber'])){
        map[document['RoutNumber']]='';
      }
      map[document['RoutNumber']]=document['Hour2'];
      return map;
    }),

    rutas=documents.fold({}, (Map<String,String> map,document){
      if(!map.containsKey(document['RoutNumber'])){
        map[document['RoutNumber']]='';
      }
      map[document['RoutNumber']]+=document['Streets'];
      return map;
    }),

    super(key:key);
  @override
  _DayWidgetState createState() => _DayWidgetState();
}
//-------------------------------------------------------------
class _DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.hora1);//eliminar
    return Expanded(
          child: Column(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Color.fromRGBO(56, 39, 180,0.3),Color.fromRGBO(56, 39, 180,0.1)]
          //     )
          //   ),
          //   height: 10.0,
          // ),
          _list(),
        ],
      ),
    );
  }

  Widget _list(){
    return Expanded(
      child: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: widget.rutas.keys.length,
          itemBuilder: (BuildContext context, int index){
            var key=widget.rutas.keys.elementAt(index);
            var data=widget.rutas[key];
            var hora01=widget.hora1[key];
            var hora02=widget.hora2[key];
            return _item(hora01,hora02,data);
          },
          padding: EdgeInsets.only(bottom: 5.0,top:0.0,),
        ),
      ),
    );
  }

  Widget _item(String hour1,String hour2,String streets){
    return Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Hora',style: TextStyle(fontFamily: 'Quicksand Bold',fontSize: 15.0),),
                    Text(
                      hour1,
                      style: TextStyle(color: Colors.grey[600],fontSize: 14.0),
                    ),
                    Text(hour2,style: TextStyle(color: Colors.grey[600],fontSize: 14.0),),
                  ],
                ),
                title: Text('Calles referenciales',style: TextStyle(fontFamily: 'Quicksand Bold',fontSize: 15.0),),
                subtitle: Text(streets,style: TextStyle(fontSize: 14.0),),
                // trailing: Column(
                //   children: <Widget>[
                //     Text('Vehículo'),
                //     Text(vehicle),
                //   ],
                // ),
                isThreeLine: true,
              ),
              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(4.0),bottomRight:Radius.circular(4.0) ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color.fromRGBO(56, 39, 180,0.7),Color.fromRGBO(108, 24, 164, 0.7)]
                    )
                    
                ),
                child: MaterialButton(
                  child: Text('Ver mapa',
                  style: TextStyle(color: Colors.white,fontSize: 13.0,),
                  ),
                  onPressed: (){

                  },
                ),
              ),
            ],
          ),
    );
  }
  
}