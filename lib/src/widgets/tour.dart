import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';

import '../vockify_colors.dart';
import 'app_layout.dart';

class TourWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TourWidgetState();
  }
}

class _TourWidgetState extends State<TourWidget> {
  static final List<Widget> _slides = [
    Text(
      'Переводите слова с Vockify!',
      textAlign: TextAlign.center,
    ),
    Text(
      'Вы можете поделиться словом с Vockify и оно добавиться в категорию с переводом!',
      textAlign: TextAlign.center,
    ),
    Text(
      'Учите слова играя в Quiz!',
      textAlign: TextAlign.center,
    ),
  ];

  final CarouselController _controller = CarouselController();

  int _current = 0;

  Widget _carousel(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Expanded(
      child: CarouselSlider(
        items: _slides
            .map((item) => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: item,
                  ),
                ))
            .toList(),
        carouselController: _controller,
        options: CarouselOptions(
          height: height,
          enlargeCenterPage: false,
          autoPlay: false,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          scrollPhysics: NeverScrollableScrollPhysics(),
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ),
    );
  }

  Widget _indicatorRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Iterable<int>.generate(_slides.length).toList().map((index)  {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }).toList(),
    );
  }

  void _saveAndFinish(Store store) async {
    final storage = AppStorage.getInstance();
    await storage.setValue('isTourFinished', true.toString());

    store.dispatch(RequestDataAction(route: Routes.sets));
  }

  Widget _appButtonBar(BuildContext context, Store store) {
    return AppButtonBarWidget(
      children: <Widget>[
        RaisedButton(
          shape: Border(),
          color: VockifyColors.grey,
          child: Text(
            "ПРОПУСТИТЬ",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.prussianBlue,
                  fontSize: 16,
                ),
          ),
          onPressed: () async {
            _saveAndFinish(store);
          },
        ),
        RaisedButton(
          shape: Border(),
          color: VockifyColors.fulvous,
          child: Text(
            _current != _slides.length - 1 ? "ПРОДОЛЖИТЬ" : "НАЧАТЬ",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.white,
                  fontSize: 16,
                ),
          ),
          onPressed: () async {
            if (_current < _slides.length - 1) {
              _controller.nextPage();
            } else {
              _saveAndFinish(store);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);

    return AppLayoutWidget(
      title: 'VOCKIFY',
      body: Center(
        child: Column(
          children: <Widget>[
            _carousel(context),
            _indicatorRow(context),
            _appButtonBar(context, store),
          ],
        ),
      ),
    );
  }
}
