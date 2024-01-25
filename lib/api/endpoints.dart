class Endpoints {
  static String baseUrl = Environment.currentEnv;
}

class Environment {
  static String prodEnv = 'https://jsonplaceholder.typicode.com/';
  static String devEnv = '';
  static String currentEnv = prodEnv;
}
