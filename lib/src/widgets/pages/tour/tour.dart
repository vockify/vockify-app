import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_authorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';

class TourWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TourWidgetState();
  }
}

class _TourWidgetState extends State<TourWidget> {
  static final List<String> _slides = [
    'Создавайте словари и добавляйте новые слова с автоматическим переводом',
    'Вы можете "поделиться" словом с Vockify из любого другого приложения, выделив его в тексте, и сразу же добавить в словарь с переводом',
    'Запоминайте новые слова с помощью игры в квиз',
    'Для того, что бы пользоваться всеми функциями приложения, вам необходимо авторизоваться',
  ];

  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return _buildWrapper(Center(
      child: Column(
        children: <Widget>[
          _buildCarouselSlider(context),
          _buildCarouselIndicator(context),
          _buildAppButtonBar(context),
        ],
      ),
    ));
  }

  Widget _buildAppButtonBar(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);

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
          onPressed: () {
            _finishTour(store, skip: true);
          },
        ),
        RaisedButton(
          shape: Border(),
          color: VockifyColors.fulvous,
          child: Text(
            _current != _slides.length - 1 ? "ПРОДОЛЖИТЬ" : "АВТОРИЗОВАТЬСЯ",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.white,
                  fontSize: 16,
                ),
          ),
          onPressed: () {
            if (_current < _slides.length - 1) {
              _controller.nextPage();
            } else {
              _finishTour(store);
            }
          },
        ),
      ],
    );
  }

  Widget _buildCarouselIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Iterable<int>.generate(_slides.length).toList().map((index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index ? VockifyColors.prussianBlue : VockifyColors.lightSteelBlue,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCarouselSlider(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Expanded(
      child: CarouselSlider(
        items: _slides
            .map((item) => Container(
                  margin: EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: VockifyColors.prussianBlue,
                          ),
                    ),
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
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildWrapper(Widget widget) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (store) => store.state.isAuthorized,
      builder: (context, isAuthorized) {
        return isAuthorized ? Container() : widget;
      },
    );
  }

  Future<void> _finishTour(Store store, {bool skip = false}) async {
    final storage = AppStorage.getInstance();
    await storage.setValue(AppStorageKey.isTourFinished, true.toString());

    if (skip) {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false));
    } else {
      store.dispatch(RequestAuthorizeAction());
    }
  }
}
