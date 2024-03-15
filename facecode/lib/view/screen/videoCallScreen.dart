import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';


class videoCall extends StatefulWidget {
  const videoCall({Key? key}) : super(key: key);

  @override
  State<videoCall> createState() => _videoCallState();
}

class _videoCallState extends State<videoCall> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "77a65485b68744fb8aed6d7b75d29dd4",
      channelName: "test",
      tempToken: '007eJxTYDhU8HAHA9MbzuY98eF//uV/+HpoP7/yIssXx28E5Gfd3dyjwGBunmhmamJhmmRmYW5ikpZkkZiaYpZinmRummJkmZJi0v3nc2pDICPD1SU2jIwMEAjiszCUpBaXMDAAAEnxI38=',
      username: "user",
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                enableHostControls: true, 
              ),
              AgoraVideoButtons(
                onDisconnect: () {
                  Navigator.of(context).pop();
                },
                client: client,
                addScreenSharing: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}