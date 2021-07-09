
# delivery_app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Steps:

Download the Project from Github and import to Android Studio.

Run Flutter doctor -v in terminal

[✓] Flutter (Channel stable, 2.2.2, on Linux, locale en_IN)
    • Flutter version 2.2.2 at /home/gopi/snap/flutter/common/flutter
    • Framework revision d79295af24 (4 weeks ago), 2021-06-11 08:56:01 -0700
    • Engine revision 91c9fc8fe0
    • Dart version 2.13.3

[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
    • Android SDK at /home/gopi/Android/Sdk
    • Platform android-30, build-tools 30.0.3
    • Java binary at: /home/gopi/Downloads/android-studio/jre/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6222593)
    • All Android licenses accepted.

[✓] Chrome - develop for the web
    • Chrome at google-chrome

[✓] Android Studio (version 4.1)
    • Android Studio at /home/gopi/Downloads/android-studio
    • Flutter plugin version 55.1.1
    • Dart plugin version 201.9380
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6222593)

[✓] VS Code (version 1.56.0)
    • VS Code at /usr/share/code
    • Flutter extension version 3.8.1

[✓] Connected device (2 available)
    • RMX1921 (mobile) • b1ffd5f8 • android-arm64  • Android 10 (API 29)
    • Chrome (web)     • chrome   • web-javascript • Google Chrome 90.0.4430.93

• No issues found!


- Make sure our version supports Null Safety.

- After importing we need to modify the Settings :

   Run  ---> Edit Configurations --->

     Additional Run Args : --no-sound-null-safety
