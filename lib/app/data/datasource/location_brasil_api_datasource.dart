import 'package:dio/dio.dart';
import 'package:estados_cidades_api/app/models/city_model.dart';
import 'package:estados_cidades_api/app/models/state_model.dart';

class LocationBrasilApiDatasource {
  Future<List<StateModel>> getStates() async {
    final Response(:List data) = await Dio().get('https://brasilapi.com.br/api/ibge/uf/v1');

    return data.map((e) => StateModel.fromMap(e)).toList();
  }

  Future<List<CityModel>> getCitiesByState(String state) async {
    final Response(:List data) = await Dio().get('https://brasilapi.com.br/api/ibge/municipios/v1/$state?providers=dados-abertos-br,gov,wikipedia');

    return data.map((e) => CityModel.fromMap(e)).toList();
  }
}
