import 'package:estados_cidades_api/app/data/datasource/location_brasil_api_datasource.dart';
import 'package:estados_cidades_api/app/data/datasource/location_cache_datasource.dart';
import 'package:estados_cidades_api/app/models/city_model.dart';
import 'package:estados_cidades_api/app/models/state_model.dart';

class LocationRepository {
  final LocationBrasilApiDatasource _locationAPIDatasource;
  final LocationCacheDatasource _locationCacheDatasource;

  LocationRepository(
    this._locationAPIDatasource,
    this._locationCacheDatasource,
  );

  Future<List<StateModel>> getStates() async {
    var states = await _locationCacheDatasource.getCachedState();

    if (states.isEmpty) {
      states = await _locationAPIDatasource.getStates();
      if (states.isNotEmpty) {
        _locationCacheDatasource.setCachedStates(states);
      }
    }
    return states;
  }

  Future<List<CityModel>> getCitiesByState(String state) async {
    var cities = await _locationCacheDatasource.getCachedCitiesByState(state);

    if (cities.isEmpty) {
      cities = await _locationAPIDatasource.getCitiesByState(state);
      if (cities.isNotEmpty) {
        _locationCacheDatasource.setCachedCities(state, cities);
      }
    }

    return cities;
  }
}
