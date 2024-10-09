import 'package:estados_cidades_api/app/http/controllers/location_controller.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.get('/states', LocationController().getStates);
    Router.get('/cities/{states}', LocationController().getCitiesByState);
  }
}
