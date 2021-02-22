import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/flashcards/flashcard.dart';
import 'package:vockify/src/widgets/flashcards/flip_flashcard.dart';

class FlashcardsWidget extends StatefulWidget {
  final Iterable<int> ids;

  const FlashcardsWidget({Key key, this.ids}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlashcardsState();
}

class _FlashcardsState extends State<FlashcardsWidget> with SingleTickerProviderStateMixin {
  List<TermState> _terms = [];

  Animation<double> _shiftAnimation;
  AnimationController _shiftAnimationController;

  int _shiftAnimationDirection = 1;

  TermState get _nextTerm => _terms.length > 1 ? _terms[1] : null;

  TermState get _currentTerm => _terms.length > 0 ? _terms.first : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Stack(
              children: [
                if (_shiftAnimation.value > 0 && _nextTerm == null || _currentTerm == null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.done,
                        color: VockifyColors.black,
                        size: 64,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(48, 0, 48, 16),
                        child: Text(
                          'Вы просмотрели все карточки',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: VockifyColors.black,
                            fontSize: 18,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_shiftAnimation.value > 0 && _nextTerm != null) FlashCardWidget(text: _nextTerm.name),
                if (_currentTerm != null)
                  Transform.translate(
                    offset: Offset(_shiftAnimation.value * _shiftAnimationDirection, 0),
                    child: FlipFlashCardWidget(
                      key: Key(_currentTerm.id.toString()),
                      term: _currentTerm.name,
                      definition: _currentTerm.definition,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
          alignment: Alignment.bottomCenter,
          child: Row(
            children: <Widget>[
              Expanded(
                child: RawMaterialButton(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  fillColor: VockifyColors.persianGreen,
                  onPressed: () {
                    _next(-1);
                  },
                  child: Text(
                    'ЗНАЮ',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: VockifyColors.ghostWhite,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: RawMaterialButton(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  fillColor: VockifyColors.flame,
                  onPressed: () {
                    _next(1);
                  },
                  child: Text(
                    'НЕ ЗНАЮ',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: VockifyColors.ghostWhite,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _shiftAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final store = StoreProvider.of<AppState>(context, listen: false);

    _terms = widget.ids.map((id) => getTermById(store.state, id)).toList();
    _terms.shuffle();

    _shiftAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _shiftAnimation = Tween<double>(end: 1000, begin: 0).animate(_shiftAnimationController)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _next(int direction) {
    if (_terms.length == 0) {
      return;
    }

    _shiftAnimationDirection = direction;

    _shiftAnimationController.forward().then((value) {
      _terms.removeAt(0);
      _shiftAnimationController.reset();
    });
  }
}
