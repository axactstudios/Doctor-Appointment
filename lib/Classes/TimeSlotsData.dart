class TimeSlotsData {
  String from;
  String to;
  String available;

  TimeSlotsData.fromMap(Map<dynamic, dynamic> data)
      : from = data["from"],
        to = data["to"],
        available = data['available'];

  TimeSlotsData(
    String from,
    String to,
    String available,
  ) {
    this.from = from;
    this.to = to;
    this.available = available;
  }
}
