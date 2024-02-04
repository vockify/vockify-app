import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/memorization_level/memorization_level.dart';
import 'package:vockify/src/pages/quiz/widgets/models/quiz_result.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';

class QuizResultWidget extends StatelessWidget {
  static const List<String> _cheerPhrases = const [
    'Чтобы дойти до цели, надо идти',
    'В моем словаре нет слова «невозможно»',
    'Неважно, плоха ли ситуация или хороша — она изменится',
    'Самое тяжелое в жизни — это синий кит, все остальное пустяки!',
    'Если путь ведет к цели, то безразлично, какова его длина',
    'Что не убивает, делает тебя сильнее',
  ];

  static const List<String> _congratulationPhrases = const [
    'Ты потрясающий!',
    'Великолепно!',
    'Это невероятно!',
  ];

  final QuizResult result;
  final VoidCallback? onPressContinue;

  const QuizResultWidget({
    Key? key,
    required this.result,
    this.onPressContinue,
  }) : super(key: key);

  int get _correctCount => result.termIds.length - result.wrongIds.length;

  int get _percentage => (_correctCount / result.termIds.length * 100).round();

  @override
  Widget build(BuildContext context) {
    final appModel = context.read<AppModel>();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: result.termIds.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, top: 30, right: 20, bottom: 10),
                      child: Text(
                        _getPhrase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 40,
                            color: VockifyColors.lightSteelBlue,
                          ),
                          Container(
                            height: 40,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return FractionallySizedBox(
                                widthFactor:
                                    _correctCount / result.termIds.length,
                                child: Container(
                                  color: VockifyColors.success,
                                ),
                              );
                            }),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                '$_percentage%',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: VockifyColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }

              final id = result.termIds[index - 1];

              final term = appModel.getTermById(id);

              return Card(
                color: VockifyColors.ghostWhite,
                child: ListTile(
                  trailing: _getTermIcon(term?.memorizationLevel),
                  title: Text(
                    term?.name ?? '',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  subtitle: Text(term?.definition ?? ''),
                ),
              );
            },
          ),
        ),
        AppButtonBarWidget(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: LinearBorder(),
                backgroundColor: VockifyColors.fulvous,
              ),
              onPressed: onPressContinue,
              child: Text(
                'ПРОДОЛЖИТЬ ИЗУЧЕНИЕ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: VockifyColors.white,
                      fontSize: 16,
                    ),
              ),
            ),
          ],
        )
      ],
    );
  }

  String _getPhrase() {
    if (_percentage == 100) {
      return _congratulationPhrases[
          Random().nextInt(_congratulationPhrases.length)];
    }

    return _cheerPhrases[Random().nextInt(_cheerPhrases.length)];
  }

  Widget? _getTermIcon(MemorizationLevel? memorizationLevel) {
    IconData? icon;

    if (memorizationLevel == MemorizationLevel.bad) {
      icon = Icons.not_interested;
    } else if (memorizationLevel == MemorizationLevel.good) {
      icon = Icons.done;
    } else if (memorizationLevel == MemorizationLevel.great) {
      icon = Icons.done_all;
    }

    return icon != null ? Icon(icon) : null;
  }
}
