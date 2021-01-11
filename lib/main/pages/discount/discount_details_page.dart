import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/pages/discount/discount_conditions.dart';
import 'package:kinda_work/main/pages/discount/thanks_page.dart';
import 'package:kinda_work/main/pages/discount/visit_history_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

double _c;

class DiscountDetailsPage extends StatefulWidget {
  const DiscountDetailsPage({Key key}) : super(key: key);

  @override
  _DiscountDetailsPageState createState() => _DiscountDetailsPageState();
}

class _DiscountDetailsPageState extends State<DiscountDetailsPage> {
  FocusNode _focusNode;
  bool _isVisible;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_focusNodeListener);
    _isVisible = true;
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode.hasFocus) {
      setState(() {
        _isVisible = false;
      });
    } else {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight(context)),
          child: AppBar(
            backgroundColor: cGrey,
            elevation: (_isVisible) ? 0.0 : 4.0,
            leading: FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Container(width: size(context, 0.035), child: cLeftArrow),
            ),
            centerTitle: true,
            title: _isVisible
                ? null
                : Container(
                    width: appBarHeight(context) * 0.85,
                    height: appBarHeight(context) * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/png/face.png'),
                      ),
                    ),
                  ),
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // double _height = MediaQuery.of(context).size.height;
            // double _constr = constraints.maxHeight;
            // double _appBarHeight = appBarHeight(context);
            // double _vert = size(context, vert);
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    appBarHeight(context),
                padding: EdgeInsets.symmetric(
                    horizontal: size(context, 0.07),
                    vertical: size(context, vert)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _isVisible,
                      child: Container(
                        width: size(context, 0.17),
                        height: size(context, 0.17),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/png/face.png'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size(context, 0.02)),
                    Text(
                      'Роман Красновский',
                      style:
                          style1(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size(context, 0.01)),
                    Text('19.08.1980', style: style2(context)),
                    SizedBox(height: size(context, 0.025)),
                    Text(
                      '5%',
                      style: TextStyle(
                        fontSize: size(context, 0.08),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Размер скидки', style: style3(context)),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DiscountConditionsPage(),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size(context, 0.03)),
                        child: Text(
                          'Смотреть условия скидки',
                          style: style2(context).copyWith(color: cPink),
                        ),
                      ),
                    ),
                    Container(
                      // padding: _isVisible
                      //     ? EdgeInsets.only(bottom: _size.height * 0.07)
                      //     : EdgeInsets.only(bottom: _size.height * 0.01),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              focusNode: _focusNode,
                              fontWeight: FontWeight.bold,
                              hintText: 'Сумма чека',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: size(context, hor)),
                          Expanded(
                            child: CustomButton(
                              onTap: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 0),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ThanksPage(text: 'Скидка зафиксирована'),
                                ),
                              ),
                              buttonText: 'OK',
                              buttonColor: cPink,
                              buttonTextColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Visibility(
                      visible: _isVisible,
                      child: CustomButton(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 0),
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                VisitHistoryPage(
                                    historyVisits: historyVisitsOneUser),
                          ),
                        ),
                        buttonText: 'Посетил 8 раз',
                        buttonColor: cGrey,
                        buttonBorderColor: Colors.grey[600],
                        buttonTextColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
