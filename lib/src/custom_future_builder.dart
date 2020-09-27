import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'defaults_config.dart';

// ignore_for_file: unused_element

/// A widget that makes it easy to execute a [Future] from a StatelessWidget.
class CustomFutureBuilder<T> extends StatefulWidget {
  /// Function that returns the [Future] to execute. Not the [Future] itself.
  final AsyncValueGetter<T> futureBuilder;

  /// Whether to immediately begin executing the [Future]. If true, [initialBuilder] must be null.
  final bool autoStart;

  /// Widget to display before the [Future] starts executing.
  /// Call [VoidCallback] to start executing the [Future].
  /// If not null, [autoStart] should be false.
  final Widget Function(BuildContext, VoidCallback) initialBuilder;

  /// Widget to display while the [Future] is executing.
  /// If null, a [CircularProgressIndicator] will be displayed.
  final WidgetBuilder busyBuilder;

  /// Widget to display when the [Future] has completed with an error.
  /// If null, [initialBuilder] will be displayed again.
  /// The [Object] is the [Error] or [Exception] returned by the [Future].
  /// Call [VoidCallback] to start executing the [Future] again.
  final Widget Function(BuildContext, Object, VoidCallback) errorBuilder;

  /// Widget to display when the [Future] has completed successfully.
  /// If null, [initialBuilder] will be displayed again.
  final Widget Function(BuildContext, T) dataBuilder;

  /// Callback to invoke when the [Future] has completed successfully.
  /// Will only be invoked once per [Future] execution.
  final ValueChanged<T> onData;

  /// Callback to invoke when the [Future] has completed with an error.
  /// Will only be invoked once per [Future] execution.
  /// Call [VoidCallback] to start executing the [Future] again.
  final void Function(Object, VoidCallback) onError;

  const CustomFutureBuilder({
    Key key,
    @required this.futureBuilder,
    this.autoStart = false,
    this.initialBuilder,
    this.busyBuilder,
    this.errorBuilder,
    this.dataBuilder,
    this.onData,
    this.onError,
  })  : assert(futureBuilder != null),
        assert(autoStart ^ (initialBuilder != null)),
        super(key: key);

  @override
  _CustomFutureBuilderState<T> createState() => _CustomFutureBuilderState<T>();

  CustomFutureBuilder.autoStart({
    @required this.futureBuilder,
    this.busyBuilder,
    this.errorBuilder,
    this.dataBuilder,
    this.onData,
    this.onError,
  })  : initialBuilder = null,
        autoStart = true;

  CustomFutureBuilder.builder({
    @required this.futureBuilder,
    @required this.initialBuilder,
    this.busyBuilder,
    this.errorBuilder,
    this.dataBuilder,
    this.onData,
    this.onError,
  }) : autoStart = false;
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  Future<T> _future;

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      _execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (_context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _handleInitial(_context);
          case ConnectionState.waiting:
          case ConnectionState.active:
            return _handleBusy(_context);
          case ConnectionState.done:
            return _handleSnapshot(_context, snapshot);
          default:
            return DefaultsConfig.defaultWidget;
        }
      },
    );
  }

  Widget _handleInitial(BuildContext context) {
    if (widget.initialBuilder != null) {
      return widget.initialBuilder(context, _execute);
    }
    return DefaultsConfig.defaultWidget;
  }

  Widget _handleSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) {
      return _handleError(context, snapshot.error);
    }
    return _handleData(context, snapshot.data);
  }

  Widget _handleError(BuildContext context, Object error) {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder(context, error, _execute);
    }
    return _handleInitial(context);
  }

  Widget _handleData(BuildContext context, T data) {
    if (widget.dataBuilder != null) {
      return widget.dataBuilder(context, data);
    }
    return _handleInitial(context);
  }

  Widget _handleBusy(BuildContext context) {
    if (widget.busyBuilder == null) {
      return DefaultsConfig.defaultBusyWidget;
    }
    return widget.busyBuilder(context);
  }

  void _execute() {
    setState(() {
      _future = widget.futureBuilder();
      _future.then(_onData).catchError(_onError);
    });
  }

  void _onData(T data) async {
    if (widget.onData != null && _isActive) {
      widget.onData(data);
    }
  }

  void _onError(Object e) async {
    if (widget.onError != null && _isActive) {
      widget.onError(e, _execute);
    }
  }

  bool get _isActive => mounted && (ModalRoute.of(context)?.isActive ?? true);
}
