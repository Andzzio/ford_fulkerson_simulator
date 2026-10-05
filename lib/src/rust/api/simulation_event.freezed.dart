// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SimulationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nodeId, List<String> queueNodes)
    inspectNode,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )
    traverseEdge,
    required TResult Function(List<String> pathNodeIds, int bottleneck)
    pathFound,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )
    pushFlow,
    required TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )
    finished,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult? Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult? Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationEvent_InspectNode value) inspectNode,
    required TResult Function(SimulationEvent_TraverseEdge value) traverseEdge,
    required TResult Function(SimulationEvent_PathFound value) pathFound,
    required TResult Function(SimulationEvent_PushFlow value) pushFlow,
    required TResult Function(SimulationEvent_Finished value) finished,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult? Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult? Function(SimulationEvent_PathFound value)? pathFound,
    TResult? Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult? Function(SimulationEvent_Finished value)? finished,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult Function(SimulationEvent_PathFound value)? pathFound,
    TResult Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult Function(SimulationEvent_Finished value)? finished,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationEventCopyWith<$Res> {
  factory $SimulationEventCopyWith(
    SimulationEvent value,
    $Res Function(SimulationEvent) then,
  ) = _$SimulationEventCopyWithImpl<$Res, SimulationEvent>;
}

/// @nodoc
class _$SimulationEventCopyWithImpl<$Res, $Val extends SimulationEvent>
    implements $SimulationEventCopyWith<$Res> {
  _$SimulationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SimulationEvent_InspectNodeImplCopyWith<$Res> {
  factory _$$SimulationEvent_InspectNodeImplCopyWith(
    _$SimulationEvent_InspectNodeImpl value,
    $Res Function(_$SimulationEvent_InspectNodeImpl) then,
  ) = __$$SimulationEvent_InspectNodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nodeId, List<String> queueNodes});
}

/// @nodoc
class __$$SimulationEvent_InspectNodeImplCopyWithImpl<$Res>
    extends
        _$SimulationEventCopyWithImpl<$Res, _$SimulationEvent_InspectNodeImpl>
    implements _$$SimulationEvent_InspectNodeImplCopyWith<$Res> {
  __$$SimulationEvent_InspectNodeImplCopyWithImpl(
    _$SimulationEvent_InspectNodeImpl _value,
    $Res Function(_$SimulationEvent_InspectNodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? nodeId = null, Object? queueNodes = null}) {
    return _then(
      _$SimulationEvent_InspectNodeImpl(
        nodeId: null == nodeId
            ? _value.nodeId
            : nodeId // ignore: cast_nullable_to_non_nullable
                  as String,
        queueNodes: null == queueNodes
            ? _value._queueNodes
            : queueNodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SimulationEvent_InspectNodeImpl extends SimulationEvent_InspectNode {
  const _$SimulationEvent_InspectNodeImpl({
    required this.nodeId,
    required List<String> queueNodes,
  }) : _queueNodes = queueNodes,
       super._();

  @override
  final String nodeId;
  final List<String> _queueNodes;
  @override
  List<String> get queueNodes {
    if (_queueNodes is EqualUnmodifiableListView) return _queueNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queueNodes);
  }

  @override
  String toString() {
    return 'SimulationEvent.inspectNode(nodeId: $nodeId, queueNodes: $queueNodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationEvent_InspectNodeImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            const DeepCollectionEquality().equals(
              other._queueNodes,
              _queueNodes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    nodeId,
    const DeepCollectionEquality().hash(_queueNodes),
  );

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationEvent_InspectNodeImplCopyWith<_$SimulationEvent_InspectNodeImpl>
  get copyWith =>
      __$$SimulationEvent_InspectNodeImplCopyWithImpl<
        _$SimulationEvent_InspectNodeImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nodeId, List<String> queueNodes)
    inspectNode,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )
    traverseEdge,
    required TResult Function(List<String> pathNodeIds, int bottleneck)
    pathFound,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )
    pushFlow,
    required TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )
    finished,
  }) {
    return inspectNode(nodeId, queueNodes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult? Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult? Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
  }) {
    return inspectNode?.call(nodeId, queueNodes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
    required TResult orElse(),
  }) {
    if (inspectNode != null) {
      return inspectNode(nodeId, queueNodes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationEvent_InspectNode value) inspectNode,
    required TResult Function(SimulationEvent_TraverseEdge value) traverseEdge,
    required TResult Function(SimulationEvent_PathFound value) pathFound,
    required TResult Function(SimulationEvent_PushFlow value) pushFlow,
    required TResult Function(SimulationEvent_Finished value) finished,
  }) {
    return inspectNode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult? Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult? Function(SimulationEvent_PathFound value)? pathFound,
    TResult? Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult? Function(SimulationEvent_Finished value)? finished,
  }) {
    return inspectNode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult Function(SimulationEvent_PathFound value)? pathFound,
    TResult Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult Function(SimulationEvent_Finished value)? finished,
    required TResult orElse(),
  }) {
    if (inspectNode != null) {
      return inspectNode(this);
    }
    return orElse();
  }
}

abstract class SimulationEvent_InspectNode extends SimulationEvent {
  const factory SimulationEvent_InspectNode({
    required String nodeId,
    required List<String> queueNodes,
  }) = _$SimulationEvent_InspectNodeImpl;
  const SimulationEvent_InspectNode._() : super._();

  String get nodeId;
  List<String> get queueNodes;

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationEvent_InspectNodeImplCopyWith<_$SimulationEvent_InspectNodeImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SimulationEvent_TraverseEdgeImplCopyWith<$Res> {
  factory _$$SimulationEvent_TraverseEdgeImplCopyWith(
    _$SimulationEvent_TraverseEdgeImpl value,
    $Res Function(_$SimulationEvent_TraverseEdgeImpl) then,
  ) = __$$SimulationEvent_TraverseEdgeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String edgeId, String from, String to, List<String> queueNodes});
}

/// @nodoc
class __$$SimulationEvent_TraverseEdgeImplCopyWithImpl<$Res>
    extends
        _$SimulationEventCopyWithImpl<$Res, _$SimulationEvent_TraverseEdgeImpl>
    implements _$$SimulationEvent_TraverseEdgeImplCopyWith<$Res> {
  __$$SimulationEvent_TraverseEdgeImplCopyWithImpl(
    _$SimulationEvent_TraverseEdgeImpl _value,
    $Res Function(_$SimulationEvent_TraverseEdgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? from = null,
    Object? to = null,
    Object? queueNodes = null,
  }) {
    return _then(
      _$SimulationEvent_TraverseEdgeImpl(
        edgeId: null == edgeId
            ? _value.edgeId
            : edgeId // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String,
        queueNodes: null == queueNodes
            ? _value._queueNodes
            : queueNodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SimulationEvent_TraverseEdgeImpl extends SimulationEvent_TraverseEdge {
  const _$SimulationEvent_TraverseEdgeImpl({
    required this.edgeId,
    required this.from,
    required this.to,
    required List<String> queueNodes,
  }) : _queueNodes = queueNodes,
       super._();

  @override
  final String edgeId;
  @override
  final String from;
  @override
  final String to;
  final List<String> _queueNodes;
  @override
  List<String> get queueNodes {
    if (_queueNodes is EqualUnmodifiableListView) return _queueNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queueNodes);
  }

  @override
  String toString() {
    return 'SimulationEvent.traverseEdge(edgeId: $edgeId, from: $from, to: $to, queueNodes: $queueNodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationEvent_TraverseEdgeImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            const DeepCollectionEquality().equals(
              other._queueNodes,
              _queueNodes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    edgeId,
    from,
    to,
    const DeepCollectionEquality().hash(_queueNodes),
  );

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationEvent_TraverseEdgeImplCopyWith<
    _$SimulationEvent_TraverseEdgeImpl
  >
  get copyWith =>
      __$$SimulationEvent_TraverseEdgeImplCopyWithImpl<
        _$SimulationEvent_TraverseEdgeImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nodeId, List<String> queueNodes)
    inspectNode,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )
    traverseEdge,
    required TResult Function(List<String> pathNodeIds, int bottleneck)
    pathFound,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )
    pushFlow,
    required TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )
    finished,
  }) {
    return traverseEdge(edgeId, from, to, queueNodes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult? Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult? Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
  }) {
    return traverseEdge?.call(edgeId, from, to, queueNodes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
    required TResult orElse(),
  }) {
    if (traverseEdge != null) {
      return traverseEdge(edgeId, from, to, queueNodes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationEvent_InspectNode value) inspectNode,
    required TResult Function(SimulationEvent_TraverseEdge value) traverseEdge,
    required TResult Function(SimulationEvent_PathFound value) pathFound,
    required TResult Function(SimulationEvent_PushFlow value) pushFlow,
    required TResult Function(SimulationEvent_Finished value) finished,
  }) {
    return traverseEdge(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult? Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult? Function(SimulationEvent_PathFound value)? pathFound,
    TResult? Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult? Function(SimulationEvent_Finished value)? finished,
  }) {
    return traverseEdge?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult Function(SimulationEvent_PathFound value)? pathFound,
    TResult Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult Function(SimulationEvent_Finished value)? finished,
    required TResult orElse(),
  }) {
    if (traverseEdge != null) {
      return traverseEdge(this);
    }
    return orElse();
  }
}

abstract class SimulationEvent_TraverseEdge extends SimulationEvent {
  const factory SimulationEvent_TraverseEdge({
    required String edgeId,
    required String from,
    required String to,
    required List<String> queueNodes,
  }) = _$SimulationEvent_TraverseEdgeImpl;
  const SimulationEvent_TraverseEdge._() : super._();

  String get edgeId;
  String get from;
  String get to;
  List<String> get queueNodes;

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationEvent_TraverseEdgeImplCopyWith<
    _$SimulationEvent_TraverseEdgeImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SimulationEvent_PathFoundImplCopyWith<$Res> {
  factory _$$SimulationEvent_PathFoundImplCopyWith(
    _$SimulationEvent_PathFoundImpl value,
    $Res Function(_$SimulationEvent_PathFoundImpl) then,
  ) = __$$SimulationEvent_PathFoundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> pathNodeIds, int bottleneck});
}

/// @nodoc
class __$$SimulationEvent_PathFoundImplCopyWithImpl<$Res>
    extends _$SimulationEventCopyWithImpl<$Res, _$SimulationEvent_PathFoundImpl>
    implements _$$SimulationEvent_PathFoundImplCopyWith<$Res> {
  __$$SimulationEvent_PathFoundImplCopyWithImpl(
    _$SimulationEvent_PathFoundImpl _value,
    $Res Function(_$SimulationEvent_PathFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? pathNodeIds = null, Object? bottleneck = null}) {
    return _then(
      _$SimulationEvent_PathFoundImpl(
        pathNodeIds: null == pathNodeIds
            ? _value._pathNodeIds
            : pathNodeIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        bottleneck: null == bottleneck
            ? _value.bottleneck
            : bottleneck // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SimulationEvent_PathFoundImpl extends SimulationEvent_PathFound {
  const _$SimulationEvent_PathFoundImpl({
    required List<String> pathNodeIds,
    required this.bottleneck,
  }) : _pathNodeIds = pathNodeIds,
       super._();

  final List<String> _pathNodeIds;
  @override
  List<String> get pathNodeIds {
    if (_pathNodeIds is EqualUnmodifiableListView) return _pathNodeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pathNodeIds);
  }

  @override
  final int bottleneck;

  @override
  String toString() {
    return 'SimulationEvent.pathFound(pathNodeIds: $pathNodeIds, bottleneck: $bottleneck)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationEvent_PathFoundImpl &&
            const DeepCollectionEquality().equals(
              other._pathNodeIds,
              _pathNodeIds,
            ) &&
            (identical(other.bottleneck, bottleneck) ||
                other.bottleneck == bottleneck));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pathNodeIds),
    bottleneck,
  );

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationEvent_PathFoundImplCopyWith<_$SimulationEvent_PathFoundImpl>
  get copyWith =>
      __$$SimulationEvent_PathFoundImplCopyWithImpl<
        _$SimulationEvent_PathFoundImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nodeId, List<String> queueNodes)
    inspectNode,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )
    traverseEdge,
    required TResult Function(List<String> pathNodeIds, int bottleneck)
    pathFound,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )
    pushFlow,
    required TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )
    finished,
  }) {
    return pathFound(pathNodeIds, bottleneck);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult? Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult? Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
  }) {
    return pathFound?.call(pathNodeIds, bottleneck);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
    required TResult orElse(),
  }) {
    if (pathFound != null) {
      return pathFound(pathNodeIds, bottleneck);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationEvent_InspectNode value) inspectNode,
    required TResult Function(SimulationEvent_TraverseEdge value) traverseEdge,
    required TResult Function(SimulationEvent_PathFound value) pathFound,
    required TResult Function(SimulationEvent_PushFlow value) pushFlow,
    required TResult Function(SimulationEvent_Finished value) finished,
  }) {
    return pathFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult? Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult? Function(SimulationEvent_PathFound value)? pathFound,
    TResult? Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult? Function(SimulationEvent_Finished value)? finished,
  }) {
    return pathFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult Function(SimulationEvent_PathFound value)? pathFound,
    TResult Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult Function(SimulationEvent_Finished value)? finished,
    required TResult orElse(),
  }) {
    if (pathFound != null) {
      return pathFound(this);
    }
    return orElse();
  }
}

abstract class SimulationEvent_PathFound extends SimulationEvent {
  const factory SimulationEvent_PathFound({
    required List<String> pathNodeIds,
    required int bottleneck,
  }) = _$SimulationEvent_PathFoundImpl;
  const SimulationEvent_PathFound._() : super._();

  List<String> get pathNodeIds;
  int get bottleneck;

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationEvent_PathFoundImplCopyWith<_$SimulationEvent_PathFoundImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SimulationEvent_PushFlowImplCopyWith<$Res> {
  factory _$$SimulationEvent_PushFlowImplCopyWith(
    _$SimulationEvent_PushFlowImpl value,
    $Res Function(_$SimulationEvent_PushFlowImpl) then,
  ) = __$$SimulationEvent_PushFlowImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String edgeId, String from, String to, int delta, int newFlow});
}

/// @nodoc
class __$$SimulationEvent_PushFlowImplCopyWithImpl<$Res>
    extends _$SimulationEventCopyWithImpl<$Res, _$SimulationEvent_PushFlowImpl>
    implements _$$SimulationEvent_PushFlowImplCopyWith<$Res> {
  __$$SimulationEvent_PushFlowImplCopyWithImpl(
    _$SimulationEvent_PushFlowImpl _value,
    $Res Function(_$SimulationEvent_PushFlowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? from = null,
    Object? to = null,
    Object? delta = null,
    Object? newFlow = null,
  }) {
    return _then(
      _$SimulationEvent_PushFlowImpl(
        edgeId: null == edgeId
            ? _value.edgeId
            : edgeId // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String,
        delta: null == delta
            ? _value.delta
            : delta // ignore: cast_nullable_to_non_nullable
                  as int,
        newFlow: null == newFlow
            ? _value.newFlow
            : newFlow // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SimulationEvent_PushFlowImpl extends SimulationEvent_PushFlow {
  const _$SimulationEvent_PushFlowImpl({
    required this.edgeId,
    required this.from,
    required this.to,
    required this.delta,
    required this.newFlow,
  }) : super._();

  @override
  final String edgeId;
  @override
  final String from;
  @override
  final String to;
  @override
  final int delta;
  @override
  final int newFlow;

  @override
  String toString() {
    return 'SimulationEvent.pushFlow(edgeId: $edgeId, from: $from, to: $to, delta: $delta, newFlow: $newFlow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationEvent_PushFlowImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.delta, delta) || other.delta == delta) &&
            (identical(other.newFlow, newFlow) || other.newFlow == newFlow));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, edgeId, from, to, delta, newFlow);

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationEvent_PushFlowImplCopyWith<_$SimulationEvent_PushFlowImpl>
  get copyWith =>
      __$$SimulationEvent_PushFlowImplCopyWithImpl<
        _$SimulationEvent_PushFlowImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nodeId, List<String> queueNodes)
    inspectNode,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )
    traverseEdge,
    required TResult Function(List<String> pathNodeIds, int bottleneck)
    pathFound,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )
    pushFlow,
    required TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )
    finished,
  }) {
    return pushFlow(edgeId, from, to, delta, newFlow);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult? Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult? Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
  }) {
    return pushFlow?.call(edgeId, from, to, delta, newFlow);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
    required TResult orElse(),
  }) {
    if (pushFlow != null) {
      return pushFlow(edgeId, from, to, delta, newFlow);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationEvent_InspectNode value) inspectNode,
    required TResult Function(SimulationEvent_TraverseEdge value) traverseEdge,
    required TResult Function(SimulationEvent_PathFound value) pathFound,
    required TResult Function(SimulationEvent_PushFlow value) pushFlow,
    required TResult Function(SimulationEvent_Finished value) finished,
  }) {
    return pushFlow(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult? Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult? Function(SimulationEvent_PathFound value)? pathFound,
    TResult? Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult? Function(SimulationEvent_Finished value)? finished,
  }) {
    return pushFlow?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult Function(SimulationEvent_PathFound value)? pathFound,
    TResult Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult Function(SimulationEvent_Finished value)? finished,
    required TResult orElse(),
  }) {
    if (pushFlow != null) {
      return pushFlow(this);
    }
    return orElse();
  }
}

abstract class SimulationEvent_PushFlow extends SimulationEvent {
  const factory SimulationEvent_PushFlow({
    required String edgeId,
    required String from,
    required String to,
    required int delta,
    required int newFlow,
  }) = _$SimulationEvent_PushFlowImpl;
  const SimulationEvent_PushFlow._() : super._();

  String get edgeId;
  String get from;
  String get to;
  int get delta;
  int get newFlow;

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationEvent_PushFlowImplCopyWith<_$SimulationEvent_PushFlowImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SimulationEvent_FinishedImplCopyWith<$Res> {
  factory _$$SimulationEvent_FinishedImplCopyWith(
    _$SimulationEvent_FinishedImpl value,
    $Res Function(_$SimulationEvent_FinishedImpl) then,
  ) = __$$SimulationEvent_FinishedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    int maxFlow,
    List<String> minCutSourceNodes,
    List<String> minCutSinkNodes,
  });
}

/// @nodoc
class __$$SimulationEvent_FinishedImplCopyWithImpl<$Res>
    extends _$SimulationEventCopyWithImpl<$Res, _$SimulationEvent_FinishedImpl>
    implements _$$SimulationEvent_FinishedImplCopyWith<$Res> {
  __$$SimulationEvent_FinishedImplCopyWithImpl(
    _$SimulationEvent_FinishedImpl _value,
    $Res Function(_$SimulationEvent_FinishedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxFlow = null,
    Object? minCutSourceNodes = null,
    Object? minCutSinkNodes = null,
  }) {
    return _then(
      _$SimulationEvent_FinishedImpl(
        maxFlow: null == maxFlow
            ? _value.maxFlow
            : maxFlow // ignore: cast_nullable_to_non_nullable
                  as int,
        minCutSourceNodes: null == minCutSourceNodes
            ? _value._minCutSourceNodes
            : minCutSourceNodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        minCutSinkNodes: null == minCutSinkNodes
            ? _value._minCutSinkNodes
            : minCutSinkNodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SimulationEvent_FinishedImpl extends SimulationEvent_Finished {
  const _$SimulationEvent_FinishedImpl({
    required this.maxFlow,
    required List<String> minCutSourceNodes,
    required List<String> minCutSinkNodes,
  }) : _minCutSourceNodes = minCutSourceNodes,
       _minCutSinkNodes = minCutSinkNodes,
       super._();

  @override
  final int maxFlow;
  final List<String> _minCutSourceNodes;
  @override
  List<String> get minCutSourceNodes {
    if (_minCutSourceNodes is EqualUnmodifiableListView)
      return _minCutSourceNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_minCutSourceNodes);
  }

  final List<String> _minCutSinkNodes;
  @override
  List<String> get minCutSinkNodes {
    if (_minCutSinkNodes is EqualUnmodifiableListView) return _minCutSinkNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_minCutSinkNodes);
  }

  @override
  String toString() {
    return 'SimulationEvent.finished(maxFlow: $maxFlow, minCutSourceNodes: $minCutSourceNodes, minCutSinkNodes: $minCutSinkNodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationEvent_FinishedImpl &&
            (identical(other.maxFlow, maxFlow) || other.maxFlow == maxFlow) &&
            const DeepCollectionEquality().equals(
              other._minCutSourceNodes,
              _minCutSourceNodes,
            ) &&
            const DeepCollectionEquality().equals(
              other._minCutSinkNodes,
              _minCutSinkNodes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    maxFlow,
    const DeepCollectionEquality().hash(_minCutSourceNodes),
    const DeepCollectionEquality().hash(_minCutSinkNodes),
  );

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationEvent_FinishedImplCopyWith<_$SimulationEvent_FinishedImpl>
  get copyWith =>
      __$$SimulationEvent_FinishedImplCopyWithImpl<
        _$SimulationEvent_FinishedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String nodeId, List<String> queueNodes)
    inspectNode,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )
    traverseEdge,
    required TResult Function(List<String> pathNodeIds, int bottleneck)
    pathFound,
    required TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )
    pushFlow,
    required TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )
    finished,
  }) {
    return finished(maxFlow, minCutSourceNodes, minCutSinkNodes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult? Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult? Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult? Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
  }) {
    return finished?.call(maxFlow, minCutSourceNodes, minCutSinkNodes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String nodeId, List<String> queueNodes)? inspectNode,
    TResult Function(
      String edgeId,
      String from,
      String to,
      List<String> queueNodes,
    )?
    traverseEdge,
    TResult Function(List<String> pathNodeIds, int bottleneck)? pathFound,
    TResult Function(
      String edgeId,
      String from,
      String to,
      int delta,
      int newFlow,
    )?
    pushFlow,
    TResult Function(
      int maxFlow,
      List<String> minCutSourceNodes,
      List<String> minCutSinkNodes,
    )?
    finished,
    required TResult orElse(),
  }) {
    if (finished != null) {
      return finished(maxFlow, minCutSourceNodes, minCutSinkNodes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationEvent_InspectNode value) inspectNode,
    required TResult Function(SimulationEvent_TraverseEdge value) traverseEdge,
    required TResult Function(SimulationEvent_PathFound value) pathFound,
    required TResult Function(SimulationEvent_PushFlow value) pushFlow,
    required TResult Function(SimulationEvent_Finished value) finished,
  }) {
    return finished(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult? Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult? Function(SimulationEvent_PathFound value)? pathFound,
    TResult? Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult? Function(SimulationEvent_Finished value)? finished,
  }) {
    return finished?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationEvent_InspectNode value)? inspectNode,
    TResult Function(SimulationEvent_TraverseEdge value)? traverseEdge,
    TResult Function(SimulationEvent_PathFound value)? pathFound,
    TResult Function(SimulationEvent_PushFlow value)? pushFlow,
    TResult Function(SimulationEvent_Finished value)? finished,
    required TResult orElse(),
  }) {
    if (finished != null) {
      return finished(this);
    }
    return orElse();
  }
}

abstract class SimulationEvent_Finished extends SimulationEvent {
  const factory SimulationEvent_Finished({
    required int maxFlow,
    required List<String> minCutSourceNodes,
    required List<String> minCutSinkNodes,
  }) = _$SimulationEvent_FinishedImpl;
  const SimulationEvent_Finished._() : super._();

  int get maxFlow;
  List<String> get minCutSourceNodes;
  List<String> get minCutSinkNodes;

  /// Create a copy of SimulationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationEvent_FinishedImplCopyWith<_$SimulationEvent_FinishedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
