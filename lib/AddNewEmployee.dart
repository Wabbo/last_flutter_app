import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'EmployeeM.dart';
import 'EmployeeModel.dart';

class AddNewEmployee extends StatefulWidget {
  @override
  _AddNewEmployeeStat createState() => _AddNewEmployeeStat();
}

class _AddNewEmployeeStat extends State<AddNewEmployee> {
  final name = TextEditingController();
  final age = TextEditingController();

  Future<EmployeeM> request() async {
    String API = "http://dummy.restapiexample.com/api/v1/create";
    Dio dio = new Dio();
    Response response = await dio
        .post(API, data: {"name": "${name.text}", "age": "${age.text}"});

    EmployeeM employee = new EmployeeM(
        (response.data["data"])["id"].toString() ?? "",
        (response.data["data"])["name"] ?? "",
        (response.data["data"])["salary"] ?? "250",
        (response.data["data"])["age"] ?? "",
        "");
    print("data -> ${response.data} / emp ->${employee.employeeName}");
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Add Employee',
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: 'Employee Name')),
                TextField(
                    controller: age,
                    decoration: InputDecoration(hintText: 'Employee Age')),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ScopedModel<EmployeeModel>(
              model: EmployeeModel.shared,
              child: new Container(child:
                  new ScopedModelDescendant<EmployeeModel>(
                      builder: (context, child, model) {
                return RaisedButton(
                  onPressed: () {
                    request().then((e) {
                      model.addEmployee(e);
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              })))
        ],
      ),
    );
  }
}
