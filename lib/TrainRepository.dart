import 'dart:convert';

import 'package:http/http.dart' as http;

class TrainRepository {
  static TrainRepository _instance;

  String _selectedChief;

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
    try {
      final response = await http.get(
          'http://ec2-35-180-100-132.eu-west-3.compute.amazonaws.com/train');

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        _TrainData trainData = _TrainData.fromJson(json.decode(response.body));
        DateTime start = DateTime.parse(trainData.start);
        DateTime end = DateTime.parse(trainData.end);
        _train = Train(trainData.members, start, end, trainData.arrivalPlace);
      } else {
        _train = null;
      }
    } catch (e) {
      _train = null;
    }
  }

  void setSelectedChief(String name) {
    _selectedChief = name;
  }

  Future<void> addOrRemoveMember(bool isSelected, String name) async {
    final response = await http.put(
        'http://ec2-35-180-100-132.eu-west-3.compute.amazonaws.com/train',
        body: jsonEncode({"name": name, "isOnboard": isSelected}),
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
        }
    );

    if (response.statusCode == 200) {
    } else {
      // If that response was not OK, throw an error.
    }
  }

  Future<Object> createTrain(String time, String place) async {
    final response = await http.post(
      'http://ec2-35-180-100-132.eu-west-3.compute.amazonaws.com/train',
      body: jsonEncode({"chef": _selectedChief, "end": time, "place": place}),
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
      }
    );

    if (response.statusCode == 200) {
    } else {
      // If that response was not OK, throw an error.
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
      arrivalPlace: json['place'],
      members: List<String>.from(json['members']),
    );
  }
}
