import 'package:flutter/material.dart';
import 'package:network_demo/models/employee_model.dart';
import 'package:network_demo/services/http_service.dart';

class HomePage extends StatefulWidget {

  static final String  id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String data;
  List<String> text = ['Get all employee data', 'Get a single employee data', 'Create new record in database', 'Update an employee record', 'Delete an employee record'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var employee = Employee(id: 21, profile_image: '', employee_age: '21', employee_name: 'Nasibali', employee_salary: '1000');
    _apiEmployeeDelete(employee);

  }

  void _apiEmployeeList() {
    Network.GET(Network.API_ALL_EMPLOYEES, Network.paramsEmpty()).then((response) => {
      print(response),
      _showData(response)
    });
  }

  void _apiEmployeeSingle(Employee employee) {
    Network.GET(Network.API_SINGLE_EMPLOYEE + employee.id.toString(), Network.paramsEmpty()).then((response) => {
      print(response),
      _showData(response)
    });
  }


  void _apiEmployeeCreate(Employee employee) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(employee)).then((response) => {
      print(response),
      _showData(response)
    });
  }

  void _apiEmployeeUpdate(Employee employee) {
    Network.PUT(Network.API_UPDATE + employee.id.toString(), Network.paramsUpdate(employee)).then((response) => {
      print(response),
      _showData(response)
    });
  }

  void _apiEmployeeDelete(Employee employee) {
    Network.DEL(Network.API_DELETE + employee.id.toString(), Network.paramsEmpty()).then((response) => {
      print(response),
      _showData(response)
    });
  }

  void _showData(String response) {
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text[4], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SingleChildScrollView(child: Text(data != null ? data : 'No Data')),
          ],
        ),
      ),
    );
  }
}
