// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HomeStateTearOff {
  const _$HomeStateTearOff();

  _HomeState call(
      {List<String> readResults = const [],
      List<String> records = const [],
      NDEFMessage? tag,
      bool supportsNFC = false,
      StreamSubscription<NDEFMessage>? stream,
      String errorText = ''}) {
    return _HomeState(
      readResults: readResults,
      records: records,
      tag: tag,
      supportsNFC: supportsNFC,
      stream: stream,
      errorText: errorText,
    );
  }
}

/// @nodoc
const $HomeState = _$HomeStateTearOff();

/// @nodoc
mixin _$HomeState {
  List<String> get readResults => throw _privateConstructorUsedError;
  List<String> get records => throw _privateConstructorUsedError;
  NDEFMessage? get tag => throw _privateConstructorUsedError;
  bool get supportsNFC => throw _privateConstructorUsedError;
  StreamSubscription<NDEFMessage>? get stream =>
      throw _privateConstructorUsedError;
  String get errorText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call(
      {List<String> readResults,
      List<String> records,
      NDEFMessage? tag,
      bool supportsNFC,
      StreamSubscription<NDEFMessage>? stream,
      String errorText});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object? readResults = freezed,
    Object? records = freezed,
    Object? tag = freezed,
    Object? supportsNFC = freezed,
    Object? stream = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_value.copyWith(
      readResults: readResults == freezed
          ? _value.readResults
          : readResults // ignore: cast_nullable_to_non_nullable
              as List<String>,
      records: records == freezed
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as NDEFMessage?,
      supportsNFC: supportsNFC == freezed
          ? _value.supportsNFC
          : supportsNFC // ignore: cast_nullable_to_non_nullable
              as bool,
      stream: stream == freezed
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<NDEFMessage>?,
      errorText: errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) then) =
      __$HomeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<String> readResults,
      List<String> records,
      NDEFMessage? tag,
      bool supportsNFC,
      StreamSubscription<NDEFMessage>? stream,
      String errorText});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(_HomeState _value, $Res Function(_HomeState) _then)
      : super(_value, (v) => _then(v as _HomeState));

  @override
  _HomeState get _value => super._value as _HomeState;

  @override
  $Res call({
    Object? readResults = freezed,
    Object? records = freezed,
    Object? tag = freezed,
    Object? supportsNFC = freezed,
    Object? stream = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_HomeState(
      readResults: readResults == freezed
          ? _value.readResults
          : readResults // ignore: cast_nullable_to_non_nullable
              as List<String>,
      records: records == freezed
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as NDEFMessage?,
      supportsNFC: supportsNFC == freezed
          ? _value.supportsNFC
          : supportsNFC // ignore: cast_nullable_to_non_nullable
              as bool,
      stream: stream == freezed
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<NDEFMessage>?,
      errorText: errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_HomeState implements _HomeState {
  _$_HomeState(
      {this.readResults = const [],
      this.records = const [],
      this.tag,
      this.supportsNFC = false,
      this.stream,
      this.errorText = ''});

  @JsonKey()
  @override
  final List<String> readResults;
  @JsonKey()
  @override
  final List<String> records;
  @override
  final NDEFMessage? tag;
  @JsonKey()
  @override
  final bool supportsNFC;
  @override
  final StreamSubscription<NDEFMessage>? stream;
  @JsonKey()
  @override
  final String errorText;

  @override
  String toString() {
    return 'HomeState(readResults: $readResults, records: $records, tag: $tag, supportsNFC: $supportsNFC, stream: $stream, errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeState &&
            const DeepCollectionEquality()
                .equals(other.readResults, readResults) &&
            const DeepCollectionEquality().equals(other.records, records) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            const DeepCollectionEquality()
                .equals(other.supportsNFC, supportsNFC) &&
            const DeepCollectionEquality().equals(other.stream, stream) &&
            const DeepCollectionEquality().equals(other.errorText, errorText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(readResults),
      const DeepCollectionEquality().hash(records),
      const DeepCollectionEquality().hash(tag),
      const DeepCollectionEquality().hash(supportsNFC),
      const DeepCollectionEquality().hash(stream),
      const DeepCollectionEquality().hash(errorText));

  @JsonKey(ignore: true)
  @override
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {List<String> readResults,
      List<String> records,
      NDEFMessage? tag,
      bool supportsNFC,
      StreamSubscription<NDEFMessage>? stream,
      String errorText}) = _$_HomeState;

  @override
  List<String> get readResults;
  @override
  List<String> get records;
  @override
  NDEFMessage? get tag;
  @override
  bool get supportsNFC;
  @override
  StreamSubscription<NDEFMessage>? get stream;
  @override
  String get errorText;
  @override
  @JsonKey(ignore: true)
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
