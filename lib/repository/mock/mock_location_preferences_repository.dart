import 'package:flutter2_assignment/model/ride/locations.dart';
import 'package:flutter2_assignment/repository/location_repository.dart';

class MockLocationPreferencesRepository extends LocationsRepository {
  final List<Location> _locations = [
    const Location(name: 'Phnom penh', country: Country.cambodia),
    const Location(name: 'Siem Reap', country: Country.cambodia),
    const Location(name: 'Battambang', country: Country.cambodia),
    const Location(name: 'Sihaknoukville', country: Country.cambodia),
    const Location(name: 'Kampot', country: Country.cambodia),
  ];

  @override
  List<Location> getLocations() {
    return _locations;
  }

  @override
  void addLocation(Location location) {
    _locations.add(location);
  }
}
