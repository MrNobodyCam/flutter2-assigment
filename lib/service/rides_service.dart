import 'package:flutter2_assignment/repository/ride_repository.dart';

import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - The list of available rides
///
enum RideSortType {
  departure,
  departureDate,
  arrival,
  requestedSeats,
}

class RidesService {
  static RidesService? _instance;
  final RidesRepository repository;

  RidesService._internal(this.repository);

  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  static void reset() {
    _instance = null;
  }

  List<Ride> getRidesFor(
      RidePreference preferences, RidesFilter? filter, RideSortType? sortType) {
    return repository.getRides(preferences, filter, sortType);
  }
}

class RidesFilter {
  final bool acceptPet;
  RidesFilter({required this.acceptPet});
}
