import 'package:example/routes.dart';
import 'package:example/service.dart';
import 'package:meta/meta.dart';
import 'package:observable_state/observable_state.dart';

enum Changes {
  increment,
}

class User {
  User({
    @required uid,
    String email,
  })  : _uid = uid,
        _email = email;

  int _uid;
  int get uid => _uid;

  String _email;
  String get email => _email;
}

class AppState extends Observable<AppState, Changes> {
  AppState({@required this.service});

  final Service service;

  int _counter = 0;

  int get counter => _counter;

  String _initialRoute;
  String get initialRoute => _initialRoute;

  User _user;
  User get user => _user;

  Future<void> initState() async {
    _user = await service.currentUser();

    print(_user);

    _initialRoute = _user == null ? routeNameLogin : routeNameHome;
  }

  void increment() {
    setState(() => _counter++, notify: Changes.increment);
  }

  Future<User> login(String email, String password) {
    return service.login(email, password);
  }
}
