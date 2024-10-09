import 'dart:convert';

import 'package:estados_cidades_api/app/data/datasource/location_cache_datasource.dart';
import 'package:estados_cidades_api/app/models/city_model.dart';
import 'package:estados_cidades_api/app/models/state_model.dart';
import 'package:estados_cidades_api/cache/redis_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class RedisClientMock extends Mock implements RedisCache {}

void main() {
  group(
    'LocationCacheDataSource',
    () {
      late LocationCacheDatasource datasource;
      late RedisClientMock redisClient;

      setUp(
        () {
          registerFallbackValue(Duration(seconds: 60));
          redisClient = RedisClientMock();
          datasource = LocationCacheDatasource(redisClient);
        },
      );

      test(
        'getCachedStates should return a list of StateModel',
        () async {
          //Arrange
          final expectedStates = [
            StateModel(acronym: 'SP', name: 'São Paulo'),
            StateModel(acronym: 'PR', name: 'Paraná'),
          ];

          final cachedStates = expectedStates.map((e) => e.toMap()).toList();

          when(() => redisClient.get(stateKey)).thenAnswer((_) async => jsonEncode(cachedStates));

          //Act
          final states = await datasource.getCachedState();

          //Assert
          expect(states, equals(expectedStates));
        },
      );

      test('setCachedStates should store the list of StateModel in cache', () async {
        //Arrange
        final expectedStates = [
          StateModel(acronym: 'SP', name: 'São Paulo'),
          StateModel(acronym: 'PR', name: 'Paraná'),
        ];

        final cachedStates = expectedStates.map((e) => e.toMap()).toList();

        when(() => redisClient.put(any(), any(), any())).thenAnswer((_) async => {});
        when(() => redisClient.get(stateKey)).thenAnswer((_) async => jsonEncode(cachedStates));

        //Act
        await datasource.setCachedStates(expectedStates);
        final result = await datasource.getCachedState();

        //Assert
        verify(() => redisClient.put(any(), any(), any())).called(1);
        verify(() => redisClient.get(stateKey)).called(1);
        expect(result, equals(expectedStates));
      });

      test(
        'getCachedCititesByState should return a list of CityModel in state of SP',
        () async {
          //Arrange
          final state = 'SP';
          final expectedCities = [
            CityModel(name: 'São Paulo', ibge: 'SP'),
            CityModel(name: 'Campinas', ibge: 'SP'),
          ];

          final cachedCities = expectedCities.map((e) => e.toMap()).toList();

          when(() => redisClient.get('${state}_$cityKey')).thenAnswer((_) async => jsonEncode(cachedCities));

          //Act
          final cities = await datasource.getCachedCitiesByState(state);

          //Assert
          verify(() => redisClient.get('${state}_$cityKey')).called(1);
          expect(cities, equals(expectedCities));
        },
      );

      test('setCachedCitiesByState should store the list of CityModel in cache', () async {
        //Arrange
        final state = 'SP';
        final expectedCities = [
          CityModel(name: 'São Paulo', ibge: 'SP'),
          CityModel(name: 'Campinas', ibge: 'SP'),
        ];

        final cachedCities = expectedCities.map((e) => e.toMap()).toList();

        when(() => redisClient.put(any(), any(), any())).thenAnswer((_) async => {});
        when(() => redisClient.get('${state}_$cityKey')).thenAnswer((_) async => jsonEncode(cachedCities));

        //Act
        await datasource.setCachedCities(state, expectedCities);
        final result = await datasource.getCachedCitiesByState(state);

        //Assert
        verify(() => redisClient.put(any(), any(), any())).called(1);
        verify(() => redisClient.get('${state}_$cityKey')).called(1);
        expect(result, equals(expectedCities));
      });
    },
  );
}
