import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/discount/discount_details_page.dart';
import 'package:kinda_work/styles.dart';

class EmailPhoneTextField extends StatefulWidget {
  EmailPhoneTextField({Key key}) : super(key: key);

  @override
  _EmailPhoneTextFieldState createState() => _EmailPhoneTextFieldState();
}

class _EmailPhoneTextFieldState extends State<EmailPhoneTextField> {
  bool _switcher = true;

  @override
  Widget build(BuildContext context) {
    return _switcher
        ? EmailTextField(
            onPressed: () {
              setState(() {
                _switcher = false;
              });
            },
            isVisibleIcon: true)
        : PhoneTextField(
            onPressed: () {
              setState(() {
                _switcher = true;
              });
            },
            isVisibleIcon: true,
          );
  }
}

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    Key key,
    this.onPressed,
    this.isVisibleIcon = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isVisibleIcon;

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: math.min(size(context, 0.075), 48.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',
                  hintStyle: style2(context),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                ),
              ),
              Visibility(
                visible: widget.isVisibleIcon,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: widget.onPressed,
                  padding: EdgeInsets.zero,
                  iconSize: constraints.maxHeight * 0.5,
                  icon: Icon(Icons.phone, color: cPink),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    Key key,
    this.onPressed,
    this.maxLength,
    this.isVisibleIcon = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final int maxLength;
  final bool isVisibleIcon;

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO make propper phone number fotmatter
    return Container(
      height: math.min(size(context, 0.075), 48.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                onChanged: (value) {
                  if (widget.maxLength != null &&
                      value.length == widget.maxLength) {
                    final Widget _discountDetailsPage = DiscountDetailsPage();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 5),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            _discountDetailsPage,
                      ),
                    );
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                controller: _controller,
                maxLength: widget.maxLength,
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.center,
                style: style2(context),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '(XX) XXX-XX-XX',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  prefixIcon: Container(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+375',
                          style: style2(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: constraints.maxHeight * 0.6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isVisibleIcon,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: widget.onPressed,
                  padding: EdgeInsets.zero,
                  iconSize: constraints.maxHeight * 0.5,
                  icon: Icon(Icons.email, color: cPink),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key key}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _controller = TextEditingController();
  bool _obscureText = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: math.min(size(context, 0.075), 48.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _controller,
                obscureText: _obscureText,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Пароль',
                  hintStyle: style2(context),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => setState(() {
                  _obscureText = !_obscureText;
                }),
                padding: EdgeInsets.zero,
                iconSize: constraints.maxHeight * 0.5,
                icon: Icon(
                  Icons.remove_red_eye,
                  color: _obscureText ? Colors.grey : cPink,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key key,
    this.text,
    this.maxLength,
    this.focusNode,
    this.fontWeight = FontWeight.normal,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.isMultiLines = false,
    this.popupMenuItems = const [],
  }) : super(key: key);

  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String text;
  final int maxLength;
  final FontWeight fontWeight;
  final String hintText;
  final bool isEnabled;
  final List<dynamic> popupMenuItems;
  final bool isMultiLines;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController _controller;
  double _height;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.isMultiLines) {
      _height = null;
    } else {
      _height = math.min(size(context, 0.075), 48.0);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                focusNode: widget.focusNode,
                controller: _controller,
                onChanged: (value) {
                  if (widget.maxLength != null &&
                      value.length == widget.maxLength) {
                    final Widget _discountDetailsPage = DiscountDetailsPage();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 5),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            _discountDetailsPage,
                      ),
                    );
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                keyboardType: widget.keyboardType,
                textAlignVertical: TextAlignVertical.center,
                maxLength: widget.maxLength,
                minLines: widget.isMultiLines ? 6 : 1,
                maxLines: widget.isMultiLines ? 6 : 1,
                style: style2(context).copyWith(
                  color: widget.isEnabled ? Colors.black : Colors.grey[600],
                  fontWeight: widget.fontWeight,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  enabled: widget.isEnabled,
                  fillColor: Colors.white,
                  filled: widget.isEnabled ?? false,
                  hintText: widget.hintText,
                  hintStyle:
                      style2(context).copyWith(fontWeight: FontWeight.normal),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                    vertical: widget.isMultiLines ? 5.0 : 0.0,
                  ),
                ),
              ),
              Visibility(
                visible: widget.popupMenuItems.isNotEmpty,
                child: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: cPink,
                  ),
                  onSelected: (String val) {
                    _controller.text = val;
                  },
                  itemBuilder: (context) => widget.popupMenuItems
                      .map<PopupMenuItem<String>>((dynamic val) =>
                          PopupMenuItem(child: Text(val), value: val))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
