import 'package:flutter/material.dart';
import 'AddNewEmployee.dart';
import 'EmployeeM.dart';
import 'EmployeeModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewStat createState() => _EmployeeListViewStat();
}

class _EmployeeListViewStat extends State<EmployeeListView> {
  void initState() {
    // TODO: implement initState
    super.initState();
    EmployeeModel.shared.fetch();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees',
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
      body: Center(
          child: ScopedModel<EmployeeModel>(
              model: EmployeeModel.shared,
              child: new Container(child:
                  new ScopedModelDescendant<EmployeeModel>(
                      builder: (context, child, model) {
                return ListView.builder(
                    itemCount: model.employees.length,
                    itemBuilder: (context, index) {
                      EmployeeM employee =
                          EmployeeModel.shared.employees[index];
                      return new Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              child: Text(
                                ' ${employee.employeeName}\n',
                                style: TextStyle(fontSize: 25),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                ' Age : ${employee.employeeAge}',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              alignment: Alignment.centerLeft,
                            )
                          ],
                        ),
                      );
                    });
              })))),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNewEmployee()));
          },
          child: Icon(Icons.add)),
    );
  }
}
