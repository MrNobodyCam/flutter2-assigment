import '../repository/location_repository.dart';
import '../model/ride/locations.dart';

class LocationsService {
  static LocationsService? _instance;
  final LocationsRepository repository;

  LocationsService._internal(this.repository);

  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
          "LocationsService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Location> get availableLocations {
    return repository.getLocations();
  }
}
