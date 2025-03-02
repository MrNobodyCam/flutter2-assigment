import 'package:flutter/material.dart';
import 'package:flutter2_assignment/screens/ride_pref/rides_screen.dart';
import 'package:flutter2_assignment/widgets/action/bla_button.dart';
import 'package:flutter2_assignment/widgets/input/bla_location_picker.dart';
import 'package:flutter2_assignment/widgets/input/bla_seatSpinner.dart';
import 'package:flutter2_assignment/widgets/action/bla_tappable_pref_row.dart';
import 'package:flutter2_assignment/utils/animations_util.dart';

import '../../../model/ride/locations.dart';
import 'package:intl/intl.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  void _validateAndSearch() {
    if (departure == null) {
      _navigateLocation(true);
      return;
    }
    if (arrival == null) {
      _navigateLocation(false);
      return;
    }
    if (requestedSeats <= 0) {
      Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          const Scaffold(
            body: SeatNumberSpinner(),
          ),
        ),
      );
      return;
    }
    if (departure != null && arrival != null) {
      Navigator.push(
        context,
        AnimationUtils.createRightToTopLeft(
          const Scaffold(
            body: RidesScreen(),
          ),
        ),
      );
    }
  }

  Future<void> _navigateLocation(bool isDeparture) async {
    final returnedData = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(const LocationPicker()),
    );

    if (returnedData != null) {
      setState(() {
        if (isDeparture) {
          departure = returnedData;
        } else {
          arrival = returnedData;
        }
      });
    }
  }

  Future<void> _navigateSeat() async {
    final returnedData = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute(const SeatNumberSpinner()),
    );

    if (returnedData != null) {
      setState(() {
        requestedSeats = returnedData;
      });
    }
  }

  void _swapLocations() {
    if (departure != null && arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 400,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TappablePrefRow(
                  text: departure == null ? "Leaving from" : "$departure",
                  swapShow: true,
                  isInput: departure == null ? false : true,
                  icon: const Icon(Icons.circle_outlined),
                  onPressedSwap: _swapLocations,
                  // onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     AnimationUtils.createBottomToTopRoute(
                  //       const Scaffold(
                  //         body: LocationPicker(),
                  //       ),
                  //     ),
                  //   );
                  // },
                  onPressed: () {
                    _navigateLocation(true);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TappablePrefRow(
                  text: arrival == null ? "Going to" : "$arrival",
                  swapShow: false,
                  isInput: arrival == null ? false : true,
                  icon: const Icon(Icons.circle_outlined),
                  onPressed: () {
                    _navigateLocation(false);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TappablePrefRow(
                  text: DateFormat('EEE dd MMM').format(DateTime.now()),
                  swapShow: false,
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {
                    // To Do
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TappablePrefRow(
                  text: "$requestedSeats",
                  swapShow: false,
                  icon: const Icon(Icons.person_outlined),
                  hasborder: false,
                  onPressed: () {
                    _navigateSeat();
                  },
                ),
                BlaButton(
                  buttonType: ButtonType.secondary,
                  text: "Search",
                  onPressed: () {
                    _validateAndSearch();
                  },
                )
              ]),
        ),
      ),
    );
  }
}
