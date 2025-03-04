import 'package:flutter/material.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePreference get currentPreference =>
      RidePrefService.instance.currentPreference ??
      fakeRidePrefs[0]; // TODO 1 :  We should get it from the service

  List<Ride> get matchingRides => RidesService.instance.getRidesFor(
      currentPreference,
      null,
      RideSortType
          .departureDate); // TODO 2 :  We should get it from the service

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    final newPreference = await showModalBottomSheet<RidePreference>(
      context: context,
      builder: (context) => RidePrefModal(initialPreference: currentPreference),
    );

    if (newPreference != null) {
      setState(() {
        RidePrefService.instance.setCurrentPreference(newPreference);
      });
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed),

          Expanded(
            child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) {
                  return RideTile(
                    ride: matchingRides[index],
                    onPressed: () {
                      // TODO 3 :  We should navigate to the ride details screen
                    },
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
