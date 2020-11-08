import 'package:flutter/material.dart';

class InfoElement {
  InfoElement({
    @required this.isLargeGridElement,
    @required this.isDiscountVisible,
    @required this.isFavoriteVisible,
    @required this.img,
    @required this.rate,
    this.isFavorite = false,
    this.lightText = '',
    this.boltText = '',
    this.countMessages = 0,
    this.discount = 0,
    this.newPrice = '',
    this.oldPrice = '',
  });

  final bool isLargeGridElement;
  final bool isDiscountVisible;
  final bool isFavoriteVisible;
  final bool isFavorite;
  final String img;
  final String lightText;
  final String boltText;
  final String newPrice;
  final String oldPrice;
  final double rate;
  final int countMessages;
  final int discount;
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
    @required this.newPrice,
    @required this.oldPrice,
  });

  final String img;
  final String name;
  final int newPrice;
  final int oldPrice;
}

class Promotion {
  Promotion({
    @required this.img,
    @required this.discount,
    @required this.discription,
    @required this.rate,
    @required this.newPrice,
    @required this.oldPrice,
  });

  final String img;
  final int discount;
  final String discription;
  final double rate;
  final int newPrice;
  final int oldPrice;
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
    @required this.userAvatarImg,
    @required this.userName,
    @required this.userRank,
    @required this.dateReview,
    @required this.textReview,
    @required this.service,
    @required this.kitchen,
    @required this.priceQuality,
    @required this.ambiance,
    this.likes = 0,
    this.response,
  });
  final String userAvatarImg;
  final String userName;
  final String userRank;
  final String dateReview;
  final String textReview;
  final int service;
  final int kitchen;
  final int priceQuality;
  final int ambiance;
  final int likes;
  final String response;
}
