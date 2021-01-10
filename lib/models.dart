import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/repository.dart';

class AppBarBottom {
  AppBarBottom({
    @required this.tabController,
    @required this.bottomData,
    this.isScrollable = false,
  });
  final TabController tabController;
  final List<String> bottomData;
  final bool isScrollable;
}

//search
class Price {
  Price({
    @required this.type,
    @required this.name,
    @required this.discount,
    @required this.rate,
    @required this.adress,
    @required this.menu,
  });

  final String type;
  final String name;
  final int discount;
  final double rate;
  final String adress;
  final List<Menu> menu;
}

class Menu {
  Menu({
    @required this.img,
    @required this.name,
    this.newPrice = 0.0,
    this.oldPrice = 0.0,
  });

  final String img;
  final String name;
  final num newPrice;
  final num oldPrice;
}

// class InfoElement {
//   InfoElement({
//     @required this.isLargeGridElement,
//     @required this.img,
//     @required this.rate,
//     this.favoriteSelected = false,
//     this.lightText = '',
//     this.boltText = '',
//     this.countMessages = 0,
//     this.discount = 0,
//     this.newPrice,
//     this.oldPrice,
//   });

//   final bool isLargeGridElement;
//   final bool favoriteSelected;
//   final String img;
//   final String lightText;
//   final String boltText;
//   final num newPrice;
//   final num oldPrice;
//   final double rate;
//   final int countMessages;
//   final int discount;
// }

class Promotion {
  Promotion({
    @required this.img,
    @required this.discription,
    this.type,
    this.adress,
    this.rate = 0.0,
    this.favoriteSelected = false,
    this.messages = 0,
    this.discount = 0,
    this.oldPrice = 0.0,
    this.newPrice = 0.0,
  });

  final String img;
  final String discription;
  final String type;
  final String adress;
  final double rate;
  final bool favoriteSelected;
  final int messages;
  final int discount;
  final num oldPrice;
  final num newPrice;
}

class Company {
  Company({
    @required this.img,
    @required this.type,
    @required this.name,
    this.adress,
    this.menu = const <Menu>[],
    this.rate = 0.0,
    this.favoriteSelected = false,
    this.messages = 0,
    this.discount = 0,
  });

  final String img;
  final String type;
  final String name;
  final String adress;
  final List<Menu> menu;
  final double rate;
  final bool favoriteSelected;
  final int messages;
  final int discount;
}

class Review {
  Review({
    @required this.date,
    @required this.objectReview,
    @required this.text,
    @required this.author,
    this.service,
    this.kitchen,
    this.priceQuality,
    this.ambiance,
    this.likes = 0,
    this.managerResponse,
    this.reviewStatus = ReviewStatus.moderation,
    this.reviewPoints,
    this.moderatorResponse,
  });
  final String date;
  final dynamic objectReview;
  final String text;
  final User author;
  final int service;
  final int kitchen;
  final int priceQuality;
  final int ambiance;
  final int likes;
  final String managerResponse;
  final ReviewStatus reviewStatus;
  final int reviewPoints;
  final String moderatorResponse;
}

class User {
  User({
    this.avatar = 'assets/png/face.png',
    @required this.name,
    @required this.birthday,
    this.about = '',
    this.points = 0,
    this.giftPoints = 0,
    this.reviews = const [],
    this.socialMediaAccounts = const [],
  });

  final String avatar;
  final String name;
  final String birthday;
  final String about;
  final int points;
  final int giftPoints;
  final List<Review> reviews;
  final List socialMediaAccounts;
}

class InfoMarker {
  InfoMarker({
    @required this.id,
    @required this.position,
    @required this.places,
    @required this.promotions,
  });

  final int id;
  final LatLng position;
  final List<Company> places;
  final List<Promotion> promotions;
}

class DiscountMarker {
  DiscountMarker({
    @required this.discount,
    @required this.position,
  });

  final int discount;
  final LatLng position;
}
