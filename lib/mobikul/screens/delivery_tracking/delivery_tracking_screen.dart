import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

import '../../../main.dart';
import '../../app_widgets/app_bar.dart';
import '../../configuration/mobikul_theme.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../helper/app_localizations.dart';
import '../../helper/utils.dart';
import '../../models/deliveryBoyDetails/delivery_boy_details_model.dart';




class DeliveryTrackingScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  final AssignedDeliveryBoyDetails? assignedDeliveryBoyDetails;
  DeliveryTrackingScreen({Key? key,this.args,this.assignedDeliveryBoyDetails}) : super(key: key);

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  AppLocalizations? localization;
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng? sourceLocation;
  static LatLng destination = LatLng(28.6271582, 77.3769473);
  List<LatLng> polylineCoordinates = [];
  LatLng? deliveryBoyLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor deliveryBoyIcon = BitmapDescriptor.defaultMarker;
  int i=0;

  @override
  void initState() {
    sourceLocation = LatLng(double.parse(widget.assignedDeliveryBoyDetails?.warehouseLat ?? ""), double.parse(widget.assignedDeliveryBoyDetails?.warehouseLong ?? ""));
    deliveryBoyLocation = LatLng(widget.assignedDeliveryBoyDetails?.deliveryBoyLat ?? 28.6271582, widget.assignedDeliveryBoyDetails?.deliveryBoyLong ?? 77.3769473);
    setCustomMarkerIcon();
    fetchCoordinates();
    startTracking();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    localization = AppLocalizations.of(context);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:commonAppBar(
          Utils.getStringValue(context, AppStringConstant.trackOrder), context,
        ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation!,
          zoom: 13.5,
        ),
        markers: {
          if(sourceLocation != null)
          Marker(
            markerId: MarkerId("source"),
            position: sourceLocation!,
            icon: sourceIcon,
          ),
          Marker(
            icon: destinationIcon,
            markerId: const MarkerId("destination"),
            position: destination,
          ),
          if(deliveryBoyLocation !=null)
          Marker(
            icon: deliveryBoyIcon,
            markerId: const MarkerId("deliveryboy"),
            position: deliveryBoyLocation!,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: MobikulTheme.accentColor,
            width: 8,
          ),
        },
      ),
    );
  }

  void getPolyPoints() async {

    /*PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDYwUZZe8puCOem7I5WR3gkuU7c9F3Zciw",
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );*/

    PolylinePoints polylinePoints = PolylinePoints(apiKey: "AIzaSyDYwUZZe8puCOem7I5WR3gkuU7c9F3Zciw");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );

    print("-------${result}");
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/source_pin.png")
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/destination_pin.png")
        .then(
          (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/delivery_pin.png")
        .then(
          (icon) {
        deliveryBoyIcon = icon;
      },
    );
  }

  fetchCoordinates() async{
    print("----${widget.assignedDeliveryBoyDetails?.shippingAddress}");
    List<Location> locations = await locationFromAddress(widget.assignedDeliveryBoyDetails?.shippingAddress??"" );

    print("LOCATIONS-->${locations}");
    if(locations.isNotEmpty){
      Location location = locations.first;
      destination = LatLng(location.latitude,location.longitude);
    }

    String warehouseAddress = widget.assignedDeliveryBoyDetails?.warehouse??'';
    String wareHouseLatitude = widget.assignedDeliveryBoyDetails?.warehouseLat??'';
    String wareHouseLongitude = widget.assignedDeliveryBoyDetails?.warehouseLong??'';
    print("wareHouseLatitude is: ${wareHouseLatitude}");
    print("wareHouseLongitude is: ${wareHouseLongitude}");
    if(wareHouseLatitude.isNotEmpty && wareHouseLongitude.isNotEmpty){
      sourceLocation = LatLng(double.parse(wareHouseLatitude),double.parse(wareHouseLongitude));
      print("sourceLocation is: ${sourceLocation}");
    }else{
      List<Location> locations = await locationFromAddress(warehouseAddress);
      print("LOCATIONS-->${locations}");
      if(locations.isNotEmpty){
        Location location = locations.first;
        sourceLocation = LatLng(location.latitude,location.longitude);
      }
    }
    if(mounted) {
      getPolyPoints();
      setState(() {});
    }
  }
  void startTracking() async {
    secondaryDatabase.ref().child('DeliveryApp/locationData/${widget.assignedDeliveryBoyDetails?.id}').onValue.listen((event) {
      print("EVENTDATA-->${event.snapshot.value}");
      if(event.snapshot.value!=null){
        Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
        LatLng latLng = LatLng(data['latitude'],data['longitude']);
        print("LATLNG-->${latLng}");
        deliveryBoyLocation = latLng;
      }
    });
    if(mounted){
      setState(() {});
    }
    Future.delayed(Duration(seconds: 2), () {
      startTracking();
    });

  }



}

