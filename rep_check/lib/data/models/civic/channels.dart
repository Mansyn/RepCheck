class Channels {
  Channels({required this.type, required this.id});

  String type;
  String id;

  factory Channels.fromJson(Map<String, dynamic> json) =>
      Channels(type: json["type"], id: json["id"]);

  Map<String, dynamic> toJson() => {"type": type, "id": id};
}
