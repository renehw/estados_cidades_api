import 'package:shorebird_redis_client/shorebird_redis_client.dart';

class RedisCache {
  static RedisCache? _instance;

  late final RedisClient _redis;

  RedisCache._() {
    _redis = RedisClient(
      socket: RedisSocketOptions(
        host: 'localhost',
        port: 6379,
        password: 'admin',
      ),
    );
  }

  static RedisCache get instance => _instance ??= RedisCache._();

  Future<void> put(String key, String value, Duration ttl) async {
    await _redis.connect();
    await _redis.set(key: key, value: value, ttl: ttl);
  }

  Future<String?> get(String key) async {
    await _redis.connect();
    return await _redis.get(key: key);
  }
}
