# scanner

Scanner project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


    flutter pub global run rename --bundleId com.fsa.qrscanner
    flutter pub global run rename --appname "QR Scanner FSA"


1. icon, app name, appID

2.create a key.properties file under android
keytool -genkey -v -keystore C:\Users\mesha\Desktop\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
add the file to android folder => app folder
add the path to store file

3. sign application and create app bundle
    add the def functions ontop of android
    add and replace the build class
4. flutter build appbundle

Note: C:\Users\mesha\AppData\Local\Pub\Cache\hosted\pub.dev\esys_flutter_share_plus-2.2.0\android\src\main\java\de\esys\esysfluttershare\EsysFlutterSharePlugin.j
ava uses unchecked or unsafe operations.
