const String FIRSTNAME = 'firstname';
const String LASTNAME = 'lastname';
const String EMAIL = 'email';
const String MOBILE = 'mobile';
const String PASSWORD = 'password';
const String DOB = 'dob';
const String GENDER = 'gender';
const String CITY = 'city';
const String HOBBIES = 'hobbies';

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printResultText(String text) {
  print('\x1B[31m$text\x1B[0m');
}
