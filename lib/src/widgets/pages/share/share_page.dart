import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/actions/request_translate_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/share/share_form.dart';
import 'package:vockify/src/widgets/pages/share/share_page_view_model.dart';

class SharePageWidget extends StatelessWidget {
  final String term;

  SharePageWidget(this.term);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.share,
      title: 'ДОБАВИТЬ СЛОВО',
      onInit: (store) {
        store.dispatch(RequestSetsAction());
        store.dispatch(RequestTranslateAction(term));
      },
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: StoreConnector<AppState, SharePageViewModel>(
                    distinct: true,
                    converter: (store) => SharePageViewModel.fromStore(store),
                    builder: (context, viewModel) {
                      return ShareFormWidget(
                        term: term,
                        definition: viewModel.translatedDefinition,
                        sets: viewModel.sets,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
