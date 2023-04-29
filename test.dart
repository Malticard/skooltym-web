import 'dart:convert';

import 'package:skool_web/models/StudentModel.dart';
import '';
void main(List<String> args) {
  var data = {
    [
  {
    "_id": "644beda32afc7f75c7bfba30",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.1"
    },
    "guardians": [],
    "student_fname": "Seok",
    "student_lname": "John",
    "other_name": "Kaguta",
    "username": "Seok_256",
    "stream": "644be4d6ee1a8933472724fe",
    "student_gender": "Male",
    "student_profile_pic": "image_1682698208075.jpeg",
    "student_key": [
      {
        "key": null,
        "_id": "644befe0ee1a8933472824c8"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-28T16:00:36.118Z",
    "updatedAt": "2023-04-28T16:10:08.426Z",
    "__v": 0
  },
  {
    "_id": "644c4fb6a01884d7d504d35a",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Kamya",
    "student_lname": "Park",
    "other_name": "Joe",
    "username": "Kamya_256",
    "stream": "644c3568b17d046bb47edecd",
    "student_gender": "",
    "student_profile_pic": "image_1682780893795.jpg",
    "student_key": [
      {
        "key": null,
        "_id": "644d32de8c7b785a4b208b82"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-28T22:59:02.121Z",
    "updatedAt": "2023-04-29T15:08:14.513Z",
    "__v": 0
  },
  {
    "_id": "644c4fb6a01884d7d504d357",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Ji min",
    "student_lname": "Park",
    "other_name": "",
    "username": "Mochi",
    "stream": "644c356fb17d046bb47edecf",
    "student_gender": "Male",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644c4fb6a01884d7d504d358"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-28T22:59:02.103Z",
    "updatedAt": "2023-04-28T22:59:02.103Z",
    "__v": 0
  },
  {
    "_id": "644c5341cd1f9b40cc8a1027",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Ji min",
    "student_lname": "Park",
    "other_name": "",
    "username": "Jiminie",
    "stream": "644c356fb17d046bb47edecf",
    "student_gender": "Male",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644c5341cd1f9b40cc8a1028"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-28T23:14:10.103Z",
    "updatedAt": "2023-04-28T23:14:10.103Z",
    "__v": 0
  },
  {
    "_id": "644c5341cd1f9b40cc8a1021",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Ji min",
    "student_lname": "Park",
    "other_name": "",
    "username": "Jiminie",
    "stream": "644c3574b17d046bb47eded1",
    "student_gender": "Male",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644c5341cd1f9b40cc8a1022"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-28T23:14:10.100Z",
    "updatedAt": "2023-04-28T23:14:10.100Z",
    "__v": 0
  },
  {
    "_id": "644c5341cd1f9b40cc8a1024",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Ji min",
    "student_lname": "Park",
    "other_name": "",
    "username": "Jiminie",
    "stream": "644c3568b17d046bb47edecd",
    "student_gender": "Male",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644c5341cd1f9b40cc8a1025"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-28T23:14:10.093Z",
    "updatedAt": "2023-04-28T23:14:10.093Z",
    "__v": 0
  },
  {
    "_id": "644c633c518a43b42c7bf927",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Mia",
    "student_lname": "Kim",
    "other_name": "",
    "username": "Rap angel",
    "stream": "644c3574b17d046bb47eded1",
    "student_gender": "Female",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644c633c518a43b42c7bf928"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-29T00:22:21.051Z",
    "updatedAt": "2023-04-29T00:22:21.051Z",
    "__v": 0
  },
  {
    "_id": "644c64de6f1f7fc0edf79325",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Drake",
    "student_lname": "Kim",
    "other_name": "katz",
    "username": "Drake_256",
    "stream": "644c3574b17d046bb47eded1",
    "student_gender": "Male",
    "student_profile_pic": "image_1682776640116.jpeg",
    "student_key": [
      {
        "key": null,
        "_id": "644d224e8c7b785a4b1fd80a"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-29T00:29:18.506Z",
    "updatedAt": "2023-04-29T13:57:34.158Z",
    "__v": 0
  },
  {
    "_id": "644c6617a8dfce3bb8956308",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "S.4"
    },
    "guardians": [],
    "student_fname": "Namjoon",
    "student_lname": "Kim",
    "other_name": "",
    "username": "Rap Monster",
    "stream": "644c356fb17d046bb47edecf",
    "student_gender": "Male",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644c6617a8dfce3bb8956309"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-29T00:34:31.418Z",
    "updatedAt": "2023-04-29T00:34:31.418Z",
    "__v": 0
  },
  {
    "_id": "644d389e8c7b785a4b213c57",
    "school": "644be3b1ee1a8933472724c0",
    "guardians": [],
    "student_fname": "Katamba",
    "student_lname": "Ivan",
    "other_name": "Joel",
    "username": "Katamba_256",
    "student_gender": "Male",
    "student_profile_pic": "image_1682782323287.jpg",
    "student_key": [
      {
        "key": null,
        "_id": "644d389e8c7b785a4b213c58"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-29T15:32:46.700Z",
    "updatedAt": "2023-04-29T15:32:46.700Z",
    "__v": 0
  },
  {
    "_id": "644d391ee54cfa6d0f05313e",
    "school": "644be3b1ee1a8933472724c0",
    "_class": {
      "class_name": "Person"
    },
    "guardians": [],
    "student_fname": "Namjoon",
    "student_lname": "Kim",
    "other_name": "",
    "username": "RMon",
    "stream": "644d38a6e54cfa6d0f053130",
    "student_gender": "Male",
    "student_profile_pic": "profile.png",
    "student_key": [
      {
        "key": null,
        "_id": "644d391ee54cfa6d0f05313f"
      }
    ],
    "isComplete": false,
    "createdAt": "2023-04-29T15:34:55.041Z",
    "updatedAt": "2023-04-29T15:34:55.041Z",
    "__v": 0
  }
]
  };
  // var st = data.toList().where((element) => element['stream'] == "644c3568b17d046bb47edecd").toList();
  // print("644c3568b17d046bb47edecd" == "644c3568b17d046bb47edecd");
 for (var element in data) {
  for (var d in element.where((element) => element['stream'] == "644c3568b17d046bb47edecd").toList()) {
    print(d['student_fname']);
  }
 }
}