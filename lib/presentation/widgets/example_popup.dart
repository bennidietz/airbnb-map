import 'package:airbnb_map/presentation/widgets/place_dialog.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../network/model/place.dart';

class ExamplePopup extends StatefulWidget {
  final MyPlace myPlace;

  const ExamplePopup(this.myPlace, {super.key});

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Text(
                widget.myPlace.stringIcon,
                style: const TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
            _cardDescription(context, widget.myPlace),
            IconButton(
                icon: const Icon(Icons.navigation_outlined),
                onPressed: () => MapsLauncher.launchCoordinates(widget.myPlace.latitude, widget.myPlace.longitude))
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context, MyPlace place) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              place.name,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            if (place.from != null) ...[
              Text(
                'von ${place.from}',
                style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            ],
            SizedBox(
              width: 150,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => PlaceDialog(
                      place: widget.myPlace,
                    ),
                  );
                },
                child: const Text('Mehr Details'),
              ),
              // child: Text(
              //   place.description,
              //   style: const TextStyle(fontSize: 14.0),
              //   overflow: TextOverflow.ellipsis,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
