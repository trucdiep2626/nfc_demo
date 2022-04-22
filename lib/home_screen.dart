import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndef/ndef.dart';
import 'package:nfc_demo/home_state.dart';
import 'package:nfc_demo/home_state_notifier.dart';
import 'package:nfc_demo/raw_record_setting.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextRecord record = TextRecord(language: 'en', text: '');
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late TextEditingController _textController;
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
//    initPlatformState();

    _tabController = TabController(length: 2, vsync: this);
    _textController = TextEditingController.fromValue(
        TextEditingValue(text: widget.record.text!));
    //  _records = [];
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final homeStateNotifier = ref.read(homeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
          title: const Text('NFC Flutter Kit Example App'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'read'),
              Tab(text: 'write'),
            ],
            controller: _tabController,
          )),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Scrollbar(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    'Running on: ${state.platformVersion}\nNFC: ${state.availability}'),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => homeStateNotifier.onPressedStartReading(),
                  child: const Text('Start polling'),
                ),
                SizedBox(height: 12),
                state.tag != null
                    ? Text(
                //  '${state.tag!.toString()}'
                      'ID: ${state.tag!.id}\nStandard: ${state.tag!.standard}\nType: ${state.tag!.type}\nATQA: ${state.tag!.atqa}\nSAK: ${state.tag!.sak}\nHistorical Bytes: ${state.tag!.historicalBytes}\nProtocol Info: ${state.tag!.protocolInfo}\nApplication Data: ${state.tag!.applicationData}\nHigher Layer Response: ${state.tag!.hiLayerResponse}\nManufacturer: ${state.tag!.manufacturer}\nSystem Code: ${state.tag!.systemCode}\nDSF ID: ${state.tag!.dsfId}\nNDEF Available: ${state.tag!.ndefAvailable}\nNDEF Type: ${state.tag!.ndefType}\nNDEF Writable: ${state.tag!.ndefWritable}\nNDEF Can Make Read Only: ${state.tag!.ndefCanMakeReadOnly}\nNDEF Capacity: ${state.tag!.ndefCapacity}\n\n Transceive Result:\n${state.result}'
                )
                    : Text('No tag polled yet.'),
                SizedBox(height: 12),
              ]),
        ))),
        Padding(
            padding: EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () =>
                            homeStateNotifier.onPressedStartWriting(),
                        child: Text("Start writing"),
                      ),
                      ElevatedButton(
                        onPressed: () => showDialogAddRecord(state),
                        child: Text("Add record"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Result: ${state.writeResult}'),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.records!.length,
                        itemBuilder: (context, index) => Dismissible(
                              key: Key(
                                  state.records?[index].payload?.toString() ??
                                      ''),
                              onDismissed: (direction) =>
                                  homeStateNotifier.deleteRecord(index),
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${state.records?[index].toString() ?? ''}'),
                                ),
                              ),
                            )),
                  ),
                ]))
      ]),
    );
  }

  void showDialogAddRecord(HomeState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(16),
            title: Text('Add Text Record'),
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'text'),
                controller: _textController,
              ),
              Visibility(
                  visible: state.errorText.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 5),
                    child: Text(
                      state.errorText,
                    ),
                  )),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    log('${_textController.text}');
                    ref.read(homeProvider.notifier).addNewRecord(TextRecord(
                        encoding: TextEncoding.values.first,
                        language: 'en',
                        text: (_textController.text == null
                            ? ""
                            : _textController.text)));
                    Navigator.pop(context);
                    _textController.clear();
                  }
                },
              )
            ],
          );
        });
  }
}
