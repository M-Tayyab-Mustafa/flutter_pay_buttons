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

/// ---------------------------------------------------------------------------
/// Apple Pay Flutter Plugin
/// ---------------------------------------------------------------------------
/// A Flutter library that provides a customizable Apple Pay button widget,
/// built on top of the `pay` package to simplify Apple Pay integrations.
///
/// Features:
/// - Exports most of the `pay` package functionality (except the built-in ApplePayButton)
/// - Adds a custom ApplePayButton with extended UI customization
///
/// Author: [M.Tayyab Mustafa]
/// License: MIT
/// Copyright © 2025
/// ---------------------------------------------------------------------------

library;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay/pay.dart';

// Export everything from pay except our custom ApplePayButton widget
export 'package:pay/pay.dart' hide ApplePayButton;

part 'utils/enums.dart';
// Link to the internal implementations
part 'src/apple_pay.dart';
part 'src/google_pay.dart';
