import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/BLoC/search_result_bloc.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
    this.title,
    this.height = 56.0,
    this.actions = const [],
    this.bottom,
    this.backgroundColor = Colors.white,
    this.showBackArrow = true,
    this.elevation = 4.0,
  }) : super(key: key);

  final String title;
  final double height;
  final List<Widget> actions;
  final AppBarBottom bottom;
  final Color backgroundColor;
  final bool showBackArrow;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title ?? '',
        style: TextStyle(
          color: Colors.black,
          fontSize: height * 0.38,
        ),
      ),
      leading: Visibility(
        visible: showBackArrow,
        child: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Container(width: size(context, 0.035), child: cLeftArrow),
        ),
      ),
      actions: actions,
      bottom: bottom != null
          ? CustomBottomAppBar(
              preferredSize: preferredSize,
              tabController: bottom.tabController,
              bottomData: bottom.bottomData,
              isScrollable: bottom.isScrollable,
              labelPadding: bottom.labelPadding,
              onTap: bottom.onTap,
            )
          : null,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize =>
      bottom != null ? Size.fromHeight(height * 1.7) : Size.fromHeight(height);
}

class CustomAppBarWithSearch extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithSearch({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  _CustomAppBarWithSearchState createState() => _CustomAppBarWithSearchState();
}

class _CustomAppBarWithSearchState extends State<CustomAppBarWithSearch> {
  TextEditingController _textEditingController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(() {
        setState(() {
          if (_textEditingController.text.length > 0 && !_isVisible) {
            _isVisible = true;
          } else if (_textEditingController.text.length == 0) {
            _isVisible = false;
          }
        });
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: constraints.maxWidth * 0.1,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length > 3) {
                        BlocProvider.of<SearchResultBloc>(context).add(
                          SearchResultFetched(
                              searchText: _textEditingController.text),
                        );
                      }
                    },
                    style:
                        style3(context).copyWith(fontWeight: FontWeight.bold),
                    controller: _textEditingController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                          child: cSearchIcon,
                        ),
                        isCollapsed: true,
                        hintText: 'Поиск',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.5),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: cGrey,
                        filled: true),
                  ),
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                    BlocProvider.of<SearchResultBloc>(context).add(
                      SearchResultCleared(),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    child: Text(
                      'Отмена',
                      style: style3(context).copyWith(color: cPink),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottomAppBar({
    Key key,
    @required this.preferredSize,
    @required this.tabController,
    @required this.bottomData,
    @required this.onTap,
    @required this.isScrollable,
    @required this.labelPadding,
  }) : super(key: key);

  final Size preferredSize;
  final TabController tabController;
  final List<String> bottomData;
  final ValueChanged<int> onTap;
  final bool isScrollable;
  final EdgeInsets labelPadding;

  @override
  Widget build(BuildContext context) {
    print('-->CustomBottomAppBar');
    return PreferredSize(
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          height: preferredSize.height - (preferredSize.height * (1 / 1.7)),
          child: TabBar(
            isScrollable: isScrollable,
            controller: tabController,
            labelPadding: labelPadding,
            labelColor: cPink,
            indicatorColor: cPink,
            unselectedLabelColor: Colors.grey[600],
            onTap: onTap,
            tabs: bottomData
                .map(
                  (e) => Tab(
                    child: Text(
                      e,
                      style: style3(context),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      preferredSize: preferredSize,
    );
  }
}
