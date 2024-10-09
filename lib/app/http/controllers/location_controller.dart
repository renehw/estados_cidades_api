import 'package:estados_cidades_api/app/data/datasource/location_brasil_api_datasource.dart';
import 'package:estados_cidades_api/app/data/datasource/location_cache_datasource.dart';
import 'package:estados_cidades_api/app/data/repository/location_repository.dart';
import 'package:estados_cidades_api/cache/redis_cache.dart';
import 'package:vania/vania.dart';

class LocationController extends Controller {
  final LocationRepository _locationRepository;

  LocationController()
      : _locationRepository = LocationRepository(
          LocationBrasilApiDatasource(),
          LocationCacheDatasource(RedisCache.instance),
        );

  Future<Response> getStates(Request request) async {
    final state = await _locationRepository.getStates();

    return Response.json(state.map((e) => e.toMap()).toList());
  }

  Future<Response> getCitiesByState(String state) async {
    final cities = await _locationRepository.getCitiesByState(state);

    return Response.json(cities.map((e) => e.toMap()).toList());
  }
}
