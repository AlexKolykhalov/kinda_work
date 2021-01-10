import 'package:flutter/material.dart';
import 'package:kinda_work/main/pages/beauty/beauty.dart';
import 'package:kinda_work/main/pages/restaurants_cafe_page.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/models.dart';

enum ReviewStatus {
  moderation,
  apply,
  deny,
}

User user1 = User(
  name: 'Фредди Макгрегор',
  birthday: '04.06.1980',
  about: 'О да, я супер крут!',
  points: 2500,
  giftPoints: 152,
);

Company kventin = Company(
  img: 'assets/png/grid/1.png',
  type: 'Квест-комнаты',
  name: 'Kventin',
  adress: 'г. Минск, ул. Кульман, 9',
  menu: [
    Menu(
      img: 'assets/png/grid/1.png',
      name: 'Суши Калифорния',
      newPrice: 240,
      oldPrice: 275,
    ),
    Menu(
      img: 'assets/png/grid/2.png',
      name: 'Суши Филадельфия',
      oldPrice: 275,
    ),
    Menu(
      img: 'assets/png/grid/3.png',
      name: 'Суши Ням-Ням',
      newPrice: 240,
      oldPrice: 275,
    ),
  ],
  favoriteSelected: true,
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

Company sherlock = Company(
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
    favoriteSelected: true,
    discount: 10);

Promotion promo = Promotion(
  img: 'assets/png/grid/1.png',
  discount: 35,
  type: 'Кафе, бар, караоке',
  adress: 'г. Минск, ул. Кульман, 9',
  discription:
      'Ужин в "Loft Cafe" за 30 руб. для двоих, сеты для одного и для компании от 20 руб.',
  rate: 8.0,
  oldPrice: 15000,
  newPrice: 14500,
);

List<Company> popularPlaces = [
  kventin,
  tochka,
  sherlock,
];

List<Promotion> popularPromotions = [
  promo,
  promo,
];

Map searchResult = {
  'companies': [kventin, tochka, sherlock],
  'promotions': [promo, promo],
  'type_companies': [
    '&Суши&',
    '&Суши&-ресторан',
    'Доставка &суши&',
    '&Суши&-ресторан',
    'Доставка &суши&',
  ],
};

List<Map<String, dynamic>> sectionsElements = [
  {
    'img': 'assets/png/features/1.png',
    'text': 'Рестораны и кафе',
    'page': RestaurantsCafe(
      currentIndex: 1,
    ),
  },
  {
    'img': 'assets/png/features/2.png',
    'text': 'Красота',
    'page': Beauty(
      currentIndex: 1,
    ),
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
    places: [
      kventin,
      tochka,
    ],
    promotions: [
      promo,
      promo,
    ],
  ),
  InfoMarker(
    id: 2,
    position: LatLng(53.911080, 27.541718),
    places: [],
    promotions: [],
  ),
  InfoMarker(
    id: 3,
    position: LatLng(53.908580, 27.546318),
    places: [],
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
    'company': Company(
      img: 'assets/png/grid/1.png',
      name: 'Джомалунгма Су&ши&',
      type: 'Ресторан',
      adress: 'г. Минск, ул. Кульмана, 9',
      rate: 1.0,
    ),
    'unseen': true,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': 'Столик, 2 человека',
    'status': 1,
    'company': Company(
      img: 'assets/png/grid/1.png',
      name: 'Джомалунгма Су&ши&',
      type: 'Ресторан',
      adress: 'г. Минск, ул. Кульмана, 9',
      rate: 1.0,
    ),
    'unseen': false,
  },
  {
    'date': '21.06.17',
    'name': 'Роман Красновский',
    'phone': '+375 (940) 677-60-91',
    'booking_date': '20 июля 2020, 20:30',
    'booking_details': '2 столика, 8 человек',
    'status': 0,
    'company': Company(
      img: 'assets/png/grid/1.png',
      name: 'Джомалунгма Су&ши&',
      type: 'Ресторан',
      adress: 'г. Минск, ул. Кульмана, 9',
      rate: 1.0,
    ),
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
      objectReview: sherlock,
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
    objectReview: promo,
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

Map whereIWas = {
  'places': [
    {
      'company': Company(
        img: 'assets/png/grid/1.png',
        name: 'Kventin',
        type: 'Квест-комнаты',
        adress: 'г. Минск, ул. Кульман, 9',
        rate: 8.0,
      ),
      'visit_time': '20 сентября 2016',
      'discount_money': 80,
      'discount_points': 130,
    },
    {
      'company': Company(
        img: 'assets/png/grid/2.png',
        name: 'Джомалунгма',
        type: 'Ресторан',
        adress: 'г. Минск, ул. Кульман, 9',
        rate: 8.0,
      ),
      'visit_time': '20 сентября 2016',
      'discount_money': 80,
      'discount_points': 130,
    },
    {
      'company': Company(
        img: 'assets/png/grid/1.png',
        name: 'Kventin',
        type: 'Квест-комнаты',
        adress: 'г. Минск, ул. Кульман, 9',
        rate: 8.0,
      ),
      'visit_time': '20 сентября 2016',
      'discount_money': 80,
      'discount_points': 130,
    },
  ],
  'promotions': [
    {
      'promotion': Promotion(
        img: 'assets/png/grid/1.png',
        discount: 35,
        discription:
            'Ужин в "Loft Cafe" за 30 руб. для двоих, сеты для одного и для компании от 20 руб.',
        rate: 8.0,
        newPrice: 0,
        oldPrice: 0,
        type: 'Кафе, бар, караоке',
        adress: 'г. Минск, ул. Кульман, 9',
      ),
      'visit_time': '20 сентября 2016',
    }
  ],
};
