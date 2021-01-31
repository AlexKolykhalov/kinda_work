import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class FillScale extends StatelessWidget {
  const FillScale({Key key, @required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: size(context, 0.02),
          ),
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Text(
            'Заполнение профиля (баллы)',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: LinearProgressIndicator(
                  value: value / 120,
                  minHeight: size(context, 0.03),
                  backgroundColor: cGrey,
                  valueColor: const AlwaysStoppedAnimation(cPink),
                ),
              ),
              Container(
                height: size(context, 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: Colors.grey[600]),
                ),
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) => Text(
                      '${(value / 120 * 100).toInt().toString()}%',
                      style: TextStyle(
                        color:
                            (value / 120 > 0.51) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxHeight * 0.65,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, 0.003)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScaleElement(value: '0'),
              ScaleElement(value: '30'),
              ScaleElement(value: '60'),
              ScaleElement(value: '90'),
              ScaleElement(value: '120'),
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
    @required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: size(context, 0.015),
        child: Text(
          '|',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.07,
        height: size(context, 0.019),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) => Text(
              value,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: constraints.maxHeight * 0.9,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class SocialNetworkAccountStatus extends StatelessWidget {
  const SocialNetworkAccountStatus({
    Key key,
    @required this.imgPath,
    @required this.name,
    @required this.isConnected,
  }) : super(key: key);

  final String imgPath;
  final String name;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.height * 0.04,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 13.0),
            Text(
              name,
              style: style2(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          (isConnected) ? 'Привязано' : 'Привязать',
          textAlign: TextAlign.right,
          style: style2(context).copyWith(
            color: isConnected ? Colors.black : cPink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
