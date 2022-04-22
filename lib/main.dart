// // import 'dart:typed_data';
// //
// // import 'package:flutter/material.dart';
// // import 'package:nfc_manager/nfc_manager.dart';
// //
// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => MyAppState();
// // }
// //
// // class MyAppState extends State<MyApp> {
// //   ValueNotifier<dynamic> result = ValueNotifier(null);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(title: Text('NfcManager Plugin Example')),
// //         body: SafeArea(
// //           child: FutureBuilder<bool>(
// //             future: NfcManager.instance.isAvailable(),
// //             builder: (context, ss) => ss.data != true
// //                 ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
// //                 : Flex(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               direction: Axis.vertical,
// //               children: [
// //                 Flexible(
// //                   flex: 2,
// //                   child: Container(
// //                     margin: EdgeInsets.all(4),
// //                     constraints: BoxConstraints.expand(),
// //                     decoration: BoxDecoration(border: Border.all()),
// //                     child: SingleChildScrollView(
// //                       child: ValueListenableBuilder<dynamic>(
// //                         valueListenable: result,
// //                         builder: (context, value, _) =>
// //                             Text('${value ?? ''}'),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Flexible(
// //                   flex: 3,
// //                   child: GridView.count(
// //                     padding: EdgeInsets.all(4),
// //                     crossAxisCount: 2,
// //                     childAspectRatio: 4,
// //                     crossAxisSpacing: 4,
// //                     mainAxisSpacing: 4,
// //                     children: [
// //                       ElevatedButton(
// //                           child: Text('Tag Read'), onPressed: _tagRead),
// //                       ElevatedButton(
// //                           child: Text('Ndef Write'),
// //                           onPressed: _ndefWrite),
// //                       ElevatedButton(
// //                           child: Text('Ndef Write Lock'),
// //                           onPressed: _ndefWriteLock),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _tagRead() {
// //     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
// //       result.value = tag.data;
// //       NfcManager.instance.stopSession();
// //     });
// //   }
// //
// //   void _ndefWrite() {
// //     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
// //       var ndef = Ndef.from(tag);
// //       if (ndef == null || !ndef.isWritable) {
// //         result.value = 'Tag is not ndef writable';
// //         NfcManager.instance.stopSession(errorMessage: result.value);
// //         return;
// //       }
// //
// //       NdefMessage message = NdefMessage([
// //         NdefRecord.createText('Hello World!'),
// //         NdefRecord.createUri(Uri.parse('https://flutter.dev')),
// //         NdefRecord.createMime(
// //             'text/plain', Uint8List.fromList('Hello'.codeUnits)),
// //         NdefRecord.createExternal(
// //             'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
// //       ]);
// //
// //       try {
// //         await ndef.write(message);
// //         result.value = 'Success to "Ndef Write"';
// //         NfcManager.instance.stopSession();
// //       } catch (e) {
// //         result.value = e;
// //         NfcManager.instance.stopSession(errorMessage: result.value.toString());
// //         return;
// //       }
// //     });
// //   }
// //
// //   void _ndefWriteLock() {
// //     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
// //       var ndef = Ndef.from(tag);
// //       if (ndef == null) {
// //         result.value = 'Tag is not ndef';
// //         NfcManager.instance.stopSession(errorMessage: result.value.toString());
// //         return;
// //       }
// //
// //       try {
// //         await ndef.writeLock();
// //         result.value = 'Success to "Ndef Write Lock"';
// //         NfcManager.instance.stopSession();
// //       } catch (e) {
// //         result.value = e;
// //         NfcManager.instance.stopSession(errorMessage: result.value.toString());
// //         return;
// //       }
// //     });
// //   }
// // }
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nfc_demo/home_screen.dart';
// import 'package:nfc_demo/raw_record_setting.dart';
// import 'package:nfc_demo/text_record_setting.dart';
// import 'package:nfc_demo/uri_record_setting.dart';
// import 'package:nfc_demo/write_screen.dart';
//
// import 'read_screen.dart';
//
// void main() {
//   runApp( MyApp());
// }
//  class MyApp extends StatelessWidget {
//    const MyApp({Key? key}) : super(key: key);
//
//    @override
//    Widget build(BuildContext context) {
//      return MaterialApp(
//        home: ProviderScope(child: HomeScreen()),
//      );
//    }
//  }
//
// //}
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return  MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("NFC in Flutter examples"),
// //         ),
// //         body: Builder(builder: (context) {
// //           return ListView(
// //             children: <Widget>[
// //               ListTile(
// //                 title: const Text("Read NFC"),
// //                 onTap: () {
// //                   Navigator.pushNamed(context, "/read_example");
// //                 },
// //               ),
// //               ListTile(
// //                 title: const Text("Write NFC"),
// //                 onTap: () {
// //                   Navigator.pushNamed(context, "/write_example");
// //                 },
// //               ),
// //             ],
// //           );
// //         }),
// //       ),
// //       routes: {
// //         "/read_example": (context) => ReadExampleScreen(),
// //         "/write_example": (context) => WriteExampleScreen(),
// //       },
// //     );
// //   }
// // }
//

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';


void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyApp()
      // Scaffold(
      //   appBar: AppBar(
      //     title: const Text("NFC in Flutter examples"),
      //   ),
      //   body: Builder(builder: (context) {
      //     return ListView(
      //       children: <Widget>[
      //         ListTile(
      //           title: const Text("Read NFC"),
      //           onTap: () {
      //             Navigator.pushNamed(context, "/read_example");
      //           },
      //         ),
      //         ListTile(
      //           title: const Text("Write NFC"),
      //           onTap: () {
      //             Navigator.pushNamed(context, "/write_example");
      //           },
      //         ),
      //       ],
      //     );
      //   }),
      // ),
      // routes: {
      //   "/read_example": (context) => ReadExampleScreen(),
      //   "/write_example": (context) => WriteExampleScreen(),
      // },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // _stream is a subscription to the stream returned by `NFC.read()`.
  // The subscription is stored in state so the stream can be canceled later
  StreamSubscription<NDEFMessage>? _stream;

  // _tags is a list of scanned tags
  List<NDEFMessage> _tags = [];

  bool _supportsNFC = false;

  // _readNFC() calls `NFC.readNDEF()` and stores the subscription and scanned
  // tags in state
  void _readNFC(BuildContext context) {
    try {
      // ignore: cancel_subscriptions
      StreamSubscription<NDEFMessage> subscription = NFC.readNDEF().listen(
              (tag) {
            // On new tag, add it to state
            setState(() {
              _tags.insert(0, tag);
            });
          },
          // When the stream is done, remove the subscription from state
          onDone: () {
            setState(() {
              _stream = null;
            });
          },
          // Errors are unlikely to happen on Android unless the NFC tags are
          // poorly formatted or removed too soon, however on iOS at least one
          // error is likely to happen. NFCUserCanceledSessionException will
          // always happen unless you call readNDEF() with the `throwOnUserCancel`
          // argument set to false.
          // NFCSessionTimeoutException will be thrown if the session timer exceeds
          // 60 seconds (iOS only).
          // And then there are of course errors for unexpected stuff. Good fun!
          onError: (e) {
            setState(() {
              _stream = null;
            });

            if (!(e is NFCUserCanceledSessionException)) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Error!"),
                  content: Text(e.toString()),
                ),
              );
            }
          });

      setState(() {
        _stream = subscription;
      });
    } catch (err) {
      print("error: $err");
    }
  }

  // _stopReading() cancels the current reading stream
  void _stopReading() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  @override
  void initState() {
    super.initState();
    NFC.isNDEFSupported.then((supported) {
      setState(() {
        _supportsNFC = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('NFC in Flutter'),
          actions: <Widget>[
            Builder(
              builder: (context) {
                if (!_supportsNFC) {
                  return TextButton(
                    child: Text("NFC unsupported"),
                    onPressed: null,
                  );
                }
                return TextButton(
                  child:
                  Text(_stream == null ? "Start reading" : "Stop reading"),
                  onPressed: () {
                    if (_stream == null) {
                      _readNFC(context);
                    } else {
                      _stopReading();
                    }
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                setState(() {
                  _tags.clear();
                });
              },
              tooltip: "Clear",
            ),
          ],
        ),
        // Render list of scanned tags
        body: ListView.builder(
          itemCount: _tags.length,
          itemBuilder: (context, index) {
            const TextStyle payloadTextStyle = const TextStyle(
              fontSize: 15,
              color: const Color(0xFF454545),
            );

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("NDEF Tag",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Builder(
                    builder: (context) {
                      // Build list of records
                      List<Widget> records = [];
                      for (int i = 0; i < _tags[index].records.length; i++) {
                        records.add(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Record ${i + 1} - ${_tags[index].records[i].type}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            Text(
                              _tags[index].records[i].payload,
                              style: payloadTextStyle,
                            ),
                            Text(
                              _tags[index].records[i].data,
                              style: payloadTextStyle,
                            ),
                          ],
                        ));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: records,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



class ReadExampleScreen extends StatefulWidget {
  @override
  _ReadExampleScreenState createState() => _ReadExampleScreenState();
}

class _ReadExampleScreenState extends State<ReadExampleScreen> {
  StreamSubscription<NDEFMessage>? _stream;

  void _startScanning() {
    setState(() {
      _stream = NFC
          .readNDEF(alertMessage: "Custom message with readNDEF#alertMessage")
          .listen((NDEFMessage message) {
        if (message.isEmpty) {
          print("Read empty NDEF message");
          return;
        }
        print("Read NDEF message with ${message.records.length} records");
        for (NDEFRecord record in message.records) {
          print(
              "Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
        }
      }, onError: (error) {
        setState(() {
          _stream = null;
        });
        if (error is NFCUserCanceledSessionException) {
          print("user canceled");
        } else if (error is NFCSessionTimeoutException) {
          print("session timed out");
        } else {
          print("error: $error");
        }
      }, onDone: () {
        setState(() {
          _stream = null;
        });
      });
    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    if (_stream == null) {
      _startScanning();
    } else {
      _stopScanning();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read NFC example"),
      ),
      body: Center(
          child: ElevatedButton(
            child: const Text("Toggle scan"),
            onPressed: _toggleScan,
          )),
    );
  }
}


class RecordEditor {
  final TextEditingController mediaTypeController = TextEditingController();
  final TextEditingController payloadController = TextEditingController();
}

class WriteExampleScreen extends StatefulWidget {
  @override
  _WriteExampleScreenState createState() => _WriteExampleScreenState();
}

class _WriteExampleScreenState extends State<WriteExampleScreen> {
  StreamSubscription<NDEFMessage>? _stream;
  List<RecordEditor> _records = [];
  bool _hasClosedWriteDialog = false;

  void _addRecord() {
    setState(() {
      _records.add(RecordEditor());
    });
  }

  void _write(BuildContext context) async {
    List<NDEFRecord> records = _records.map((record) {
      return NDEFRecord.type(
        record.mediaTypeController.text,
        record.payloadController.text,
      );
    }).toList();
    NDEFMessage message = NDEFMessage.withRecords(records);

    // Show dialog on Android (iOS has it's own one)
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Scan the tag you want to write to"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _hasClosedWriteDialog = true;
                _stream?.cancel();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    // Write to the first tag scanned
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write NFC example"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Center(
            child: OutlinedButton(
              child: const Text("Add record"),
              onPressed: _addRecord,
            ),
          ),
          for (var record in _records)
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Record", style: Theme.of(context).textTheme.bodyText1),
                  TextFormField(
                    controller: record.mediaTypeController,
                    decoration: InputDecoration(
                      hintText: "Media type",
                    ),
                  ),
                  TextFormField(
                    controller: record.payloadController,
                    decoration: InputDecoration(
                      hintText: "Payload",
                    ),
                  )
                ],
              ),
            ),
          Center(
            child: ElevatedButton(
              child: const Text("Write to tag"),
              onPressed: _records.length > 0 ? () => _write(context) : null,
            ),
          ),
        ],
      ),
    );
  }
}