class Station {
  final String id;
  final String name;

  Station(this.id, this.name);

  Station.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["value"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "value": name,
    };
  }
}
