// import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// implementation with internet_connection_checker package
// TODO: implement with connectivity_plus package
// class NetworkInfoImpl implements NetworkInfo {
//   // final InternetConnectionChecker connectionChecker;

//   //   NetworkInfoImpl({required this.connectionChecker});

//   // @override
//   // Future<bool> get isConnected async => await connectionChecker.hasConnection;

//   @override
//   Future<bool> get isConnected async => true;
// }
class NetworkInfoImpl implements NetworkInfo {
  // final InternetConnectionChecker connectionChecker;

  //   NetworkInfoImpl({required this.connectionChecker});

  // @override
  // Future<bool> get isConnected async => await connectionChecker.hasConnection;

  @override
  Future<bool> get isConnected async => true;
}
