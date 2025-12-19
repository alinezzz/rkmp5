class Tour {
  final String name;
  final String location;
  final String image;

  Tour({required this.name, required this.location, required this.image});
}

final List<Tour> allTours = [
  Tour(
    name: 'Прогулка по лесу',
    location: 'лес',
    image: 'https://avatars.mds.yandex.net/i?id=03da08f542f9080e084cdd8279ebe387afd2abbd-10512701-images-thumbs&n=13',
  ),
  Tour(
    name: 'Покорение горных вершин',
    location: 'горы',
    image: 'https://picsum.photos/seed/mountain/400/300',
  ),
  Tour(
    name: 'Прогулка вдоль реки',
    location: 'река',
    image: 'https://picsum.photos/seed/river/400/300',
  ),
  Tour(
    name: 'Лесное приключение',
    location: 'лес',
    image: 'https://avatars.mds.yandex.net/i?id=75d4beeecbe0141928be8e12ab08661a462850d0-5204758-images-thumbs&n=13',
  ),
  Tour(
    name: 'Горный поход',
    location: 'горы',
    image: 'https://picsum.photos/seed/mountain_hike/400/300',
  ),
];
