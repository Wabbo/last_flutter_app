class EmployeeM{
  String id;
  String employeeName;
  String employeeAge;
  String employeeSalary;
  String profileImage;

  EmployeeM(this.id, this.employeeName, this.employeeSalary, this.employeeAge,
      this.profileImage);

  factory EmployeeM.fromJson(var json){
    return EmployeeM(json["id"],json["employee_name"],
        json["employee_salary"],json["employee_age"],json["profile_image"]);
  }
}