enum UserTypeEnum {
  patient('patient'),
  doctor('doctor');

  final String name;
  UserTypeEnum(this.name);

  static UserTypeEnum fromString(String value) {
    for (var type in UserTypeEnum.values) {
      if (type.name == value) {
        return type;
      }
    }
    return UserTypeEnum.patient;
  }
}


// UserTypeEnum.patient.name = patient;
