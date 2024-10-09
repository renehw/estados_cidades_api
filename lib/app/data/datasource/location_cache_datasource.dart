import 'dart:convert';

import 'package:estados_cidades_api/app/models/city_model.dart';
import 'package:estados_cidades_api/app/models/state_model.dart';
import 'package:estados_cidades_api/cache/redis_cache.dart';

const stateKey = 'STATES_KEY';
const cityKey = 'CITY_KEY';

class LocationCacheDatasource {
  final RedisCache _cacheClient;

  LocationCacheDatasource(this._cacheClient);

  Future<List<StateModel>> getCachedState() async {
    final statesCache = await _cacheClient.get(stateKey);

    return switch (statesCache) {
      != null && String(isNotEmpty: true) => jsonDecode(statesCache).map<StateModel>((e) => StateModel.fromMap(e)).toList(),
      _ => [],
    };
  }

  Future<void> setCachedStates(List<StateModel> states) async {
    final data = states.map((e) => e.toMap()).toList();
    _cacheClient.put(stateKey, jsonEncode(data), Duration(days: 180));
  }

  Future<List<CityModel>> getCachedCitiesByState(String state) async {
    final citiesCache = await _cacheClient.get('${state}_$cityKey');

    return switch (citiesCache) {
      != null && String(isNotEmpty: true) => jsonDecode(citiesCache).map<CityModel>((e) => CityModel.fromMap(e)).toList(),
      _ => [],
    };
  }

  Future<void> setCachedCities(String state, List<CityModel> cities) async {
    final data = cities.map((e) => e.toMap()).toList();
    _cacheClient.put('${state}_$cityKey', jsonEncode(data), Duration(days: 90));
  }
}
