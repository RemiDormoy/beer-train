import 'dart:convert';
import 'dart:convert' show Json;

import 'package:http/http.dart' as http;

class TrainRepository {
  static TrainRepository _instance;

  static TrainRepository getInstance() {
    if (_instance == null) {
      _instance = TrainRepository();
    }
    return _instance;
  }

  bool trainLaunched() {
    return _train != null;
  }

  Train getTrain() {
    return _train;
  }

  Future<Object> init() async {
    final response = await http.get('http://localhost:8080/train');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      _TrainData trainData = _TrainData.fromJson(json.decode(response.body));
      DateTime start = DateTime.parse(trainData.start);
      DateTime end = DateTime.parse(trainData.end);
      _train = Train(trainData.members, start, end, trainData.arrivalPlace);
      print('le train est parsé');
    } else {
      // If that response was not OK, throw an error.
      print('Pas de train pour toi gros mauvais');
    }
  }

  Future<Object> createTrain(String time, String place) async {
    final response = await http.post(
      'http://localhost:8080/train',
      body: jsonEncode({"chef": "rdo", "end": time, "place": place}),
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
      }
    );

    if (response.statusCode == 200) {
      print('le train est créé');
    } else {
      // If that response was not OK, throw an error.
      print('le train est pas créé');
    }
  }

  Train _train;
}

class Train {
  List<String> members;
  DateTime start;
  DateTime end;
  String arrivalPlace;

  Train(this.members, this.start, this.end, this.arrivalPlace);
}

class _TrainData {
  final List<String> members;
  String start;
  String end;
  String arrivalPlace;

  _TrainData({this.members, this.start, this.end, this.arrivalPlace});

  factory _TrainData.fromJson(Map<String, dynamic> json) {
    return _TrainData(
      start: json['start'],
      end: json['end'],
      arrivalPlace: json['arrivalPlace'],
      members: List<String>.from(json['members']),
    );
  }
}
