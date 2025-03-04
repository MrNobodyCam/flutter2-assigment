import '../../dummy_data/dummy_data.dart';
import '../../model/ride/locations.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../ride_repository.dart';

class MockRidesRepository implements RidesRepository {
  final List<Ride> _rides = fakeRides;

  @override
  List<Ride> getRides(
      RidePreference preference, RidesFilter? filter, RideSortType? sortType) {
    List<Ride> filteredRides = _rides.where((ride) {
      bool matches = ride.departureLocation.name == preference.departure.name &&
          ride.arrivalLocation.name == preference.arrival.name &&
          ride.availableSeats >= preference.requestedSeats;
      if (filter != null) {
        matches = matches && ride.petAccepted == filter.acceptPet;
      }
      return matches;
    }).toList();

    if (sortType != null) {
      switch (sortType) {
        case RideSortType.departure:
          filteredRides
              .sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.departureDate:
          filteredRides
              .sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.arrival:
          filteredRides
              .sort((a, b) => a.arrivalDateTime.compareTo(b.arrivalDateTime));
          break;
        case RideSortType.requestedSeats:
          filteredRides
              .sort((a, b) => a.availableSeats.compareTo(b.availableSeats));
          break;
      }
    }

    return filteredRides;
  }
}

// void main() {
//   RidesService.initialize(MockRidesRepository());

//   final preference = RidePreference(
//     departure: const Location(name: 'Battambang', country: Country.cambodia),
//     arrival: const Location(name: 'Siem Reap', country: Country.cambodia),
//     departureDate: DateTime.now().add(const Duration(hours: 8)),
//     requestedSeats: 1,
//   );

//   final filter = RidesFilter(acceptPet: true);

//   print('Rides with pet accepted filter:');
//   final ridesWithPetFilter =
//       RidesService.instance.getRidesFor(preference, filter, null);
//   for (var ride in ridesWithPetFilter) {
//     print(
//         'Driver: ${ride.driver.firstName}, Pet Accepted: ${ride.petAccepted}');
//   }

//   print('\nRides sorted by departure date:');
//   final ridesSortedByDeparture = RidesService.instance
//       .getRidesFor(preference, null, RideSortType.departure);
//   for (var ride in ridesSortedByDeparture) {
//     print(
//         'Driver: ${ride.driver.firstName}, Departure Date: ${ride.departureDate}');
//   }

//   print('\nRides without filter and sort:');
//   final ridesWithoutFilter =
//       RidesService.instance.getRidesFor(preference, null, null);
//   for (var ride in ridesWithoutFilter) {
//     print('Driver: ${ride.driver.firstName}');
//   }
// }
