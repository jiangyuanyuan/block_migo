import 'package:flutter/material.dart';
import 'package:migo/common/util/event_bus.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodePage extends StatefulWidget {
  final Function(String sender) onFinish;

  const QrCodePage({Key key, this.onFinish}) : super(key: key); 
  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  // QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Expanded(
          //   child: QRView(
          //     key: qrKey,
          //     onQRViewCreated: _onQRViewCreated,
          //     overlay: QrScannerOverlayShape(
          //       borderColor: Colors.red,
          //       borderRadius: 10,
          //       borderLength: 30,
          //       borderWidth: 10,
          //       cutOutSize: 300,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     this.controller.pauseCamera();
  //     EventBus.instance.commit(EventKeys.RefreshQrCode, scanData);
  //     Navigator.pop(context);
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}