import '../screens/login_screen.dart';
import '../screens/board_screen.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<LoginPage>(() => LoginPage());
    register<BoardScreen>(() => BoardScreen());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
