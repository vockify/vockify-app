import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class TranscriptionTextWidget extends StatefulWidget {
  final String term;
  final String transcription;

  const TranscriptionTextWidget({Key key, this.term, this.transcription}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranscriptionTextWidgetState();
}

class _TranscriptionTextWidgetState extends State<TranscriptionTextWidget> {
  bool _play = false;

  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
        distinct: true,
        converter: (store) => authToken(store.state),
        builder: (context, apiToken) {
          return Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(children: [
                RichText(
                  text: TextSpan(
                    text: widget.term,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 20,
                        ),
                    children: [
                      TextSpan(
                        text: ' [${widget.transcription}]',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 20,
                              color: VockifyColors.lightSteelBlue,
                            ),
                      ),
                    ],
                  ),
                ),
                AudioWidget(
                  audio: Audio.network(
                    "http://${AppApi.apiUri}/speech/${widget.term}",
                    headers: {
                      'Authorization': 'Bearer $apiToken',
                    },
                  ),
                  play: _play,
                  child: ButtonTheme(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
                    height: 0,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _play = !_play;
                        });
                      },
                      color: VockifyColors.fulvous,
                      textColor: Colors.white,
                      child: Icon(
                        _play ? Icons.pause : Icons.volume_up,
                        size: 15,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                  onFinished: () {
                    setState(() {
                      _play = false;
                    });
                  },
                ),
              ]));
        });
  }
}
