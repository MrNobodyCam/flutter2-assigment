import '../model/ride/locations.dart';

abstract class LocationsRepository {
  List<Location> getLocations();
  void addLocation(Location location);
}
