import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/main/pages/discount/discount_conditions.dart';
import 'package:kinda_work/main/pages/discount/thanks_page.dart';
import 'package:kinda_work/main/pages/discount/visit_history_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/widgets.dart';

class DiscountDetailsPage extends StatefulWidget {
  const DiscountDetailsPage({Key key}) : super(key: key);

  @override
  _DiscountDetailsPageState createState() => _DiscountDetailsPageState();
}

class _DiscountDetailsPageState extends State<DiscountDetailsPage> {
  Size _size;
  bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height * 0.85),
          child: AppBar(
            backgroundColor: cGrey,
            elevation: (_isVisible) ? 0.0 : 1.0,
            leading: FlatButton(
              padding: EdgeInsets.all(13.0),
              onPressed: () => Navigator.pop(context),
              child: cLeftArrow,
            ),
            centerTitle: true,
            title: _isVisible
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
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            width: _size.width,
            height: _size.height - MediaQuery.of(context).padding.top - 48.0,
            padding: EdgeInsets.symmetric(vertical: _size.height * cVertical),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _isVisible,
                      child: Container(
                        width: _size.height * 0.2,
                        height: _size.height * 0.2,
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
                        _size.height * 0.02,
                        0.0,
                        _size.height * 0.015,
                      ),
                      child: Text('Роман Красновский',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _size.height * 0.04)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.04),
                      child:
                          Text('19.08.1980', style: TextStyle(fontSize: 15.0)),
                    ),
                    Text('5 %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _size.height * 0.07)),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.04),
                      child: Text('Размер скидки',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.05),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 0),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    DiscountConditionsPage(size: _size),
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
                      width: _size.width * 0.65,
                      padding: _isVisible
                          ? EdgeInsets.only(bottom: _size.height * 0.07)
                          : EdgeInsets.only(bottom: _size.height * 0.01),
                      child: Row(
                        children: [
                          Container(
                            width: _size.width * 0.5,
                            child: TextField(
                              onTap: () {
                                setState(() {
                                  _isVisible = false;
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  _isVisible = true;
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
                                    horizontal: _size.width * 0.05),
                              ),
                            ),
                          ),
                          SizedBox(width: _size.width * 0.01),
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
                                        ThanksPage(
                                            text: 'Скидка зафиксирована'),
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
                  ],
                ),
                Visibility(
                  visible: _isVisible,
                  child: Container(
                    width: _size.width * 0.65,
                    child: CustomButton(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
