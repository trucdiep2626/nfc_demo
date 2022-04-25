import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfc_demo/home_state.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:state_notifier/state_notifier.dart';

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});

class HomeStateNotifier extends StateNotifier<HomeState> with LocatorMixin {
  HomeStateNotifier() : super(HomeState()) {
    init();
  }

  void init(){
    NFC.isNDEFSupported.then((supported) {
      state = state.copyWith(supportsNFC: supported);
      startScanning();
    });
  }

  void clearOldResult(){
    state = state.copyWith(errorText: "");
  }

  void addNewRecord(String newRecord) {
    List<String> newList = [];
    newList.addAll(state.records);
    newList.add(newRecord);
    log(newList.toString());
    state = state.copyWith(records: newList);
  }

  void deleteRecord(int index) {
    List<String> newList = [];
    newList.addAll(state.records);
    newList.removeAt(index);
    state = state.copyWith(records: newList);
  }

  void write() async {
    List<NDEFRecord> records = state.records.map((record) {
      return NDEFRecord.text(record);
    }).toList();
    NDEFMessage message = NDEFMessage.withRecords(records);

    try {
      // Write to the first tag scanned
      await NFC.writeNDEF(message).first;
      state = state.copyWith(errorText: 'done');
    } catch (e) {
      state = state.copyWith(errorText: e.toString());
    }
  }

  void startScanning() {
    List<String> readResults = [];
    final newStream = NFC.readNDEF().listen((NDEFMessage message) {
      state = state.copyWith(readResults: []);
      readResults.clear();
      if (message.isEmpty) {
        readResults.add("Read empty NDEF message");
        state = state.copyWith(readResults: readResults);
        return;
      }
      log("Read NDEF message with ${message.records.length} records");
      for (NDEFRecord record in message.records) {
        readResults.add(
            "Record: data '${record.data}' and language code '${record.languageCode}'");
        log("Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
      }
      state = state.copyWith(readResults: readResults);
    }, onError: (error) {
      state = state.copyWith(stream: null);

      if (error is NFCUserCanceledSessionException) {
        log("user canceled");
      } else if (error is NFCSessionTimeoutException) {
        log("session timed out");
      } else {
        log("error: $error");
      }
    }, onDone: () {
      state = state.copyWith(stream: null);
    });
    state = state.copyWith(stream: newStream);
  }

  void stopScanning() {
    log('gggggggggggg');
    state.stream?.cancel();
    state = state.copyWith(stream: null);
  }

  void toggleScan() {
    if (state.stream == null) {
      startScanning();
    } else {
      stopScanning();
    }
  }
}
