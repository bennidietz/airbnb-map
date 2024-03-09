import 'package:airbnb_map/network/repository/google_sheet_repository.dart';
import 'package:airbnb_map/presentation/widgets/place_dialog.dart';
import 'package:airbnb_map/utils/url_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../injection.dart';
import '../../network/model/place.dart';
import '../../utils/map_utils.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final linkStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent);
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Verantwortlich für die Inhalte:\n', style: Theme.of(context).textTheme.headlineSmall),
                const TextSpan(text: 'Volker Dietz\nAm Wiebusch 4\n44225 Dortmund\n\n'),
                TextSpan(text: 'Appartment buchen:\n', style: Theme.of(context).textTheme.headlineSmall),
                TextSpan(
                  text: 'Apartment auf Airbnb buchen.\n\n',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(Uri.parse('https://www.airbnb.de/rooms/1097766389719277790')),
                  style: linkStyle,
                ),
                TextSpan(text: 'Web-Entwicklung:\n', style: Theme.of(context).textTheme.headlineSmall),
                TextSpan(
                  text: 'Webseite realisiert durch ',
                  children: [
                    TextSpan(
                      text: '21vision',
                      recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse('https://21-vision.de')),
                      style: linkStyle,
                    ),
                    const TextSpan(text: '. Projektanfragen bitte an '),
                    TextSpan(
                      text: 'contact@21-vision.de.\n\n',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(Uri.parse('mailto:contact@21-vision.de')),
                      style: linkStyle,
                    ),
                  ],
                ),
                TextSpan(text: 'Haftungsausschluss:\n', style: Theme.of(context).textTheme.headlineSmall),
                const TextSpan(
                    text:
                        'Die Inhalte dieser Seiten wurden mit größter Sorgfalt zusammengestellt. Dennoch können wir keine Gewähr für die ständige Richtigkeit und Vollständigkeit aller Angaben übernehme Information. Unsere Website enthält Links zu Websites außerhalb unseres Angebots. Da die Inhalte dieser Websites Dritter außerhalb unserer Kontrolle liegen, können wir dies nicht tun dafür haftbar gemacht werden. Für den Inhalt der verlinkten Seiten ist stets der Betreiber selbst verantwortlich mit dem Anbieter oder Betreiber dieser Seiten.'),
              ])),
              /*Markdown(
                data: '''
### Verantwortlich für die Inhalte:
Volker Dietz
Am Wiebusch 4\
44225 Dortmund

### Web-Entwicklung



## Haftungsausschluss



                        '''
                    .toString(),
                shrinkWrap: true,
              ),*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => openUrl('https://21-vision.de'),
          child: Container(
            color: Colors.white.withOpacity(.5),
            padding: const EdgeInsets.all(8),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  text: 'Made by 21vision with ❤\n️',
                  children: [
                    TextSpan(text: '©2024 21vision GmbH'),
                  ],
                  style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0x88000000),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'Apartment über 2 Etagen nahe BVB-Stadion und Messe',
          style: TextStyle(color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: sl<GoogleSheetsRepository>().getData(),
        builder: (BuildContext context, AsyncSnapshot<List<MyPlace>> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return FlutterMap(
            options: MapOptions(
              initialCameraFit: CameraFit.insideBounds(
                bounds: LatLngBounds(LatLng(snapshot.data!.first.latitude, snapshot.data!.first.longitude),
                    LatLng(snapshot.data!.first.latitude, snapshot.data!.first.longitude)),
                minZoom: 12,
                maxZoom: 13,
              ),
            ),
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              PopupMarkerLayer(
                options: PopupMarkerLayerOptions(
                  markers: MapUtils.getMarkers(snapshot.data ?? []),
                  onPopupEvent: (event, markers) {
                    MyPlace? place = getPlaceForLatLng(markers.first.point, snapshot.data ?? []);
                    if (place != null) {
                      showDialog(
                        context: context,
                        builder: (context) => PlaceDialog(
                          place: place,
                        ),
                      );
                      /*showModalBottomSheetWithWrapper(
                        context: context,
                        children: [
                          ExamplePopup(place),
                        ],
                        options: BottomSheetOptions(
                          topLabel: place.name,
                          specifiedPercentageHeight: .9,
                          isScrollControlled: false,
                          withAnimationDuration: const Duration(seconds: 1),
                        ),
                      );*/
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  MyPlace? getPlaceForLatLng(LatLng latLng, List<MyPlace> myPlaces) {
    print(myPlaces.length);
    for (MyPlace myPlace in myPlaces) {
      if (myPlace.latitude.toStringAsExponential(3) == latLng.latitude.toStringAsExponential(3) &&
          myPlace.longitude.toStringAsExponential(3) == latLng.longitude.toStringAsExponential(3)) {
        return myPlace;
      }
    }
    return null;
  }
}
