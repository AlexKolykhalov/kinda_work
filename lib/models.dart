import 'package:flutter/material.dart';
import 'package:kinda_work/repository.dart';
import 'package:latlong/latlong.dart';

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
    @required this.newPrice,
    @required this.oldPrice,
  });

  final String img;
  final String name;
  final int newPrice;
  final int oldPrice;
}

class InfoElement {
  InfoElement({
    @required this.isLargeGridElement,
    @required this.img,
    @required this.rate,
    this.favoriteSelected = false,
    this.lightText = '',
    this.boltText = '',
    this.countMessages = 0,
    this.discount = 0,
    this.newPrice,
    this.oldPrice,
  });

  final bool isLargeGridElement;
  final bool favoriteSelected;
  final String img;
  final String lightText;
  final String boltText;
  final num newPrice;
  final num oldPrice;
  final double rate;
  final int countMessages;
  final int discount;
}

class Promotion {
  Promotion({
    @required this.img,
    @required this.discount,
    @required this.discription,
    @required this.rate,
    @required this.newPrice,
    @required this.oldPrice,
    this.type = '',
    this.adress = '',
  });

  final String img;
  final int discount;
  final String discription;
  final double rate;
  final int newPrice;
  final int oldPrice;
  final String type;
  final String adress;
}

class Company {
  Company({
    @required this.img,
    @required this.name,
    @required this.type,
    @required this.adress,
    @required this.rate,
  });

  final String img;
  final String name;
  final String type;
  final String adress;
  final double rate;
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
  User(
      {this.avatar = 'assets/png/face.png',
      @required this.name,
      @required this.birthday,
      this.about = '',
      this.points = 0,
      this.giftPoints = 0,
      this.reviews = const [],
      this.socialMediaAccounts = const []});

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
  final List<InfoElement> places;
  final List<InfoElement> promotions;
}

class DiscountMarker {
  DiscountMarker({
    @required this.discount,
    @required this.position,
  });

  final int discount;
  final LatLng position;
}
