/// ---------------------------------------------------------------------------
/// pay_button library
/// ---------------------------------------------------------------------------
/// A Flutter library that provides a customizable Apple Pay button widget,
/// built on top of the `pay` package to handle Apple Pay integrations.
///
/// Exports:
/// - All `pay` package features (except `ApplePayButton`)
/// - Includes a `part` for internal widget implementation.
///
/// Author: Your Name or Company Name
/// License: MIT / Apache / Proprietary (choose one if needed)
/// Copyright © 2025 Your Name. All rights reserved.
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
