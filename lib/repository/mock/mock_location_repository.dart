import 'package:flutter2_assignment/model/ride/locations.dart';
import 'package:flutter2_assignment/repository/location_repository.dart';

import '../../dummy_data/dummy_data.dart';

class MockLocationPreferencesRepository extends LocationsRepository {
  final List<Location> _fakeLocation = fakeLocations;

  @override
  List<Location> getLocations() {
    return _fakeLocation;
  }

  @override
  void addLocation(Location location) {
    _fakeLocation.add(location);
  }
}
