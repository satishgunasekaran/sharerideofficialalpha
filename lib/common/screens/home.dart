// ignore_for_file: prefer_collection_literals, unnecessary_new, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../requests/google_maps_requests.dart';
import '../states/app_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_place/google_place.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var googlePlace = GooglePlace("AIzaSyDWXI9gjfdLIDm0j-C61Yx6IMbhPJnk4u4");
  List<AutocompletePrediction> predictions = [];
  TextEditingController _searchtextEditingController =
      new TextEditingController();
  static const kGoogleApiKey = '21f0ccee8ba744d09c0147e76965e3f9';

  late CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
  }

  void autoCompleteSearch(String value) async {
    print(value);

    try {
      var result = await googlePlace.autocomplete.get(value);
      if (result != null && result.predictions != null && mounted) {
        print(result.predictions!.first.description);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    var locationController;
    return appState.initialPosition != null
        ? Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: appState.initialPosition!, zoom: 10.0),
                onMapCreated: appState.onCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                markers: appState.markers,
                onCameraMove: appState.onCameraMove,
                polylines: appState.polyLines,
              ),

              /* ###### Input Tags  ###### */

              Positioned(
                top: 50.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: appState.locationController,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 10),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Pick up",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 5.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 105.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ]),
                  child: TypeAheadField(
                    noItemsFoundBuilder: (context) => const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text('No Item Found'),
                      ),
                    ),
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      elevation: 4.0,
                    ),
                    debounceDuration: const Duration(milliseconds: 400),
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: _searchtextEditingController,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(
                            //   3.0,
                            // )),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(3.0),
                              ),
                              // borderSide: BorderSide(color: Colors.black)
                            ),
                            hintText: "    Search",
                            contentPadding:
                                const EdgeInsets.only(top: 4, left: 10),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search,
                                    color: Colors.grey)),
                            fillColor: Colors.white,
                            filled: true)),
                    suggestionsCallback: (value) {
                      return _handlePressButton(value);
                    },
                    itemBuilder: (context, String suggestion) {
                      return Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.refresh,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                suggestion,
                                maxLines: 1,
                                // style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    onSuggestionSelected: (String suggestion) {
                      setState(() {
                        // userSelected = suggestion;
                        _searchtextEditingController.text = suggestion;
                        setState(() {});
                      });
                    },
                  ),
                ),
              ),
              /*  Positioned(
                top: 40,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () {},
                  tooltip: "add marker",
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.add_location,
                    color: Colors.white,
                  ),
                ),
              )
            */
            ],
          )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitRotatingCircle(
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                    visible: appState.locationServiceActive == false,
                    child: Text(
                      "\nPlease enable location services!\n\nAnd Kindly restart the application",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ))
              ],
            ),
          );
  }

  Future<List<String>> _handlePressButton(value) async {
    String url =
        "https://api.geoapify.com/v1/geocode/autocomplete?text=${value}&apiKey=${kGoogleApiKey}";
    print(url);
    Response response = await get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    List placeFormattedList = [];
    List latLngList = [];
    for (var item in values["features"]) {
      latLngList
          .add(LatLng(item["properties"]["lat"], item["properties"]["lon"]));
      placeFormattedList.add(item["properties"]["formatted"]);
    }

    List<String> menuItems = [];

    for (var i = 0; i < placeFormattedList.length; i++) {
      // menuItems.add({"name": placeFormattedList[i], "latlng": latLngList[i]});
      menuItems.add(placeFormattedList[i]);
    }

    return menuItems;

    // setState(() {
    //   _myKey.currentState!.updateItems(menuItems, latLngList);
    // });
  }
}
