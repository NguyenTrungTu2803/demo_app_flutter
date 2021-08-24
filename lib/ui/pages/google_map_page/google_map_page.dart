

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_app_beats/data_model/directions_model.dart';
import 'package:flutter_app_beats/repository/services/directions_service.dart';

class GoogleMapPage extends StatefulWidget {
  final String address;
  final double lat;
  final double long;
  GoogleMapPage({Key? key,required  this.address,required  this.lat,required  this.long}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  late Marker _origin;
  late Marker _destination;
  late Set<Marker> _markers = {};
  List<LatLng> polylineCoordinates = [];
  late GoogleMapController _googleMapController;
  late Directions _info;

  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  double cameraZoom = 13.5;
  double cameraTilt = 0;
  double cameraBearing = 30;
  var sourceLocation;
  late LatLng destLocation;
  Location location = Location();

  @override
  void initState() {
    destLocation  = LatLng(widget.lat,widget.long);
    print(widget.lat);
    print(widget.long);
      location.requestPermission().then((granted) {
        setState(() {
          if (granted != null) {
            location.onLocationChanged.listen((locationData) {
              if (locationData != null) {
                sourceLocation =
                    LatLng(locationData.latitude!.toDouble(), locationData.longitude!.toDouble());
              } else {
                sourceLocation = destLocation;
              }
              setMapPins(sourceLocation);
            }).onError((handleError) {});
          }
        });
      }).catchError((onError) {});
    setSourceAndDestinationIcons();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _initialCameraPosition = CameraPosition(
      target: LatLng(10.845030, 106.643066),
      zoom: 11.5,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.red, statusBarIconBrightness: Brightness.light,),
        title: const Text('Map Destination'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                   CameraPosition(
                    target: sourceLocation,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: destLocation,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onLongPress: setMapPins,
              markers: _markers != null ? _markers : {},
              polylines: {
                if (_info != null)
                  Polyline(
                    polylineId: PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: _info.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller),
          if (_info != null)
            Positioned(
              top: 20.0,
              left: MediaQuery.of(context).size.width/2.5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration:  BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius:  BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Colors.white,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/icons/driving_pin.png");
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/icons/destination_map_marker.png");
  }
  void setMapPins(LatLng pos) async {
    //setState(() {
      _origin = Marker(
        markerId: MarkerId('sourcePin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        //sourceIcon,
        position: sourceLocation,
      );
      // Reset destination
      _destination = Marker(
        markerId: MarkerId('destPin'),
        infoWindow: const InfoWindow(title: 'Destination'),
        position: destLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      );
      _markers.add(_origin);
      _markers.add(_destination);
    //});
    final directions =  await DirectionsRepository()
        .getDirections(origin: _origin.position, destination: destLocation);
    setState(() => _info = directions!);
  }

}
// void setSourceAndDestinationIcons() async {
//   sourceIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       "assets/icons/driving_pin.png");
//   destinationIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       "assets/icons/destination_map_marker.png");
// }
class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}

