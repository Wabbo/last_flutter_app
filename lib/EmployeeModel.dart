import 'package:scoped_model/scoped_model.dart';
import 'package:dio/dio.dart';

import 'EmployeeM.dart';

class EmployeeModel extends Model{

  static EmployeeModel shared = new EmployeeModel();

  List<EmployeeM> employees;

  EmployeeModel(){
    employees = new List();
  }

  void addEmployee(EmployeeM employee){
    employees.add(employee);
    notifyListeners();
  }

  Future<List<EmployeeM>> fetch() async{
    String API = "http://dummy.restapiexample.com/api/v1/employees" ;
    List<EmployeeM> employees = new List<EmployeeM>();
    Dio dio = new Dio();
    Response response = await dio.get(API);
    var res = response.data;
    var allData = res["data"];
    employees = (allData as List).map((employee) => new EmployeeM.fromJson(employee)).toList();
    this.employees = employees;
    notifyListeners();
    return employees;
  }

}