import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class AudioTextWidget extends StatefulWidget {
  final String text;

  const AudioTextWidget({Key key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioTextState();
}

class _AudioTextState extends State<AudioTextWidget> {
  bool _play = false;
  String apiToken;

  @override
  Widget build(BuildContext context) {
    final text = Uri.encodeComponent(widget.text.trim());

    return AudioWidget(
      key: ValueKey(widget.text),
      audio: Audio.network(
        "http://${AppApi.apiUri}/speech/${text}",
        headers: {
          'Authorization': 'Bearer $apiToken',
        },
      ),
      play: _play,
      child: MaterialButton(
        minWidth: 0,
        height: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            _play = !_play;
          });
        },
        child: Icon(
          _play ? Icons.pause : Icons.volume_up,
          size: 32,
          color: VockifyColors.lightSteelBlue,
        ),
        shape: CircleBorder(),
      ),
      onFinished: () {
        setState(() {
          _play = false;
        });
      },
    );
  }

  void initState() {
    super.initState();
    final store = StoreProvider.of<AppState>(context, listen: false);
    apiToken = authToken(store.state);
  }
}
