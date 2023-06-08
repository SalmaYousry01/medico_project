class BloodType {
  static String A_plus_Id = "A+";
  static String A_minus_Id = "A-";
  static String B_plus_Id = "B+";
  static String B_minus_Id = "B-";
  static String C_plus_Id = "C+";
  static String C_minus_Id = "C-";
  static String O_plus_Id = "O+";
  static String O_minus_Id = "O-";

  String id;
  late String name;

  BloodType(this.id, this.name);

  BloodType.fromId(this.id) {
    name = id;
  }

  static List<BloodType> getCategories() {
    return [
      BloodType.fromId(A_plus_Id),
      BloodType.fromId(A_minus_Id),
      BloodType.fromId(B_plus_Id),
      BloodType.fromId(B_minus_Id),
      BloodType.fromId(C_plus_Id),
      BloodType.fromId(C_minus_Id),
      BloodType.fromId(O_plus_Id),
      BloodType.fromId(O_minus_Id),
    ];
  }
}
