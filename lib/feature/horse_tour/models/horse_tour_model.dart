class TourModel {
  final String id;
  final String name;
  final String location;
  final String duration;
  final double pricePerPerson;
  final String description;
  final String pictureLink;

  TourModel({
    required this.id,
    required this.name,
    required this.location,
    required this.duration,
    required this.pricePerPerson,
    required this.description,
    required this.pictureLink,
  });

  TourModel copyWith({
    String? id,
    String? name,
    String? location,
    String? duration,
    double? pricePerPerson,
    String? description,
    String? pictureLink,
  }) {
    return TourModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      duration: duration ?? this.duration,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      description: description ?? this.description,
      pictureLink: pictureLink ?? this.pictureLink,
    );
  }
}
