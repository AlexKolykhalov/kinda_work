import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';

class FillOutProfile extends StatelessWidget {
  const FillOutProfile({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * cHorizont,
              0.0,
              size.width * cHorizont,
              size.height * 0.05,
            ),
            child: Text(
              'Заполнение профиля (баллы)',
              style: TextStyle(
                  fontSize: size.height * 0.025,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width * cHorizont),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[600]),
                      borderRadius: BorderRadius.circular(7.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: LinearProgressIndicator(
                      value: 0.25,
                      minHeight: size.height * 0.04,
                      backgroundColor: cGrey,
                      valueColor: const AlwaysStoppedAnimation(cPink),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.0055,
                left: size.width / 2 - size.width * 0.02,
                child: Text(
                  '75%',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaleElement(size: size, value: '0'),
                ScaleElement(size: size, value: '30'),
                ScaleElement(size: size, value: '60'),
                ScaleElement(size: size, value: '90'),
                ScaleElement(size: size, value: '120'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * cHorizont,
              size.height * 0.05,
              size.width * cHorizont,
              size.height * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Осталось заполнить',
                  style: TextStyle(
                      fontSize: size.height * 0.025,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '+25%',
                  style: TextStyle(
                    color: cPink,
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * cHorizont),
            child: Column(children: [
              SocialNetworkAccountStatus(
                size: size,
                imgPath: 'assets/png/facebook.png',
                name: 'Facebook',
                isConnected: false,
              ),
              Divider(color: Colors.grey[600]),
              SocialNetworkAccountStatus(
                size: size,
                imgPath: 'assets/png/vk.png',
                name: 'ВКонтакте',
                isConnected: true,
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class SocialNetworkAccountStatus extends StatelessWidget {
  const SocialNetworkAccountStatus({
    Key key,
    @required this.size,
    @required this.imgPath,
    @required this.name,
    @required this.isConnected,
  }) : super(key: key);

  final Size size;
  final String imgPath;
  final String name;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.height * 0.05,
          height: size.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.3),
            image: DecorationImage(
              image: AssetImage(imgPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.025,
                ),
              ),
              Container(
                  width: size.width * 0.3,
                  child: Text(
                    (isConnected) ? 'Привязано' : 'Привязать',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: (isConnected) ? Colors.black : cPink,
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class ScaleElement extends StatelessWidget {
  const ScaleElement({
    Key key,
    @required this.size,
    @required this.value,
  }) : super(key: key);

  final Size size;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('|', style: TextStyle(color: Colors.grey[600])),
      Container(
        width: size.width * 0.08,
        height: size.height * 0.03,
        child: Center(
          child: Text(value, style: TextStyle(color: Colors.grey[600])),
        ),
      ),
    ]);
  }
}
