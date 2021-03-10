import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/repository.dart';

class AppBarBottom {
  AppBarBottom({
    @required this.tabController,
    @required this.bottomData,
    this.onTap,
    this.isScrollable = false,
    this.labelPadding = EdgeInsets.zero,
  });
  final TabController tabController;
  final List<String> bottomData;
  final ValueChanged<int> onTap;
  final bool isScrollable;
  final EdgeInsets labelPadding;
}

class TabsStyle {
  const TabsStyle({
    this.isScrolling = true,
    this.indicator,
    this.indicatorColor,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelStyle = const TextStyle(fontWeight: FontWeight.normal),
    this.unselectedLabelColor,
  });

  final bool isScrolling;
  final Decoration indicator;
  final Color indicatorColor;
  final Color labelColor;
  final TextStyle labelStyle;
  final EdgeInsets labelPadding;
  final TextStyle unselectedLabelStyle;
  final Color unselectedLabelColor;
}

class Company {
  Company({
    @required this.img,
    @required this.type,
    @required this.name,
    this.adress,
    this.web = '',
    this.menu = const <Menu>[],
    this.news = const <News>[],
    this.bookingSchedule = const [],
    this.rate = 0.0,
    this.favorite = false,
    this.messages = 0,
    this.discount = 0,
  });

  final String img;
  final String type;
  final String name;
  final String adress;
  final String web;
  final List<Menu> menu;
  final List<News> news;
  final List<Map> bookingSchedule;
  final double rate;
  final bool favorite;
  final int messages;
  final int discount;
}

class Menu {
  Menu({
    @required this.img,
    @required this.name,
    this.description = '',
    this.newPrice = 0.0,
    this.oldPrice = 0.0,
  });

  final String img;
  final String name;
  final String description;
  final num newPrice;
  final num oldPrice;
}

class News {
  News({
    @required this.date,
    @required this.img,
    this.name = '',
    this.description = '',
  });

  final String date;
  final String img;
  final String name;
  final String description;
}

class Promotion {
  Promotion({
    @required this.img,
    @required this.company,
    @required this.description,
    this.type,
    this.rate = 0.0,
    this.favorite = false,
    this.messages = 0,
    this.discount = 0,
    this.oldPrice = 0.0,
    this.newPrice = 0.0,
  });

  final String img;
  final Company company;
  final String description;
  final String type;
  final double rate;
  final bool favorite;
  final int messages;
  final int discount;
  final num oldPrice;
  final num newPrice;
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

// class VisitedCompany {
//   final String date;
//   final Company company;
//   final User user;
//   final double moneySpend;
// }

// class UsedPromo {
//   final String date;
//   final Promotion promotion;
//   final User user;
// }
class DiscountCard {
  DiscountCard({
    this.cardNumber,
    this.name,
    this.img,
    this.notes,
  });

  final int cardNumber;
  final String name;
  final List<Image> img;
  final List<String> notes;
}

class User {
  const User({
    this.avatar = 'assets/png/face.png',
    @required this.name,
    @required this.birthday,
    this.phone = '',
    this.about = '',
    this.points = 0,
    this.giftPoints = 0,
    this.reviews = const [],
    this.socialMediaAccounts = const [],
  });

  final String avatar;
  final String name;
  final String birthday;
  final String phone;
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
    @required this.companies,
    @required this.promotions,
  });

  final int id;
  final LatLng position;
  final List<Company> companies;
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
