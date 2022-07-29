import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tusmap_flutter/resources/location.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String? url;
  Set<JavascriptChannel>? channel;
  WebViewController? controller;

  String? socketId;

  IO.Socket socket = IO.io('http://192.168.0.145:3000/', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  void emit(String room, dynamic data) {
    socket.emit(room, {
      'id': socketId,
      ...data
    });
  }

  @override
  void initState() {
    super.initState();
    socket.on('setPosition', (data) => print(data));
    socket.connect();
    socket.onConnect((data) {
      setState(() {
        url = 'http://192.168.0.145:3000/?id=${socket.id}';
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

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        url != null ? WebView(
          initialUrl: url,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptChannels: channel,
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
                  child: Text('불러오는 중..'),
                ),
              )
            ],
          )
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {setPosition();},
                child: Icon(Icons.location_searching),
              ),
            ),
          )
        )
      ]
    );
  }
}