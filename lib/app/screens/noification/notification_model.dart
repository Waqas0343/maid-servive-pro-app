import 'package:get/get_rx/src/rx_types/rx_types.dart';

class NotificationModel {
  bool success;
  NotificationDataModel data;
  String message;

  NotificationModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    data: NotificationDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class NotificationDataModel {
  int currentPage;
  List<NotificationDataListModel> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  NotificationDataModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
    currentPage: json["current_page"],
    data: List<NotificationDataListModel>.from(json["data"].map((x) => NotificationDataListModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class NotificationDataListModel {
  int id;
  String title;
  String senderId;
  String userId;
  String description;
  String status;
  String type;
  String data;
  DateTime createdAt;
  RxBool isRead;

  NotificationDataListModel({
    required this.id,
    required this.title,
    required this.senderId,
    required this.userId,
    required this.description,
    required this.status,
    required this.type,
    required this.data,
    required this.createdAt,
    required bool isRead,
  }) : isRead = isRead.obs;

  factory NotificationDataListModel.fromJson(Map<String, dynamic> json) => NotificationDataListModel(
    id: json["id"],
    title: json["title"],
    senderId: json["sender_id"],
    userId: json["user_id"],
    description: json["description"],
    status: json["status"],
    type: json["type"],
    data: json["data"],
    createdAt: DateTime.parse(json["created_at"]),
    isRead: (json["is_read"] ?? false) as bool,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sender_id": senderId,
    "user_id": userId,
    "description": description,
    "status": status,
    "type": type,
    "data": data,
    "created_at": createdAt.toIso8601String(),
    "is_read": isRead.value,
  };
}



class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
