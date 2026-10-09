import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/blood_banks_provider.dart';
import '../../../core/config/app_config.dart';

class BanksMapScreen extends StatelessWidget {
  const BanksMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banks Map')),
      body: Consumer<BloodBanksProvider>(
        builder: (context, provider, child) {
          final markers = provider.banks.where((b) => b.lat != null && b.lng != null).map((bank) {
            return Marker(
              markerId: MarkerId(bank.id),
              position: LatLng(bank.lat!, bank.lng!),
              infoWindow: InfoWindow(title: bank.name, snippet: bank.phone),
            );
          }).toSet();

          if (kDemoMode) {
            // Real map needs a Google Maps API key, so show a simple list in demo mode.
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.map_outlined),
                    title: Text('Map preview (demo mode)'),
                    subtitle: Text('The real map needs a Google Maps API key.'),
                  ),
                ),
                ...provider.banks.map(
                  (b) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.red),
                      title: Text(b.name),
                      subtitle: Text('${b.city} • ${b.lat?.toStringAsFixed(3)}, ${b.lng?.toStringAsFixed(3)}'),
                    ),
                  ),
                ),
              ],
            );
          }

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357), // Default Cairo
              zoom: 10,
            ),
            markers: markers,
            myLocationEnabled: true,
          );
        },
      ),
    );
  }
}
