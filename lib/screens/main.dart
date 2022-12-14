import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tusmap_flutter/resources/location.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String? url;
  WebViewController? controller;
  String backUrl = 'https://port-0-tusmap-backend-3q0b1b25l9gzhka1.gksl2.cloudtype.app';

  String? socketId;

  late IO.Socket socket;

  void emit(String room, dynamic data) {
    socket.emit(room, {
      'id': socketId,
      ...data
    });
  }

  @override
  void initState() {
    super.initState();

    socket = IO.io(backUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    if (socket.connected) {
      setState(() {
        url = 'https://web-tusmap-frontend-3q0b1b25l9h1lqpy.gksl2.cloudtype.app?id=${socket.id}';
        // url = 'http://192.168.0.199:5173?id=${socket.id}';
        socketId = '${socket.id}tusMap';
      });
    }

    socket.on('setPosition', (data) => print(data));
    socket.connect();
    socket.onConnect((data) {
      setState(() {
        url = 'https://web-tusmap-frontend-3q0b1b25l9h1lqpy.gksl2.cloudtype.app?id=${socket.id}';
        // url = 'http://192.168.0.199:5173?id=${socket.id}';
        socketId = '${socket.id}tusMap';
      });
      print(socket.id);
      socket.emit('join', socket.id);
    });
  }

  void setPosition() async {
    Position position = await getCurrentLocation();
    emit('currentLocation', {
      'latitude': position.latitude,
      'longitude': position.longitude
    });
  }

  void _showAlert({required String title, required String message}) {
    showCupertinoDialog(
      context: context, builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('??????'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]
        );
      }
    );
  }

  JavascriptChannel _webAlertToApp(BuildContext context) {
    return JavascriptChannel(
      name: 'appAlert',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
        _showAlert(
          title: message.message.split('/')[0],
          message: message.message.split('/')[1]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        url != null ? WebView(
          initialUrl: url,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptChannels: <JavascriptChannel>{
            _webAlertToApp(context),
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (data) {
            setPosition();
          },
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(
                radius: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text('???????????? ???..'),
                ),
              )
            ],
          )
        ),
        url != null ? Align(
          alignment: Alignment.bottomRight,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 100),
              child: CupertinoButton(
                onPressed: () {setPosition();},
                padding: EdgeInsets.all(10),
                color: Color(0xffaaaaaa),
                child: Icon(CupertinoIcons.location_fill),
              )
            ),
          )
        ) : SizedBox()
      ]
    );
  }
}