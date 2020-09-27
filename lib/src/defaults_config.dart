import 'package:flutter/material.dart';

class DefaultsConfig {
  static Widget _defaultBusyWidget = _DEFAULT_BUSY_WIDGET;
  static Widget _defaultWidget = _DEFAULT_WIDGET;

  static Widget get defaultBusyWidget => _defaultBusyWidget;
  static set defaultBusyWidget(Widget value) => _defaultBusyWidget = value ?? _defaultBusyWidget;

  static Widget get defaultWidget => _defaultWidget;
  static set defaultWidget(Widget value) => _defaultWidget = value ?? _defaultWidget;
}

const _DEFAULT_BUSY_WIDGET = Center(child: CircularProgressIndicator());
const _DEFAULT_WIDGET = SizedBox.shrink();
