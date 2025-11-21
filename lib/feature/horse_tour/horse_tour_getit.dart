import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';
import 'package:get_it/get_it.dart';

final GetIt getit = GetIt.instance;

class AppStateGetIt {
  List<TourModel> tours = [];
}

void setupGetIt() {
  getit.registerSingleton<AppStateGetIt>(AppStateGetIt());
}
