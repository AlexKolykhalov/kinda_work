import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/main/pages/discount/discount_conditions.dart';
import 'package:kinda_work/main/pages/discount/thanks_page.dart';
import 'package:kinda_work/widgets.dart';

class DiscountDetailsPage extends StatefulWidget {
  const DiscountDetailsPage({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _DiscountDetailsPageState createState() => _DiscountDetailsPageState();
}

class _DiscountDetailsPageState extends State<DiscountDetailsPage> {
  bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: cGrey,
          elevation: (isVisible) ? 0.0 : 1.0,
          leading: FlatButton(
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MainPage(),
              ),
            ),
            child: SvgPicture.asset(
              'assets/svg/left_arrow.svg',
              fit: BoxFit.contain,
            ),
          ),
          centerTitle: true,
          title: isVisible
              ? null
              : Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/png/face.png'),
                    ),
                  ),
                ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: widget.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      width: widget.size.height * 0.2,
                      height: widget.size.height * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/png/face.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0.0,
                      widget.size.height * 0.02,
                      0.0,
                      widget.size.height * 0.015,
                    ),
                    child: Text('Роман Красновский',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: widget.size.height * 0.04)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: widget.size.height * 0.04),
                    child: Text('19.08.1980', style: TextStyle(fontSize: 15.0)),
                  ),
                  Text('5 %',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widget.size.height * 0.07)),
                  Padding(
                    padding: EdgeInsets.only(bottom: widget.size.height * 0.04),
                    child:
                        Text('Размер скидки', style: TextStyle(fontSize: 15.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: widget.size.height * 0.05),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DiscountConditionsPage(size: widget.size),
                        ),
                      ),
                      child: Text(
                        'Смотреть условия скидки',
                        style: TextStyle(
                          color: cPink,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: widget.size.width * 0.65,
                    padding: isVisible
                        ? EdgeInsets.only(bottom: widget.size.height * 0.07)
                        : EdgeInsets.only(bottom: widget.size.height * 0.01),
                    child: Row(
                      children: [
                        Container(
                          width: widget.size.width * 0.5,
                          child: TextField(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                isVisible = true;
                              });
                            },
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Сумма чека',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.05),
                            ),
                          ),
                        ),
                        SizedBox(width: widget.size.width * 0.01),
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: cPink,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 0),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ThanksPage(size: widget.size),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      width: widget.size.width * 0.65,
                      child: CustomButton(
                          // onTap: VisitHistoryPage(size: widget.size),
                          onTap: null,
                          buttonText: 'Посетил 8 раз',
                          buttonColor: cGrey,
                          buttonBorderColor: Colors.grey[600],
                          buttonTextColor: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
