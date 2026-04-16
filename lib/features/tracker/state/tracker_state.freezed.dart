// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrackerState {
  List<InterviewLogModel> get upcomingLogs =>
      throw _privateConstructorUsedError;
  List<InterviewLogModel> get historyLogs => throw _privateConstructorUsedError;
  LoaderState get loaderState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TrackerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackerStateCopyWith<TrackerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackerStateCopyWith<$Res> {
  factory $TrackerStateCopyWith(
    TrackerState value,
    $Res Function(TrackerState) then,
  ) = _$TrackerStateCopyWithImpl<$Res, TrackerState>;
  @useResult
  $Res call({
    List<InterviewLogModel> upcomingLogs,
    List<InterviewLogModel> historyLogs,
    LoaderState loaderState,
    String? errorMessage,
  });
}

/// @nodoc
class _$TrackerStateCopyWithImpl<$Res, $Val extends TrackerState>
    implements $TrackerStateCopyWith<$Res> {
  _$TrackerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcomingLogs = null,
    Object? historyLogs = null,
    Object? loaderState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            upcomingLogs: null == upcomingLogs
                ? _value.upcomingLogs
                : upcomingLogs // ignore: cast_nullable_to_non_nullable
                      as List<InterviewLogModel>,
            historyLogs: null == historyLogs
                ? _value.historyLogs
                : historyLogs // ignore: cast_nullable_to_non_nullable
                      as List<InterviewLogModel>,
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrackerStateImplCopyWith<$Res>
    implements $TrackerStateCopyWith<$Res> {
  factory _$$TrackerStateImplCopyWith(
    _$TrackerStateImpl value,
    $Res Function(_$TrackerStateImpl) then,
  ) = __$$TrackerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<InterviewLogModel> upcomingLogs,
    List<InterviewLogModel> historyLogs,
    LoaderState loaderState,
    String? errorMessage,
  });
}

/// @nodoc
class __$$TrackerStateImplCopyWithImpl<$Res>
    extends _$TrackerStateCopyWithImpl<$Res, _$TrackerStateImpl>
    implements _$$TrackerStateImplCopyWith<$Res> {
  __$$TrackerStateImplCopyWithImpl(
    _$TrackerStateImpl _value,
    $Res Function(_$TrackerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcomingLogs = null,
    Object? historyLogs = null,
    Object? loaderState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$TrackerStateImpl(
        upcomingLogs: null == upcomingLogs
            ? _value._upcomingLogs
            : upcomingLogs // ignore: cast_nullable_to_non_nullable
                  as List<InterviewLogModel>,
        historyLogs: null == historyLogs
            ? _value._historyLogs
            : historyLogs // ignore: cast_nullable_to_non_nullable
                  as List<InterviewLogModel>,
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TrackerStateImpl implements _TrackerState {
  const _$TrackerStateImpl({
    final List<InterviewLogModel> upcomingLogs = const [],
    final List<InterviewLogModel> historyLogs = const [],
    this.loaderState = LoaderState.initial,
    this.errorMessage,
  }) : _upcomingLogs = upcomingLogs,
       _historyLogs = historyLogs;

  final List<InterviewLogModel> _upcomingLogs;
  @override
  @JsonKey()
  List<InterviewLogModel> get upcomingLogs {
    if (_upcomingLogs is EqualUnmodifiableListView) return _upcomingLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingLogs);
  }

  final List<InterviewLogModel> _historyLogs;
  @override
  @JsonKey()
  List<InterviewLogModel> get historyLogs {
    if (_historyLogs is EqualUnmodifiableListView) return _historyLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyLogs);
  }

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TrackerState(upcomingLogs: $upcomingLogs, historyLogs: $historyLogs, loaderState: $loaderState, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackerStateImpl &&
            const DeepCollectionEquality().equals(
              other._upcomingLogs,
              _upcomingLogs,
            ) &&
            const DeepCollectionEquality().equals(
              other._historyLogs,
              _historyLogs,
            ) &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_upcomingLogs),
    const DeepCollectionEquality().hash(_historyLogs),
    loaderState,
    errorMessage,
  );

  /// Create a copy of TrackerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackerStateImplCopyWith<_$TrackerStateImpl> get copyWith =>
      __$$TrackerStateImplCopyWithImpl<_$TrackerStateImpl>(this, _$identity);
}

abstract class _TrackerState implements TrackerState {
  const factory _TrackerState({
    final List<InterviewLogModel> upcomingLogs,
    final List<InterviewLogModel> historyLogs,
    final LoaderState loaderState,
    final String? errorMessage,
  }) = _$TrackerStateImpl;

  @override
  List<InterviewLogModel> get upcomingLogs;
  @override
  List<InterviewLogModel> get historyLogs;
  @override
  LoaderState get loaderState;
  @override
  String? get errorMessage;

  /// Create a copy of TrackerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackerStateImplCopyWith<_$TrackerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
