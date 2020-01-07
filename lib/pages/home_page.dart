import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recyclean_03/day_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _controller;
  int currentPage=DateTime.now().weekday-1;
  Stream<QuerySnapshot> _query;
//-------------------------------------------------------------
  @override
  void initState() { 
    super.initState();

    _query=Firestore.instance
    .collection('rutaCompactador')
    .where('Day', isEqualTo: currentPage+1)
    .snapshots();

    _controller=PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }
//-------------------------------------------------------------
  Widget _bottomAction(IconData icon,String routeNavigator,String name){
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,size: 26,color: Color.fromRGBO(56, 39, 180, 1.0),),
              Text(name,style: TextStyle(fontSize: 10.0,fontFamily: 'Quicksand Bold',color: Color.fromRGBO(56, 39, 180, 1.0),),),
            ],
          ),
        ),
      onTap: (){
        Navigator.of(context).pushNamed(routeNavigator);
      },
    );
  }
  Widget _bottomAction2(String imgLocation, String routeNavigator,String name){
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(imgLocation,color: Color.fromRGBO(56, 39, 180, 1.0),height: 30,),
              Text(name,style: TextStyle(fontSize: 10.0,fontFamily: 'Quicksand Bold',color: Color.fromRGBO(56, 39, 180, 1.0),),),
            ],
          ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(routeNavigator);
      },
    );
  }
  //-------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomBar(),
      body: _body(),
    );
  }
  //-------------------------------------------------------------
  Widget _appBar(){
    return AppBar(
      backgroundColor: Color.fromRGBO(56, 39, 180, 1.0),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: (){},
      ),
      title: Center(child: Text('Recyclean',style: TextStyle(fontSize: 26.0,fontFamily: 'Pacifico Regular'),)),
      actions: <Widget>[
          IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: (){},
        ),
      ],
    );
  }
  //-------------------------------------------------------------
  Widget _body(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          StreamBuilder<QuerySnapshot>(
            stream: _query,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data){
              if(data.hasData){
                return DayWidget(
                  documents:data.data.documents,
                );
              }
              return Center(
              child: CircularProgressIndicator(),
              );
            },
            
          ),
        ],
      ),
    );
  }
  //-------------------------------------------------------------
  Widget _bottomBar(){
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _bottomAction2('assets/compactador.svg','','Compactador'),
          _bottomAction2('assets/baranda.svg','','Baranda'),
          _bottomAction(Icons.map,'','Botellas'),
          _bottomAction(Icons.textsms,'/reports','Reportes'),
        ],
      ),
    );
  }
//-------------------------------------------------------------
  Widget _pageItem(String nombre, int position){

    var _aligment;
    final selected=TextStyle(
      fontSize: 18.0,
      // fontFamily: 'Quicksand Bold',
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(56, 39, 180, 1.0),
    );
    final unselected=TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(56, 39, 180, 0.5),
    );

    if(position==currentPage){
      _aligment=Alignment.center;
    }else if(position>currentPage){
      _aligment=Alignment.centerRight;
    }else{
      _aligment=Alignment.centerLeft;
    }
    return Align(
      alignment: _aligment,
      child: Text(nombre,
        style: position==currentPage?selected:unselected,
      )
    );
  }
  //-------------------------------------------------------------
  Widget _selector(){
    return SizedBox.fromSize(
      size: Size.fromHeight(40.0),
        child: Container(
          color: Colors.white,
          child: PageView(
            onPageChanged: (newPage){
              setState(() {
                currentPage=newPage; 
                  _query=Firestore.instance
                  .collection('rutaCompactador')
                  .where('Day', isEqualTo: currentPage+1)
                  .snapshots();
              });
            },
            controller: _controller,
            children: <Widget>[
              _pageItem('Lunes',0),
              _pageItem('Martes',1),
              _pageItem('Miércoles',2),
              _pageItem('Jueves',3),
              _pageItem('Viernes',4),
              _pageItem('Sábado',5),
              _pageItem('Domingo',6),
            ],
      ),
        ),
    );
  }
}