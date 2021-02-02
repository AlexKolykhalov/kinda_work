import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinda_work/BLoC/bloc/transition_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/other/pages/discount/discount_conditions_page.dart';
import 'package:kinda_work/other/pages/discount/thanks_page.dart';
import 'package:kinda_work/other/pages/discount/visit_history_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class DiscountDetailsPage extends StatefulWidget {
  const DiscountDetailsPage({
    Key key,
    this.canPop = true,
  }) : super(key: key);

  final bool canPop;

  @override
  _DiscountDetailsPageState createState() => _DiscountDetailsPageState();
}

class _DiscountDetailsPageState extends State<DiscountDetailsPage> {
  FocusNode _focusNode = FocusNode();
  bool _isVisible = true;
  double _appBarHeight;
  double _height;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
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
  void didChangeDependencies() {
    MediaQueryData _mq = MediaQuery.of(context);
    _appBarHeight = appBarHeight(context);
    _height =
        _mq.size.height - _mq.padding.top - _appBarHeight - bottomAppHeight;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('-->DiscountDetailsPage');
    return BlocProvider(
      create: (context) => TransitionBloc(),
      child: BlocBuilder<TransitionBloc, TransitionState>(
        builder: (context, state) {
          if (state is TransitionLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(_appBarHeight),
              child: AppBar(
                backgroundColor: cGrey,
                elevation: _isVisible ? 0.0 : 4.0,
                leading: Visibility(
                  visible: widget.canPop,
                  child: CustomFlatButton(
                    icon: svgLeftArrow,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                centerTitle: true,
                title: _isVisible
                    ? null
                    : Container(
                        width: _appBarHeight * 0.85,
                        height: _appBarHeight * 0.85,
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
              child: Container(
                height: _height,
                padding: EdgeInsets.symmetric(
                  horizontal: size(context, 0.07),
                  vertical: size(context, vert),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _isVisible,
                      child: Container(
                        width: size(context, 0.16),
                        height: size(context, 0.16),
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
                      onTap: () {
                        final Widget _discountConditionsPage =
                            DiscountConditionsPage();
                        return Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 0),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    _discountConditionsPage,
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size(context, 0.03)),
                        child: Text(
                          'Смотреть условия скидки',
                          style: style2(context).copyWith(color: cPink),
                        ),
                      ),
                    ),
                    Row(
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
                            onTap: () {
                              final Widget _thanksPage =
                                  ThanksPage(text: 'Скидка зафиксирована');
                              return Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 0),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      _thanksPage,
                                ),
                              );
                            },
                            text: 'OK',
                            color: cPink,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Visibility(
                      visible: _isVisible ?? false,
                      child: CustomButton(
                        onTap: () {
                          final Widget _visitHistoryPage = VisitHistoryPage(
                            historyVisits: historyVisitsOneUser,
                          );
                          return Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(seconds: 0),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      _visitHistoryPage,
                            ),
                          );
                        },
                        text: 'Посетил 8 раз',
                        color: cGrey,
                        borderColor: Colors.grey[600],
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
