import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class BottleMap extends StatefulWidget {
  @override
  BottleMapState createState() => BottleMapState();
}

class BottleMapState extends State<BottleMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Center(child: Text("Botellas de Plástico")),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          Text('Puntos de Acopio',),
          // _zoomminusfunction(),
          // _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  // Widget _zoomminusfunction() {

  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: IconButton(
  //         icon: Icon(FontAwesomeIcons.searchMinus,color:Color(0xff6200ee)),
  //         onPressed: () {
  //           zoomVal--;
  //           _minus( zoomVal);
  //         }),
  //   );
  // }
  // Widget _zoomplusfunction() {

  //   return Align(
  //     alignment: Alignment.topCenter,
  //     child: IconButton(
  //         icon: Icon(FontAwesomeIcons.searchPlus,color:Color(0xff6200ee)),
  //         onPressed: () {
  //           zoomVal++;
  //           _plus(zoomVal);
  //         }),
  //   );
  // }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(-15.8422003, -70.0198975), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(-15.8422003, -70.0198975), zoom: zoomVal)));
  }


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.iperu.org/wp-content/uploads/2016/01/parque-pino.jpg",
                  -15.837966, -70.028057,"Punto N° 01","Parque Pino",),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
                  -15.832614, -70.024279,"Punto N° 02","Bellavista"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.diariosinfronteras.pe/wp-content/uploads/2019/05/WhatsApp-Image-2019-05-27-at-10.09.11-15.jpg",
                  -15.840297, -70.022089, "Punto N° 03", "Plaza de Armas Puno"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName,String description) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0),),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName,description),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName,String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        // Container(
        //       child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       Container(
        //           child: Text(
        //         "4.1",
        //         style: TextStyle(
        //           color: Colors.black54,
        //           fontSize: 18.0,
        //         ),
        //       )),
        //       Container(
        //         child: Icon(
        //           FontAwesomeIcons.solidStar,
        //           color: Colors.amber,
        //           size: 15.0,
        //         ),
        //       ),
        //       Container(
        //         child: Icon(
        //           FontAwesomeIcons.solidStar,
        //           color: Colors.amber,
        //           size: 15.0,
        //         ),
        //       ),
        //       Container(
        //         child: Icon(
        //           FontAwesomeIcons.solidStar,
        //           color: Colors.amber,
        //           size: 15.0,
        //         ),
        //       ),
        //       Container(
        //         child: Icon(
        //           FontAwesomeIcons.solidStar,
        //           color: Colors.amber,
        //           size: 15.0,
        //         ),
        //       ),
        //       Container(
        //         child: Icon(
        //           FontAwesomeIcons.solidStarHalf,
        //           color: Colors.amber,
        //           size: 15.0,
        //         ),
        //       ),
        //        Container(
        //           child: Text(
        //         "(946)",
        //         style: TextStyle(
        //           color: Colors.black54,
        //           fontSize: 18.0,
        //         ),
        //       )),
        //     ],
        //   )),
        //   SizedBox(height:5.0),
        // Container(
        //           child: Text(
        //         "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
        //         style: TextStyle(
        //           color: Colors.black54,
        //           fontSize: 18.0,
        //         ),
        //       )),
        //       SizedBox(height:5.0),
        Container(
            child: Text(description,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        compassEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(-15.8422003, -70.0198975), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          newyork1Marker,newyork2Marker,newyork3Marker,gramercyMarker,bernardinMarker,blueMarker
        },
        myLocationEnabled: true,

      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 18,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(-15.837966, -70.028057),
  infoWindow: InfoWindow(title: 'Parque Pino'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(-15.832614, -70.024279),
  infoWindow: InfoWindow(title: 'Bellavista'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(-15.840297, -70.022089),
  infoWindow: InfoWindow(title: 'Ovalo Ramón Castilla'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(-15.837854,-70.027234),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(-15.839443, -70.025904),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(-15.835661, -70.028656),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);