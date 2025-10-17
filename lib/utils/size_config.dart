/// Copyright 2024 M-Tayyab-Mustafa
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

// part of the main flutter_pay_buttons.dart file (used for code organization)
part of '../flutter_pay_buttons.dart';

/// A utility class for responsive scaling of UI elements
/// based on the device's screen size.
///
/// This allows widgets, paddings, and font sizes to scale
/// proportionally according to the screen dimensions.
class SizeConfig {
  // Private constructor to prevent instantiation
  const SizeConfig._();

  // Stores a reference to the app's BuildContext
  static late BuildContext _context;

  // The calculated scale factor for UI scaling
  static late double _scale;

  // Provides access to MediaQuery data (screen size, density, etc.)
  static final mediaQuery = MediaQuery.of(_context);

  // The actual physical size of the device screen
  static final Size _size = Size(mediaQuery.size.width.ceilToDouble(), mediaQuery.size.height.ceilToDouble());

  // The default reference screen size (iPhone X dimensions)
  static final Size _logicalSize = Size(375, 812);

  /// Initializes the scaling configuration.
  ///
  /// Call this method once (usually in the root widget) and
  /// pass in the current `BuildContext`.
  ///
  /// Optionally, you can specify custom base width and height
  /// for your design layout.
  static void initialization(BuildContext context, {double? baseWidth, double? baseHeight}) {
    _context = context;

    // Calculate scale ratios for width and height
    double scaleHeight = _size.height / (baseHeight ?? _logicalSize.height);
    double scaleWidth = _size.width / (baseWidth ?? _logicalSize.width);

    // Choose the smaller scale to maintain aspect ratio
    _scale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
  }
}

/// Extension on [num] to easily scale padding, radius, and font sizes
extension SizeConfigExtension on num {
  /// Returns a scaled value for padding, radius, margin, etc.
  double get pr => this * SizeConfig._scale;

  /// Returns a scaled font size based on text scale and screen size
  double get sp => MediaQuery.of(SizeConfig._context).textScaler.scale(this * SizeConfig._scale);
}

/// A helper class that creates [EdgeInsets] using scaled values
/// (useful for responsive spacing and padding)
class ScaledEdgeInsets extends EdgeInsets {
  /// Creates scaled padding using left, top, right, bottom values
  ScaledEdgeInsets.fromLTRB(double left, double top, double right, double bottom) : super.fromLTRB(left.pr, top.pr, right.pr, bottom.pr);

  /// Creates uniform scaled padding on all sides
  ScaledEdgeInsets.all(double value) : super.all(value.pr);

  /// Creates symmetric scaled padding (horizontal and vertical)
  ScaledEdgeInsets.symmetric({double horizontal = 0, double vertical = 0}) : super.symmetric(horizontal: horizontal.pr, vertical: vertical.pr);

  /// Creates padding only for specific sides
  ScaledEdgeInsets.only({double left = 0, double top = 0, double right = 0, double bottom = 0}) : super.only(left: left.pr, top: top.pr, right: right.pr, bottom: bottom.pr);

  /// Returns zero padding (same as `EdgeInsets.zero`)
  static EdgeInsets get zero => EdgeInsets.zero;
}
