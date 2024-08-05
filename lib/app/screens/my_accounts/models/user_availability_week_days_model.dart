class UserWeekDaysModel {
  bool success;
  UserWeekDaysDataModel data;
  String message;

  UserWeekDaysModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserWeekDaysModel.fromJson(Map<String, dynamic> json) => UserWeekDaysModel(
    success: json["success"],
    data: UserWeekDaysDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class UserWeekDaysDataModel {
  int currentPage;
  List<UserWeekDaysDataListModel> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  UserWeekDaysDataModel({
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

  factory UserWeekDaysDataModel.fromJson(Map<String, dynamic> json) => UserWeekDaysDataModel(
    currentPage: json["current_page"],
    data: List<UserWeekDaysDataListModel>.from(json["data"].map((x) => UserWeekDaysDataListModel.fromJson(x))),
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

class UserWeekDaysDataListModel {
  int id;
  String name;
  String status;
  DateTime createdAt;

  UserWeekDaysDataListModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  factory UserWeekDaysDataListModel.fromJson(Map<String, dynamic> json) => UserWeekDaysDataListModel(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt.toIso8601String(),
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
