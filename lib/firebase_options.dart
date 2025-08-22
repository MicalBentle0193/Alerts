import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyCRk84FmHDHP01VMAAYI7B4y2-X3Xh2Trk',
      appId: '1:337470919030:ios:e341149f19060353f5aa57',
      messagingSenderId: '337470919030',
      projectId: 'wynford-weather-alerts',
      authDomain: 'wynford-weather-alerts.firebaseapp.com', // Optional
    );
  }
}
