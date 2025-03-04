import 'package:test/test.dart';

import '../model/ride/locations.dart';
import '../model/ride_pref/ride_pref.dart';
import '../repository/mock/mock_ride_repository.dart';
import '../service/rides_service.dart';

void main() {
  setUp(() {
    // Initialize the RidesService with MockRidesRepository
    RidesService.initialize(MockRidesRepository());
  });

  tearDown(() {
    // Reset the RidesService instance to null
    RidesService.reset();
  });

  test(
      'T1: Create a ride preference from Battambang to Siem Reap today for 1 passenger',
      () {
    final preference = RidePreference(
      departure: const Location(name: 'Battambang', country: Country.cambodia),
      arrival: const Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now(),
      requestedSeats: 1,
    );

    final rides = RidesService.instance.getRidesFor(preference, null, null);

    print('Rides without filter and sort:');
    for (var ride in rides) {
      print('Driver: ${ride.driver.firstName}');
    }

    expect(rides.length, 4, reason: 'Expected 4 results to be displayed');
    expect(rides.where((ride) => ride.availableSeats == 0).length, 1,
        reason: 'Warning: 1 ride is full!');
  });

  test(
      'T2: Create a ride preference from Battambang to Siem Reap today for 1 passenger with pet allowed filter',
      () {
    final preference = RidePreference(
      departure: const Location(name: 'Battambang', country: Country.cambodia),
      arrival: const Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now(),
      requestedSeats: 1,
    );

    final filter = RidesFilter(acceptPet: true);

    final ridesWithPetFilter =
        RidesService.instance.getRidesFor(preference, filter, null);

    print('Rides with pet accepted filter:');
    for (var ride in ridesWithPetFilter) {
      print(
          'Driver: ${ride.driver.firstName}, Pet Accepted: ${ride.petAccepted}');
    }

    expect(ridesWithPetFilter.length, 1,
        reason: 'Expected 1 result to be displayed');
    expect(ridesWithPetFilter.first.driver.firstName, 'Limhao',
        reason: 'Expected the driver to be Limhao');
  });
}
