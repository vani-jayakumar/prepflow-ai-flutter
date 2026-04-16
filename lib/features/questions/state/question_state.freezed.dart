// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$QuestionState {
  List<QuestionModel> get universalQuestions =>
      throw _privateConstructorUsedError;
  List<QuestionModel> get personalizedQuestions =>
      throw _privateConstructorUsedError;
  LoaderState get loaderState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionStateCopyWith<QuestionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionStateCopyWith<$Res> {
  factory $QuestionStateCopyWith(
    QuestionState value,
    $Res Function(QuestionState) then,
  ) = _$QuestionStateCopyWithImpl<$Res, QuestionState>;
  @useResult
  $Res call({
    List<QuestionModel> universalQuestions,
    List<QuestionModel> personalizedQuestions,
    LoaderState loaderState,
    String? errorMessage,
  });
}

/// @nodoc
class _$QuestionStateCopyWithImpl<$Res, $Val extends QuestionState>
    implements $QuestionStateCopyWith<$Res> {
  _$QuestionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? universalQuestions = null,
    Object? personalizedQuestions = null,
    Object? loaderState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            universalQuestions: null == universalQuestions
                ? _value.universalQuestions
                : universalQuestions // ignore: cast_nullable_to_non_nullable
                      as List<QuestionModel>,
            personalizedQuestions: null == personalizedQuestions
                ? _value.personalizedQuestions
                : personalizedQuestions // ignore: cast_nullable_to_non_nullable
                      as List<QuestionModel>,
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
abstract class _$$QuestionStateImplCopyWith<$Res>
    implements $QuestionStateCopyWith<$Res> {
  factory _$$QuestionStateImplCopyWith(
    _$QuestionStateImpl value,
    $Res Function(_$QuestionStateImpl) then,
  ) = __$$QuestionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<QuestionModel> universalQuestions,
    List<QuestionModel> personalizedQuestions,
    LoaderState loaderState,
    String? errorMessage,
  });
}

/// @nodoc
class __$$QuestionStateImplCopyWithImpl<$Res>
    extends _$QuestionStateCopyWithImpl<$Res, _$QuestionStateImpl>
    implements _$$QuestionStateImplCopyWith<$Res> {
  __$$QuestionStateImplCopyWithImpl(
    _$QuestionStateImpl _value,
    $Res Function(_$QuestionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? universalQuestions = null,
    Object? personalizedQuestions = null,
    Object? loaderState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$QuestionStateImpl(
        universalQuestions: null == universalQuestions
            ? _value._universalQuestions
            : universalQuestions // ignore: cast_nullable_to_non_nullable
                  as List<QuestionModel>,
        personalizedQuestions: null == personalizedQuestions
            ? _value._personalizedQuestions
            : personalizedQuestions // ignore: cast_nullable_to_non_nullable
                  as List<QuestionModel>,
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

class _$QuestionStateImpl implements _QuestionState {
  const _$QuestionStateImpl({
    final List<QuestionModel> universalQuestions = const [],
    final List<QuestionModel> personalizedQuestions = const [],
    this.loaderState = LoaderState.initial,
    this.errorMessage,
  }) : _universalQuestions = universalQuestions,
       _personalizedQuestions = personalizedQuestions;

  final List<QuestionModel> _universalQuestions;
  @override
  @JsonKey()
  List<QuestionModel> get universalQuestions {
    if (_universalQuestions is EqualUnmodifiableListView)
      return _universalQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_universalQuestions);
  }

  final List<QuestionModel> _personalizedQuestions;
  @override
  @JsonKey()
  List<QuestionModel> get personalizedQuestions {
    if (_personalizedQuestions is EqualUnmodifiableListView)
      return _personalizedQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_personalizedQuestions);
  }

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'QuestionState(universalQuestions: $universalQuestions, personalizedQuestions: $personalizedQuestions, loaderState: $loaderState, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionStateImpl &&
            const DeepCollectionEquality().equals(
              other._universalQuestions,
              _universalQuestions,
            ) &&
            const DeepCollectionEquality().equals(
              other._personalizedQuestions,
              _personalizedQuestions,
            ) &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_universalQuestions),
    const DeepCollectionEquality().hash(_personalizedQuestions),
    loaderState,
    errorMessage,
  );

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionStateImplCopyWith<_$QuestionStateImpl> get copyWith =>
      __$$QuestionStateImplCopyWithImpl<_$QuestionStateImpl>(this, _$identity);
}

abstract class _QuestionState implements QuestionState {
  const factory _QuestionState({
    final List<QuestionModel> universalQuestions,
    final List<QuestionModel> personalizedQuestions,
    final LoaderState loaderState,
    final String? errorMessage,
  }) = _$QuestionStateImpl;

  @override
  List<QuestionModel> get universalQuestions;
  @override
  List<QuestionModel> get personalizedQuestions;
  @override
  LoaderState get loaderState;
  @override
  String? get errorMessage;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionStateImplCopyWith<_$QuestionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
