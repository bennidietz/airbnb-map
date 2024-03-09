import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../network/model/place.dart';
import '../../network/test.dart';
import '../../utils/url_utils.dart';

class PlaceDialog extends StatelessWidget {
  const PlaceDialog({
    super.key,
    required this.place,
  });

  final MyPlace place;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Wrap(
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      place.icon ?? place.stringIcon,
                      style: const TextStyle(
                        fontSize: 35.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                Text(
                  place.description,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                (place.imageUrl != null) ? Image.network(place.imageUrl!) : const SizedBox(),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                (place.website != null)
                    ? ElevatedButton(
                        onPressed: () => openUrl(place.website!), child: const Text('🌎  Mehr Informationen'))
                    : const SizedBox(),
                const SizedBox(
                  height: defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () => MapsLauncher.launchCoordinates(place.latitude, place.longitude),
                  child: const Text('Route hierhin starten'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
