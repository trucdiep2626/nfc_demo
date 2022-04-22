import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfc_demo/home_state.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:state_notifier/state_notifier.dart';

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});

class HomeStateNotifier extends StateNotifier<HomeState> with LocatorMixin {
  HomeStateNotifier()
      : super( HomeState(
  )) {
  // initPlatformState();
  }

  //     Future<void> initPlatformState() async {
  //   NFCAvailability availability;
  //
  //   try {
  //     availability = await FlutterNfcKit.nfcAvailability;
  //     log('vvvvvvvvvvvvvv');
  //   } on PlatformException {
  //     availability = NFCAvailability.not_supported;
  //   }
  //
  //   if (!mounted) return;
  //
  //   state = state.copyWith(availability: availability);
  // }
  //
  // Future<void> onPressedStartReading ()async{
  //
  //   try {
  //     NFCTag tag = await FlutterNfcKit.poll(readIso18092: true);
  //     state = state.copyWith(tag: tag);
  //     await FlutterNfcKit.setIosAlertMessage(
  //         "working on it...");
  //     log(tag.toJson().toString());
  //     log(tag.standard);
  //     if(tag.standard == "ISO 14443-3 (Type A)")
  //       {
  //         log(tag.type.toString());
  //         log('vvvvvddddddddddddddddddv');
  //         String result1 =
  //         await FlutterNfcKit.transceive("00A0950000");
  //         String result2 = await FlutterNfcKit.transceive(
  //             "00A4040009A00000000386980701");
  //         state = state.copyWith(result: '1: $result1\n2: $result2\n');
  //       }
  //     if (tag.standard == "ISO 14443-4 (Type B)") {
  //       String result1 =
  //       await FlutterNfcKit.transceive("00B0950000");
  //       String result2 = await FlutterNfcKit.transceive(
  //           "00A4040009A00000000386980701");
  //       state = state.copyWith(result: '1: $result1\n2: $result2\n');
  //     } else if (tag.type == NFCTagType.iso18092) {
  //       String result1 =
  //       await FlutterNfcKit.transceive("060080080100");
  //       state = state.copyWith(result: '1: $result1\n');
  //     } else if (tag.type == NFCTagType.mifare_ultralight ||
  //         tag.type == NFCTagType.mifare_classic) {
  //
  //       var ndefRecords = await FlutterNfcKit.readNDEFRecords();
  //       var ndefString = ndefRecords
  //           .map((r) => r.toString())
  //           .reduce((value, element) => value + "\n" + element);
  //       state = state.copyWith(result: '$ndefString\n');
  //     }
  //   } catch (e) {
  //     state = state.copyWith(result: 'error: $e');
  //   }
  //
  //   // Pretend that we are working
  //   sleep(new Duration(seconds: 1));
  //   await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
  // }
  //
  // Future<void> onPressedStartWriting() async{
  //   if (state.records!.length != 0) {
  //     try {
  //       NFCTag tag = await FlutterNfcKit.poll();
  //       state = state.copyWith(tag: tag);
  //       if (tag.type == NFCTagType.mifare_ultralight ||
  //           tag.type == NFCTagType.mifare_classic) {
  //         await FlutterNfcKit.writeNDEFRecords(state.records!);
  //         state = state.copyWith(writeResult: 'OK');
  //       } else {
  //         state = state.copyWith(writeResult: 'error: NDEF not supported: ${tag.type}');
  //       }
  //     } catch (e, stacktrace) {
  //       state = state.copyWith(writeResult: 'error: $e');
  //       print(stacktrace);
  //     } finally {
  //       await FlutterNfcKit.finish();
  //     }
  //   } else {
  //     state = state.copyWith(writeResult: 'error: No record');
  //   }
  // }
  //
  // void startAddRecord(){
  //   state = state.copyWith(addingRecord: true);
  // }
  //
  // void endAddRecord(){
  //   state = state.copyWith(addingRecord: false);
  // }
  //
  // void addNewRecord(NDEFRecord newRecord){
  //   List<NDEFRecord> newList =[];
  //   newList.addAll(state.records!);
  //   newList.add(newRecord);
  //   log(newList.toString());
  //   state = state.copyWith(records: newList);
  // }
  //
  // void deleteRecord(int index){
  //   List<NDEFRecord> newList =[];
  //   newList.addAll(state.records!);
  //   newList.removeAt(index);
  //   state = state.copyWith(records: newList);
  // }

  void _startScanning() {

      final newStream = NFC
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

        state= state.copyWith(stream: null);

        if (error is NFCUserCanceledSessionException) {
          print("user canceled");
        } else if (error is NFCSessionTimeoutException) {
          print("session timed out");
        } else {
          print("error: $error");
        }
      }, onDone: () {

        state= state.copyWith(stream: null);

      });

      state= state.copyWith(stream: newStream);

  }

  void _stopScanning() {
    state.stream?.cancel();
state= state.copyWith(stream: null);


  }

  void _toggleScan() {
    if (state.stream == null) {
      _startScanning();
    } else {
      _stopScanning();
    }
  }
}