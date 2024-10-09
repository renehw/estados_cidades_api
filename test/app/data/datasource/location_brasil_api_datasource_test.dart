import 'package:estados_cidades_api/app/data/datasource/location_brasil_api_datasource.dart';
import 'package:estados_cidades_api/app/models/city_model.dart';
import 'package:estados_cidades_api/app/models/state_model.dart';
import 'package:test/test.dart';

void main() {
  late LocationBrasilApiDatasource datasource;

  setUp(
    () {
      datasource = LocationBrasilApiDatasource();
    },
  );

  test('getStates returns SP', () async {
    final result = await datasource.getStates();

    expect(result, isA<List<StateModel>>());
    expect(result.isNotEmpty, true);

    final isStateSP = result.any((state) => state.acronym == 'SP');
    expect(isStateSP, true);
  });

  test('getCitiesByState returns cities from PR', () async {
    final result = await datasource.getCitiesByState('PR');

    expect(result, isA<List<CityModel>>());
    expect(result.isNotEmpty, true);

    final isCitySP = result.any((city) => city.name.toLowerCase() == 'toledo');
    expect(isCitySP, true);
  });
}
