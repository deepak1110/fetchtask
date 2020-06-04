// import 'dart:convert';

// import 'package:flutter/material.dart';

// class JsonEntity with ChangeNotifier {
//   int id;
//   String name;
//   String email;
//   String username;
//   String image;
//   String accessToken;
//   JsonEntity({
//     this.name = "",
//     this.email = "",
//     this.username = '',
//     this.id = 0,
//     this.accessToken = "",
//     this.image,
//   });

//   String toRawJson() => json.encode(toJson());
//   factory JsonEntity.fromRawJson(String str) =>
//       JsonEntity.fromJson(json.decode(str));

//   // Create from JSON data
//   JsonEntity.fromDBJson(Map<String, dynamic> json)
//       : name = json['data']['name'] == null ? "" : json['data']['name'],
//         email = json['data']['email'] == null ? "" : json['data']['email'],
//         username =
//             json['data']['username'] == null ? "" : json['data']['username'],
//         id = json['data']['id'] == null ? "" : json['data']['id'],
//         image = json['data']['id'] == null ? "" : json['data']['id'].toString();

//   JsonEntity.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         name = json['name'],
//         email = json['email'],
//         username = json['username'],
//         accessToken = json['token'];

//   // Convert to JSON to make it easier when we store it in the database
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "username": username,
//         "token": accessToken
//       };
// }
