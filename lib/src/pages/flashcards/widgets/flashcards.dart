import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/memorization_level/memorization_level.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/pages/flashcards/widgets/flashcard.dart';
import 'package:vockify/src/pages/flashcards/widgets/flip_flashcard.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class FlashcardsWidget extends StatefulWidget {
  final int setId;

  const FlashcardsWidget({
    Key? key,
    required this.setId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlashcardsState();
}

class _FlashcardsState extends State<FlashcardsWidget> with SingleTickerProviderStateMixin {
  static const int _shiftLeftAnimationFactor = -2;
  static const int _shiftRightAnimationFactor = 2;

  List<TermModel?> _terms = [];

  Animation<double>? _shiftAnimation;
  AnimationController? _shiftAnimationController;

  bool _shiftToRight = false;

  TermModel? get _currentTerm => _terms.isNotEmpty ? _terms.first : null;

  TermModel? get _nextTerm => _terms.length > 1 ? _terms[1] : null;

  double get _shiftOffset =>
      ((_shiftAnimation?.value ?? 0) * MediaQuery.of(context).size.width) *
      (_shiftToRight ? _shiftRightAnimationFactor : _shiftLeftAnimationFactor);

  @override
  Widget build(BuildContext context) {
    final setsState = context.read<AppModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Stack(
              children: [
                if ((_shiftAnimation?.value ?? 0) > 0 && _nextTerm == null || _currentTerm == null)
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: VockifyColors.black,
                                fontSize: 18,
                                height: 1.3,
                              ),
                        ),
                      ),
                    ],
                  ),
                if ((_shiftAnimation?.value ?? 0) > 0 && _nextTerm != null) FlashCardWidget(text: _nextTerm!.name),
                if (_currentTerm != null)
                  Transform.translate(
                    offset: Offset(_shiftOffset, 0),
                    child: FlipFlashCardWidget(
                      key: Key(_currentTerm!.id.toString()),
                      term: _currentTerm!.name,
                      definition: _currentTerm!.definition,
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
              if (_terms.isNotEmpty) ...[
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
                      _shift();
                    },
                    child: Text(
                      'ЗНАЮ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      if (_currentTerm == null) {
                        return;
                      }
                      
                      _shift(toRight: true);

                      setsState.updateTerm(widget.setId, _currentTerm!.copyWith(
                        memorizationLevel: MemorizationLevel.bad,
                      ));
                    },
                    child: Text(
                      'НЕ ЗНАЮ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: VockifyColors.ghostWhite,
                            fontSize: 16,
                          ),
                    ),
                  ),
                )
              ],
              if (_terms.isEmpty)
                Expanded(
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    fillColor: VockifyColors.lightSteelBlue,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ВЕРНУТЬСЯ В СЛОВАРЬ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: VockifyColors.prussianBlue,
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
    _shiftAnimationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final setsState = context.read<AppModel>();
    final terms = setsState.state.sets[widget.setId]!.terms.terms;
    final ids = setsState.state.sets[widget.setId]!.terms.ids;

    _terms = ids.map((id) => terms[id]).toList();
    _terms.shuffle();

    _shiftAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _shiftAnimation = Tween<double>(end: 1, begin: 0).animate(_shiftAnimationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  void _shift({bool toRight = false}) {
    if (_terms.isEmpty) {
      return;
    }

    _shiftToRight = toRight;

    _shiftAnimationController?.forward().then((value) {
      _terms.removeAt(0);
      _shiftAnimationController?.reset();

      amplitude.logEvent('flashcards_swiped');
    });
  }
}
