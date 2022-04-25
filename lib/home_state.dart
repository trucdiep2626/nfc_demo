import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState{
//  @JsonSerializable(explicitToJson: true)
   factory HomeState({
     @Default([]) List<String> readResults,
     @Default([]) List<String> records,
     NDEFMessage? tag,
     @Default(false) bool supportsNFC,
     StreamSubscription<NDEFMessage>? stream,
     @Default('') String errorText
  }) = _HomeState;

}


