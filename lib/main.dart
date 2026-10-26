import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const AtlantechApp());
}
