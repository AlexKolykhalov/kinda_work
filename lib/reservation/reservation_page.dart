import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({
    Key key,
    @required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Scaffold(
      appBar: CustomAppBar(
        height: appBarHeight(context),
        title: 'Бронирование',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
              child: SearchCompany(
                element: company,
                visibleRateArrowElements: false,
              ),
            ),
            Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.only(top: _vert),
              child: Option1Widgets(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: _hor),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _vert),
                    child: TimeScheduleWidget(
                        bookingSchedule: company.bookingSchedule),
                  ),
                  TextFieldWidgets(),
                  Padding(
                    padding: EdgeInsets.only(top: _vert * 2, bottom: _vert),
                    child: CustomButton(
                      onTap: () {},
                      text: 'Забронировать',
                      color: cPink,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Option1Widgets extends StatelessWidget {
  const Option1Widgets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: _hor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Дата',
                  style: style3(context).copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: _hor / 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('8 Июля 2020', style: style2(context)),
                    CustomRedRightArrow(onPressed: null),
                  ],
                ),
                Divider(thickness: 1.0),
              ],
            ),
          ),
        ),
        SizedBox(width: _vert),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Кол-во чел.',
                style: style3(context).copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: _hor / 4),
              Container(
                padding: EdgeInsets.only(right: _hor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('4', style: style2(context)),
                    CustomRedRightArrow(onPressed: null),
                  ],
                ),
              ),
              Divider(thickness: 1.0),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeScheduleWidget extends StatelessWidget {
  const TimeScheduleWidget({
    Key key,
    this.bookingSchedule = const [],
  }) : super(key: key);

  final List bookingSchedule;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Время',
          style: style3(context).copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: _hor),
        TimeGrid(bookingSchedule: bookingSchedule),
      ],
    );
  }
}

class TextFieldWidgets extends StatelessWidget {
  const TextFieldWidgets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    return Column(children: [
      CustomTextField(
        hintText: 'Пожелания (необязательно)',
        maxLines: 3,
        minLines: 3,
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: _hor),
        child: CustomTextField(text: 'Фредди Макгрегор'),
      ),
      PhoneTextField(
        text: '(50) 780-99-01',
      ),
      SizedBox(height: _hor),
      Visibility(
        visible: true,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'СМС-код',
              errorText: 'Неверный формат кода',
            ),
            SizedBox(height: _hor),
          ],
        ),
      )
    ]);
  }
}

class TimeGrid extends StatefulWidget {
  const TimeGrid({
    Key key,
    this.bookingSchedule,
  }) : super(key: key);

  final List<Map> bookingSchedule;

  @override
  _TimeGridState createState() => _TimeGridState();
}

class _TimeGridState extends State<TimeGrid> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.bookingSchedule
              .take(4)
              .toList()
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = entry.key;
                    });
                  },
                  child: TimeGridElement(
                    value: entry.value['time'],
                    isSelected: entry.key == _index,
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: size(context, hor)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.bookingSchedule
              .getRange(4, 8)
              .toList()
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = entry.key + 4;
                    });
                  },
                  child: TimeGridElement(
                    value: entry.value['time'],
                    isSelected: entry.key + 4 == _index && entry.key + 4 != 7,
                    isLast: entry.key + 4 == 7,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class TimeGridElement extends StatelessWidget {
  const TimeGridElement({
    Key key,
    this.isSelected = false,
    this.isLast = false,
    this.value = '',
  }) : super(key: key);

  final bool isSelected;
  final bool isLast;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: size(context, 0.11),
      height: size(context, 0.05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(context, 0.8)),
          color: isSelected ? Colors.green : Colors.white),
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
      child: Center(
        child: isLast
            ? Icon(Icons.more_horiz)
            : Text(
                value,
                style: style3(context).copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
