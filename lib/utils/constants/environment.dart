enum Environment { dev, main }

extension EnvironmentEx on Environment {
  String get url {
    switch (this) {
      case Environment.dev:
        return 'http://10.0.2.2:8080/api';
      case Environment.main:
        return 'http://10.0.2.2:8080/api';
    }
  }

  String get urlDevice {
    switch (this) {
      case Environment.dev:
        return 'http://localhost:8080/api';
      case Environment.main:
        return 'http://localhost:8080/api';
    }
  }

  String get socket {
    switch (this) {
      case Environment.dev:
        return 'ws://';
      case Environment.main:
        return 'ws://';
    }
  }
}
