import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:video_player/constants.dart';

class BetterVideo extends StatefulWidget {
  final String placeHolder;
  const BetterVideo({Key? key, required this.placeHolder}) : super(key: key);

  @override
  State<BetterVideo> createState() => _BetterVideoState();
}

class _BetterVideoState extends State<BetterVideo> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerControlsConfiguration controlsConfiguration =
        BetterPlayerControlsConfiguration(
      controlBarColor: Color.fromARGB(170, 0, 0, 0),
      controlsHideTime: Duration(milliseconds: 200),
      progressBarPlayedColor: primaryColor,
      overflowModalColor: backgroundColor,
      overflowMenuIconsColor: Colors.white.withOpacity(.7),
      overflowModalTextColor: Colors.white.withOpacity(.7),
    );

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8");
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          placeholder: Image.network(
            widget.placeHolder,
            fit: BoxFit.contain,
          ),
          controlsConfiguration: controlsConfiguration,
          showPlaceholderUntilPlay: true,
          allowedScreenSleep: false,
        ),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
