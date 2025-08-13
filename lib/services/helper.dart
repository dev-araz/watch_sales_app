import 'package:flutter/services.dart' as the_bundle;
import 'package:watch_sales_app/models/welcome_model.dart';

class Helper {
// fetch data from Classic watches json file
  Future<List<Welcome>> getClassic() async {
    final data = await the_bundle.rootBundle
        .loadString('assets/jsons/classic_watches.json');
    final classicList = welcomeFromJson(data);
    return classicList;
  }

//fetch data from Women watches json file
  Future<List<Welcome>> getWomen() async {
    final data = await the_bundle.rootBundle
        .loadString('assets/jsons/women_watches.json');
    final womenList = welcomeFromJson(data);
    return womenList;
  }

//fetch data from Sport watches json file
  Future<List<Welcome>> getSport() async {
    final data = await the_bundle.rootBundle
        .loadString('assets/jsons/sport_watches.json');
    final sportList = welcomeFromJson(data);
    return sportList;
  }

// Method to get a specific watch by id from Classic watches json file
  Future<Welcome> getClassicId(String id) async {
    final data = await the_bundle.rootBundle
        .loadString('assets/jsons/classic_watches.json');
    final classicList = welcomeFromJson(data);
    final welcome = classicList.firstWhere((welcome) => welcome.id == id,
        orElse: () => throw Exception('Watch not found'));
    return welcome;
  }

// Method to get a specific watch by id from Women watches json file
  Future<Welcome> getWomenId(String id) async {
    final data = await the_bundle.rootBundle
        .loadString('assets/jsons/women_watches.json');
    final womenList = welcomeFromJson(data);
    final welcome = womenList.firstWhere((welcome) => welcome.id == id,
        orElse: () => throw Exception('Watch not found'));
    return welcome;
  }

// Method to get a specific watch by id from Sport watches json file
  Future<Welcome> getSportId(String id) async {
    final data = await the_bundle.rootBundle
        .loadString('assets/jsons/sport_watches.json');
    final sportList = welcomeFromJson(data);
    final welcome = sportList.firstWhere((welcome) => welcome.id == id,
        orElse: () => throw Exception('Watch not found'));
    return welcome;
  }
}
