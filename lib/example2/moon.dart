class Moon {
  final int? moonId;
  final String moonName;
  final int planetId;

  Moon({this.moonId, required this.moonName, required this.planetId});

  factory Moon.fromMap(Map<String, dynamic> json) => Moon(
    moonId: json['moon_id'],
    moonName: json['moon_name'],
    planetId: json['planet_id'],
  );

  Map<String, dynamic> toMap() => {
    'moon_id': moonId,
    'moon_name': moonName,
    'planet_id': planetId,
  };
}
