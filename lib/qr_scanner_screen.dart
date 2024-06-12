import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = false;
  String? qrText;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;
        _showQRDialog(scanData.code!);
        isScanning = false;
      });
    });
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  void _showQRDialog(String code) {
    bool isLink = Uri.tryParse(code)?.hasAbsolutePath ?? false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned'),
          content: Text('Scanned code: $code'),
          actions: <Widget>[
            if (isLink)
              ShadButton(
                text: const Text('Open'),
                onPressed: () => _openUrl(code),
              ),
            ShadButton(
              text: const Text('Copy'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
                Navigator.of(context).pop();
              },
            ),
            ShadButton(
              text: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: isScanning ? _buildQrView(context) : _buildInitialUI(context),
    );
  }

  Widget _buildInitialUI(BuildContext context) {
    return Center(
      child: ShadButton(
        text: const Text('Start Scanning'),
        onPressed: () {
          setState(() {
            isScanning = true;
          });
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }
}
