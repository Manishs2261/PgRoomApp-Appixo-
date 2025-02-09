enum Environment{dev,uat,prod}

abstract class AppEnvironment{

  static late String baseUrl;
  static late String environmentName;

  static late Environment _environment;
  static Environment get environment => _environment;

  static setUpEnv(Environment environment){
    _environment = environment;

    switch(environment){
      case Environment.dev:
        baseUrl = 'https://dev.com';
        environmentName = 'dev';
        break;
      case Environment.uat:
        baseUrl = 'https://uat.com';
        environmentName = 'uat';
        break;
      case Environment.prod:
        baseUrl = 'https://prod.com';
        environmentName = 'prod';
        break;
    }
  }

}