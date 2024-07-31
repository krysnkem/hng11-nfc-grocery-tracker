const emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[0-9])\w+");

String? Function(String?)? emailValidator = (String? val) {
  String validate = val!.replaceAll(RegExp(r"\s+"), "");
  if (validate.isEmpty ||
      !RegExp(emailRegex).hasMatch(validate)) {
    return 'Enter valid email';
  }
  return null; // Return null for valid input
};

String? Function(String?)? emptyValidator = (String? val) {
  String value = val??"";
  if(value.trim().isEmpty){
    return "Text field cannot be empty";
  }
  return null;
};

bool validateFullName(String input) {
  // Regular expression pattern
  RegExp regex = RegExp(r'^[A-Za-z]{2,}(?:\s[A-Za-z]{2,})+$');

  // Test the input against the pattern
  return regex.hasMatch(input);
}

bool validateName(String input) {
  // Regular expression pattern
  RegExp regex = RegExp(r"^[A-Z][a-zA-Z'_-]+$");
  // Test the input against the pattern
  return regex.hasMatch(input);
}

bool isEightDigitPhoneNumber(String input) {
  final RegExp regex = RegExp(r'^\d{11}$');
  return regex.hasMatch(input);
}

String? fullNameValidator(String? value) {
  if(value==null){
    return "Full name cannot be empty";
  }else if(!validateFullName(value)){
    return "Full Name not Valid";
  }
  return null;
}

String? nameValidator(String? value) {
  if(value==null){
    return "Full name cannot be empty";
  }else if(validateName(value)){
    return "Name not Valid";
  }
  return null;
}