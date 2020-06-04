class JsonModel {
  JsonModel({
    this.children,
  });

  List<Data> children;

  factory JsonModel.fromJson(Map<String, dynamic> json) {
    var datas = json['data']["children"] as List;
    List<Data> jsonData = datas
        .map(
          (index) => Data.fromJson(index),
        )
        .toList();
    return JsonModel(children: jsonData);
  }

  Map<String, dynamic> toJson() => {
        "children": children == null
            ? null
            : List<dynamic>.from(children.map(
                (x) => x.toJson(),
              )),
      };
}

class Data {
  Data({
    this.authorFullname,
    this.title,
  });

  String authorFullname;
  String title;

  // Create from JSON data
  Data.fromDBJson(json)
      : authorFullname = json['author_fullname'],
        title = json['title'];

  factory Data.fromJson(json) => Data(
        authorFullname: json["data"]["author_fullname"] != ''
            ? json["data"]["author_fullname"].toString()
            : '',
        title: json["data"]["title"] != null
            ? json["data"]["title"].toString()
            : '',
      );

  Map<String, dynamic> toJson() => {
        "author_fullname": authorFullname,
        "title": title == null ? null : title,
      };
}
