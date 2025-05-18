

import 'package:customer_frontend/data/services/customer_service.dart';
class CustomerRepository {
  CustomerRepository({required CustomerService customerService})
    : _customerService = customerService;

  final CustomerService _customerService;

  
  // Future<TasksListModel> getAllTasks(String sessionToken) async {
  //   try {
  //     final raw = await _employeeService.getAllTasks(sessionToken);
  //     final list = TasksListModel.fromJson(raw);
  //     return list;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //  Future<AppraisalsListModel> getAllAppraisals(String employeeID,String sessionToken) async {
  //   try {
  //     final raw = await _employeeService.getAllAppraisals(employeeID,sessionToken);
  //     final list = AppraisalsListModel.fromJson(raw);
  //     return list;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }


  // Future<CitationsListModel> getAllCitations(String employeeID,String sessionToken) async {
  //   try {
  //     final raw = await _employeeService.getAllCitations(employeeID,sessionToken);
  //     final list = CitationsListModel.fromJson(raw);
  //     return list;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  

 
}
