/* SPDX-License-Identifier: CECILL-2.1
 * Copyright (c) 2024 M-Tayyab-Mustafa
 * Licensed under the CeCILL-2.1 License
 * See the LICENSE file for details.
 */

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
part 'utils/size_config.dart';
// Link to the internal implementations
part 'src/apple_pay.dart';
part 'src/google_pay.dart';
