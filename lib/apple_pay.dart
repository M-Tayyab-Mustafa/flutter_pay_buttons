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
/// Author: [Your Name or Company]
/// License: MIT
/// Copyright © 2025
/// ---------------------------------------------------------------------------

library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay/pay.dart';

// Export everything from pay except our custom ApplePayButton widget
export 'package:pay/pay.dart' hide ApplePayButton;

// Link to the internal implementation of ApplePayButton
part 'src/pay.dart';
