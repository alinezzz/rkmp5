import 'models/horse_tour_model.dart';

class ToursRepository {
  List<TourModel> getTours() {
    return [
      TourModel(
          id: '1',
          name: 'Тур в лесу',
          location: 'Дремучий лес',
          duration: '3 часа',
          pricePerPerson: 35,
          description: 'Живописная прогулка по густому и мрачному лесу.'),
      TourModel(
          id: '2',
          name: 'Тур в горах',
          location: 'Скалистые горы',
          duration: '1 день',
          pricePerPerson: 55,
          description: 'Исследуйте горные тропы в сопровождении опытных гидов.'),
      TourModel(
          id: '3',
          name: 'Тур по реке',
          location: 'Голубая река',
          duration: '2 часа',
          pricePerPerson: 25,
          description: 'Расслабляющая прогулка вдоль берега Голубой реки.'),
    ];
  }
}
