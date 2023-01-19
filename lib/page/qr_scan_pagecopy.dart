import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qr_code_scanner/widget/button_widget.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'edit.dart';

class QRScanPageCop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageCopState();
}

class _QRScanPageCopState extends State<QRScanPageCop> {
  var list = [for (var i = 0; i < 250; i += 1) i];
  var qrCode = '4';
  List _get = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          //you have to take the ip address of your computer.
          //because using localhost will cause an error
          "https://api-sitilap.itrsudcibinong.com/list.php"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // entry data to variabel list _get
        setState(() {
          _get = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(MyApp.title),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: _get == null ? 0 : _get.length,
              itemBuilder: (BuildContext context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (list.asMap().containsKey(int.parse(qrCode))) ...[
                      if (qrCode == _get[index]['nomer_komp']) ...[
                        Column(
                          children: [
                            Text(
                              'Kode ASET $qrCode',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DataTable(
                              columns: [
                                DataColumn(
                                    label: Text('Keterangan',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Detail',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('NAMA RUANGAN')),
                                  DataCell(
                                      Text('${_get[index]['nama_ruangan']}')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('JENIS KOMPUTER')),
                                  DataCell(
                                      Text('${_get[index]['jenis_komp']}')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Merek')),
                                  DataCell(Text('${_get[index]['merk_komp']}')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Nomer Seri')),
                                  DataCell(
                                      Text('${_get[index]['nomer_seri']}')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Model')),
                                  DataCell(Text('${_get[index]['model']}')),
                                ]),
                              ],
                            ),
                            ButtonWidget(
                              text: 'Start QR scan',
                              onClicked: () => scanQRCode(),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ],
                );
              }),
        ),
      );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
