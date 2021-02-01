import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/main/pages/beauty.dart';
import 'package:kinda_work/main/pages/restaurants_cafe_page.dart';
import 'package:kinda_work/models.dart';

enum ReviewStatus {
  moderation,
  apply,
  deny,
}

// TODO сделать как Историю посещений и
// записать в класс User
List whereIWas = [
  {
    'object': kventin,
    'visit_time': '20 сентября 2016',
    'discount_money': 10,
    'discount_points': 100,
  },
  {
    'object': djomalungma,
    'visit_time': '20 сентября 2016',
    'discount_money': 25,
    'discount_points': 330,
  },
  {
    'object': tochka,
    'visit_time': '20 сентября 2016',
    'discount_money': 81,
    'discount_points': 30,
  },
  {
    'object': promo2,
    'visit_time': '20 сентября 2016',
    'discount_money': 0,
    'discount_points': 0,
  }
];

const User user1 = User(
  name: 'Фредди Макгрегор',
  birthday: '04.06.1980',
  phone: '(375) 580 32 69',
  about: 'О да, я супер крут!',
  points: 2500,
  giftPoints: 152,
);

const User user2 = User(
  name: 'Jonh Denson',
  birthday: '04.06.1960',
  phone: '(375) 552 02 32',
  about: 'Cупер puper крут!',
  points: 2950,
  giftPoints: 112,
);

Company kventin = Company(
  img: 'assets/png/grid/1.png',
  type: 'Квест-комнаты',
  name: 'Kventin',
  adress: 'г. Минск, ул. Кульман, 9',
  web: 'www.kventin.by',
  menu: [
    // TODO сделать разбиение блюд на категории, например
    // Суши, Мороженое, в свою очередь
    // Суши относятся к Холодным закускам, а Мороженое - к Десертам
    Menu(
      img: 'assets/png/grid/1.png',
      name: 'Суши Калифорния',
      description: 'Лосось - 500 гр., рис - 500 гр.',
      newPrice: 240,
      oldPrice: 275,
    ),
    Menu(
      img: 'assets/png/grid/2.png',
      name: 'Суши Филадельфия',
      description: '',
      oldPrice: 275,
    ),
    Menu(
      img: 'assets/png/grid/3.png',
      name: 'Суши Ням-Ням',
      description: '',
      newPrice: 240,
      oldPrice: 275,
    ),
  ],
  news: [
    News(
      date: '01.03.18',
      img: 'assets/png/grid/1.png',
      name: 'Kventin',
      description: 'Самые вкусные пельмени у нас!',
    ),
    News(
      date: '08.03.18',
      img: 'assets/png/grid/2.png',
      name: 'Kventin',
      description:
          'Поздравляем дорогих женщин с 8 марта! Желаем счастья, здоровья и всевозможных благ! И больших творческих успехов!!!',
    ),
  ],
  favorite: true,
  messages: 36,
  discount: 50,
);

Company tochka = Company(
  img: 'assets/png/grid/2.png',
  type: 'Кафе',
  name: 'Т.О.Ч.К.А',
  adress: 'г. Минск, ул. Иванова, 13-9',
  menu: [
    Menu(
      img: 'assets/png/grid/3.png',
      name: 'Суши',
      newPrice: 240,
      oldPrice: 275,
    ),
    Menu(
      img: 'assets/png/grid/2.png',
      name: 'Филадельфия',
      newPrice: 240,
      oldPrice: 275,
    ),
    Menu(
      img: 'assets/png/grid/1.png',
      name: 'BigBon',
      newPrice: 240,
      oldPrice: 275,
    ),
  ],
  rate: 3.5,
  messages: 123,
);

Company djomalungma = Company(
    img: 'assets/png/grid/3.png',
    type: 'Кофейня',
    name: 'Джомалунгма-Суши Супер-пупер бар и лаундж',
    adress: 'г. Минск, ул. Петрова, 5',
    menu: [
      Menu(
        img: 'assets/png/grid/3.png',
        name: 'Суши',
        newPrice: 240,
        oldPrice: 275,
      ),
      Menu(
        img: 'assets/png/grid/2.png',
        name: 'Филадельфия',
        newPrice: 240,
        oldPrice: 275,
      ),
      Menu(
        img: 'assets/png/grid/1.png',
        name: 'BigBon',
        newPrice: 240,
        oldPrice: 275,
      ),
    ],
    rate: 5.8,
    favorite: true,
    discount: 10);

Promotion promo1 = Promotion(
  img: 'assets/png/grid/1.png',
  type: 'Акция',
  company: kventin,
  description:
      'Ужин в "Kvintin" за 30 руб. для двоих, сеты для одного и для компании от 20 руб.',
  discount: 35,
  rate: 8.0,
  oldPrice: 15000,
  newPrice: 14500,
);

Promotion promo2 = Promotion(
  img: 'assets/png/grid/1.png',
  type: 'Акция',
  company: tochka,
  description: 'Ужин в "Т.О.Ч.К.А" за 50 руб. для двоих.',
  discount: 10,
  rate: 8.0,
  oldPrice: 200,
  newPrice: 180,
);

Promotion promo3 = Promotion(
  img: 'assets/png/grid/2.png',
  type: 'Акция',
  company: tochka,
  description: 'Ужин в "Т.О.Ч.К.А" за треть',
  discount: 33,
  rate: 8.6,
  oldPrice: 5000,
  newPrice: 2500,
);

List<Company> popularCompanies = [
  kventin,
  tochka,
  djomalungma,
];

List<Promotion> popularPromotions = [
  promo1,
  promo2,
  promo3,
];

Map searchResult = {
  'companies': [kventin, tochka, djomalungma],
  'promotions': [promo1, promo2, promo3],
  'type_companies': [
    '&Суши&',
    '&Суши&-ресторан',
    'Доставка &суши&',
    '&Суши&-ресторан',
    'Доставка &суши&',
  ],
};

List<Map<String, dynamic>> sectionElements = [
  {
    'img': 'assets/png/features/1.png',
    'text': 'Рестораны и кафе',
    'page': RestaurantsCafe(),
  },
  {
    'img': 'assets/png/features/2.png',
    'text': 'Красота',
    'page': Beauty(),
  },
  {
    'img': 'assets/png/features/3.png',
    'text': 'Развлечения',
    'page': null //Entertainment(),
  },
  {
    'img': 'assets/png/features/4.png',
    'text': 'Авто и мото',
    'page': null //Autoservices(),
  },
  {
    'img': 'assets/png/features/5.png',
    'text': 'Спорт',
    'page': null //Sports(),
  },
];

List<InfoMarker> listInfoMarkers = [
  InfoMarker(
    id: 1,
    position: LatLng(53.912180, 27.545018),
    companies: [
      kventin,
      tochka,
    ],
    promotions: [
      promo1,
      promo2,
      promo3,
    ],
  ),
  InfoMarker(
    id: 2,
    position: LatLng(53.911080, 27.541718),
    companies: [],
    promotions: [],
  ),
  InfoMarker(
    id: 3,
    position: LatLng(53.908580, 27.546318),
    companies: [],
    promotions: [],
  ),
];

List<DiscountMarker> listDiscountMarkers = [
  DiscountMarker(discount: 95, position: LatLng(53.912280, 27.541818)),
  DiscountMarker(discount: 50, position: LatLng(53.911580, 27.547918)),
  DiscountMarker(discount: 15, position: LatLng(53.908380, 27.541318)),
];

List<Image> sliderImages = [
  Image.asset('assets/png/slider/slider1.png', fit: BoxFit.cover),
  Image.asset('assets/png/slider/slider2.png', fit: BoxFit.cover),
  Image.asset('assets/png/slider/slider3.png', fit: BoxFit.cover),
  Image.asset('assets/png/slider/slider4.png', fit: BoxFit.cover),
];

List historyVisitsOneUser = [
  {
    'date': '21.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '3500 Br',
    'name': 'Роман Красновский',
    'discount': '10%',
  },
  {
    'date': '21.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '500 Br',
    'name': 'Роман Красновский',
    'discount': '2%',
  },
  {
    'date': '22.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '3000 Br',
    'name': 'Роман Красновский',
    'discount': '13%',
  },
  {
    'date': '23.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '100 Br',
    'name': 'Роман Красновский',
    'discount': '1%',
  },
  {
    'date': '24.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '5500 Br',
    'name': 'Роман Красновский',
    'discount': '50%',
  },
];

List historyVisitsManyUsers = [
  {
    'date': '21.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '350 Br',
    'name': 'Валентина',
    'discount': '10%',
  },
  {
    'date': '21.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '500 Br',
    'name': 'Роман Красновский',
    'discount': '2%',
  },
  {
    'date': '22.06.17',
    'phone': '+375 (941) 277-60-91',
    'price': '560 Br',
    'name': 'Глеб Щегловский',
    'discount': '19%',
  },
  {
    'date': '23.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '100 Br',
    'name': 'Иван',
    'discount': '1%',
  },
  {
    'date': '24.06.17',
    'phone': '+375 (940) 677-60-91',
    'price': '5500 Br',
    'name': 'Лена',
    'discount': '55%',
  },
];

List bookingData = [
  {
    'date': '21.06.17',
    'name': 'Валентина',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': 'Столик, 4 человека',
    'status': 0,
    'company': djomalungma,
    'unseen': true,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': 'Столик, 2 человека',
    'status': 1,
    'company': kventin,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': tochka,
    'unseen': false,
  },
];

List<Review> reviews = [
  Review(
    date: '16.10.18',
    objectReview: kventin,
    text: 'Ну очень долго все готовится, еда не плоха, официант не спешит',
    author: user1,
    service: 10,
    kitchen: 10,
    priceQuality: 10,
    ambiance: 10,
    likes: 1,
    managerResponse:
        'Иван, здравствуйте! Благодарим вас за обратную связь. Безумно стыдно за уровень сервиса, предоставленный вам.',
    reviewStatus: ReviewStatus.apply,
    reviewPoints: 110,
  ),
  Review(
    date: '12.10.18',
    objectReview: tochka,
    text: 'Так себе...',
    author: user1,
    service: 6,
    kitchen: 5,
    priceQuality: 9,
    ambiance: 10,
    likes: -1,
  ),
  Review(
      date: '12.10.18',
      objectReview: djomalungma,
      text: 'Так себе...',
      author: user1,
      service: 6,
      kitchen: 5,
      priceQuality: 9,
      ambiance: 10,
      likes: -1,
      reviewStatus: ReviewStatus.deny,
      moderatorResponse:
          'Отзыв был не опубликован, так как у модератора возникли мотивированные сомнения, по всем вопросам просим обращать по адресу zabava@mail.com'),
  Review(
    date: '12.10.18',
    objectReview: promo1,
    text: 'Было неплохо, но могла быть лучше...',
    author: user1,
    service: 6,
    kitchen: 5,
    priceQuality: 9,
    ambiance: 10,
    likes: -1,
    reviewStatus: ReviewStatus.apply,
    reviewPoints: 55,
  ),
];
