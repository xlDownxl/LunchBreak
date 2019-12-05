import '../models/location.dart';

class Place {
  final String id;
  final String name;
  final MarkerLocation location;
  final String description;

  Place(this.id, this.name, this.location, this.description);
}
