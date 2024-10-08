import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "77a65485b68744fb8aed6d7b75d29dd4";
//const token = "007eJxTYFi84v7d1A97F1ckvKr99mCBUnRGOnMTk9dv7+svdJ9+KQpQYDA3TzQzNbEwTTKzMDcxSUuySExNMUsxTzI3TTGyTEkxeb6qNq0hkJFB6WkOAyMUgvgsDCWpxSUMDABOZCLN";
//const channel = "test";

class voiceCallScreen extends StatefulWidget {
  final token, channel;
  const voiceCallScreen({required this.channel, required this.token, Key? key})
      : super(key: key);

  @override
  State<voiceCallScreen> createState() => _voiceCallScreenState();
}

class _voiceCallScreenState extends State<voiceCallScreen> {
  List<int> _remoteUids = [];
  bool _isMuted = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // Retrieve permissions
    await [Permission.microphone].request();

    // Create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {});
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUids.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUids.remove(remoteUid);
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableAudio();

    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _engine.muteLocalAudioStream(_isMuted);
  }

  void _leaveChannel() {
    _dispose();
    setState(() {
      _remoteUids.clear();
    });
  }

  // Create UI with local user status, remote user list, and control buttons
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${_remoteUids.length} User has been joined'),
            Image.asset('images/groupAvatar.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleMute,
                  child: Text(_isMuted ? 'Unmute' : 'Mute'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _leaveChannel,
                  child: const Text('Leave'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
