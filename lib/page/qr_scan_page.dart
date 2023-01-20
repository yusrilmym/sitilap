import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qr_code_scanner/widget/button_widget.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'edit.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  var list = [for (var i = 0; i < 1000; i += 1) i];
  var qrCode = '4';
  // var c = int.tryParse('qrCode');
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
          child: _get.length != 0
              ? MasonryGridView.count(
                  crossAxisCount: 1,
                  itemCount: _get.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Edit(
                                      id: _get[index]['id'],
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (list
                                .asMap()
                                .containsKey(int.parse(qrCode))) ...[
                              if (qrCode == _get[index]['nomer_komp']) ...[
                                Column(
                                  children: [
                                    Text(
                                      'Kode pengadaan $qrCode',
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
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        DataColumn(
                                            label: Text('Detail',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text('NAMA RUANGAN')),
                                          DataCell(Text(
                                              '${_get[index]['nama_ruangan']}')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('JENIS KOMPUTER')),
                                          DataCell(Text(
                                              '${_get[index]['jenis_komp']}')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('merk_komp')),
                                          DataCell(Text(
                                              '${_get[index]['merk_komp']}')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                              Text('PENGprocessorAN AWAL')),
                                          DataCell(Text(
                                              '${_get[index]['nomer_seri']}')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                              Text('PENGprocessorAN AKHIR')),
                                          DataCell(
                                              Text('${_get[index]['model']}')),
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
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "No Data Available",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
