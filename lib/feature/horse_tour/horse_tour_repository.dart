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
          description: 'Живописная прогулка по густому и мрачному лесу.',
          pictureLink: 'https://avatars.mds.yandex.net/get-altay/12865251/2a0000018f1f87c79af3defe571f76614996/XXL_height',),
      TourModel(
          id: '2',
          name: 'Тур в горах',
          location: 'Скалистые горы',
          duration: '1 день',
          pricePerPerson: 55,
          description: 'Исследуйте горные тропы в сопровождении опытных гидов.',
          pictureLink: 'https://avatars.dzeninfra.ru/get-zen_doc/3504171/pub_61e3c466bb1b98366871eac7_61e3c4c26126921fd87d5b71/scale_1200'),
      TourModel(
          id: '3',
          name: 'Тур по реке',
          location: 'Голубая река',
          duration: '2 часа',
          pricePerPerson: 25,
          description: 'Расслабляющая прогулка вдоль берега Голубой реки.',
          pictureLink: 'https://avatars.dzeninfra.ru/get-zen_doc/1703756/pub_622e39e3a228967ff21b31aa_622e3cca9916f3091a552cbd/scale_1200'),
    ];
  }
}
