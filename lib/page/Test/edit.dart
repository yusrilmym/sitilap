// ignore_for_file: unused_field, prefer_const_constructors, avoid_print, use_key_in_widget_constructors, must_be_immutable, unused_element, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  Edit({@required this.id});

  String id;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();

  //inisialize field
  var nomer_apar = TextEditingController();
  var nama_ruangan = TextEditingController();
  var jenis_apar = TextEditingController();
  var satuan = TextEditingController();
  var pengisian_awal = TextEditingController();
  var pengisian_akhir = TextEditingController();

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getData();
  }

  //Http to get detail data
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          //you have to take the ip address of your computer.
          //because using localhost will cause an error
          //get detail data with id
          "https://api-silapar.itrsudcibinong.com/detail.php?id='${widget.id}'"));

      // if response successful
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          nomer_apar = TextEditingController(text: data['nomer_apar']);
          nama_ruangan = TextEditingController(text: data['nama_ruangan']);
          jenis_apar = TextEditingController(text: data['jenis_apar']);
          satuan = TextEditingController(text: data['satuan']);
          pengisian_awal = TextEditingController(text: data['pengisian_awal']);
          pengisian_akhir =
              TextEditingController(text: data['pengisian_akhir']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse("https://api-silapar.itrsudcibinong.com/update.php"),
        body: {
          "id": widget.id,
          "nomer_apar": nomer_apar.text,
          "nama_ruangan": nama_ruangan.text,
          "jenis_apar": jenis_apar.text,
          "satuan": satuan.text,
          "pengisian_awal": pengisian_awal.text,
          "pengisian_akhir": pengisian_akhir.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/coba', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  Future _onDelete(context) async {
    try {
      return await http.post(
        Uri.parse("https://api-silapar.itrsudcibinong.com/delete.php"),
        body: {
          "id": widget.id,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        // Remove all existing routes until the home.dart, then rebuild Home.
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/coba', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input APAR"),
        backgroundColor: Colors.green,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //show dialog to confirm delete data
                      return AlertDialog(
                        content: Text('Are you sure you want to delete this?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Icon(Icons.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: Icon(Icons.check_circle),
                            onPressed: () => _onDelete(context),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'nomer_apar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nomer_apar,
                  decoration: InputDecoration(
                      hintText: "Nomer Apar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Note nomer_apar is Required!';
                    }
                    return null;
                  },
                ),
                Text(
                  'nama_ruangan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nama_ruangan,
                  decoration: InputDecoration(
                      hintText: "Nama Ruangan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Note Nama Ruangan is Required!';
                    }
                    return null;
                  },
                ),
                Text(
                  'jenis_apar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: jenis_apar,
                  decoration: InputDecoration(
                      hintText: "Jenis Apar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'satuan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: satuan,
                  decoration: InputDecoration(
                      hintText: "Satuan(KG)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'pengisian_awal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pengisian_awal,
                  decoration: InputDecoration(
                      hintText: "Tanggal Pengisian Awal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'pengisian_akhir',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pengisian_akhir,
                  decoration: InputDecoration(
                      hintText: "Tanggal Pengisian Akhir",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //validate
                    if (_formKey.currentState.validate()) {
                      //send data to database with this method
                      _onUpdate(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
