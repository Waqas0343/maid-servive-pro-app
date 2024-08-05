import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserAvailabilityModel {
  bool success;
  UserAvailabilityListModel data;
  String message;

  UserAvailabilityModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserAvailabilityModel.fromJson(Map<String, dynamic> json) => UserAvailabilityModel(
    success: json["success"] ?? false,
    data: UserAvailabilityListModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class UserAvailabilityListModel {
  List<Day> monday;
  List<Day> tuesday;
  List<Day> wednesday;
  List<Day> thursday;
  List<Day> friday;
  List<Day> saturday;
  List<Day> sunday;

  UserAvailabilityListModel({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory UserAvailabilityListModel.fromJson(Map<String, dynamic> json) => UserAvailabilityListModel(
    monday: (json["Monday"] as List).map((e) => Day.fromJson(e)).toList(),
    tuesday: (json["Tuesday"] as List).map((e) => Day.fromJson(e)).toList(),
    wednesday: (json["Wednesday"] as List).map((e) => Day.fromJson(e)).toList(),
    thursday: (json["Thursday"] as List).map((e) => Day.fromJson(e)).toList(),
    friday: (json["Friday"] as List).map((e) => Day.fromJson(e)).toList(),
    saturday: (json["Saturday"] as List).map((e) => Day.fromJson(e)).toList(),
    sunday: (json["Sunday"] as List).map((e) => Day.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "Monday": monday.map((day) => day.toJson()).toList(),
    "Tuesday": tuesday.map((day) => day.toJson()).toList(),
    "Wednesday": wednesday.map((day) => day.toJson()).toList(),
    "Thursday": thursday.map((day) => day.toJson()).toList(),
    "Friday": friday.map((day) => day.toJson()).toList(),
    "Saturday": saturday.map((day) => day.toJson()).toList(),
    "Sunday": sunday.map((day) => day.toJson()).toList(),
  };
}

class Day {
  int id;
  int slotId;
  String slotStartTime;
  String slotEndTime;
  RxString status;

  Day({
    required this.id,
    required this.slotId,
    required this.slotStartTime,
    required this.slotEndTime,
    required String status,
  }) : status = status.obs;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    slotId: json["slot_id"],
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slot_id": slotId,
    "slot_start_time": slotStartTime,
    "slot_end_time": slotEndTime,
    "status": status.value,
  };
}
