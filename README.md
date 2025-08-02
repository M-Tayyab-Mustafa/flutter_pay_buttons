# Apple Pay Flutter Plugin

A Flutter plugin that adds Apple Pay support using the [`pay`](https://pub.dev/packages/pay) package under the hood. This plugin provides a customizable Apple Pay button and simplifies the integration process.

## Features

- Custom Apple Pay button with styling options
- Uses the reliable `pay` package for handling payment requests
- Easy to integrate in your existing Flutter app

## Getting Started

Before you begin, ensure the following:

- You're developing on a macOS system (Apple Pay is only available on iOS/macOS).
- Your app has the necessary entitlements and configuration for Apple Pay.
- You’ve set up Apple Merchant ID and certificates in your Apple Developer account.

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  apple_pay:
    git:
      url: 
