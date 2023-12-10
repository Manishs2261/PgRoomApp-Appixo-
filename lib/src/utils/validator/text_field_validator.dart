class EmailValidator {
  static String? validate(String? value) {
    return value==null ||  value.isEmpty ? "Email can't be empty" : null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Password can't be empty" : null;
  }
}

class AddressValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Address can't be empty" : null;
  }
}

class CityValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "City can't be empty" : null;
  }
}

class LandMarkValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Land Mark address can't be empty" :
    null;
  }
}

class ContactNumberValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Contact Number can't be empty" : null;
  }
}

class PriceValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Price can't be empty" : null;
  }
}

class OtpValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "OTP can't be empty" : null;
  }
}

class NameValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Name can't be empty" : null;
  }
}

class CommonUseValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Box can't be empty" : null;
  }
}