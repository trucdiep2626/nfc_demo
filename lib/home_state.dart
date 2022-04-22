import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nfc_demo/main.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';


part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState{
//  @JsonSerializable(explicitToJson: true)
   factory HomeState({
     @Default([]) List<String> records,
     NDEFMessage? tag,
     @Default(false) bool supportsNFC,
     StreamSubscription<NDEFMessage>? stream







     // @Default('') String platformVersion,
    // @Default(NFCAvailability.not_supported) NFCAvailability availability ,
    // NFCTag? tag,
    // String? result, writeResult,
    // @Default(false) bool addingRecord,
    // List<NDEFRecord>? records,
    //  @Default('') String errorText
  }) = _HomeState;

}


