import 'package:http/http.dart' as http;
import 'package:task_flutter/helper/apiManager.dart';
import 'package:task_flutter/utils/constant.dart';

class HomeApi extends APIManager {
  final http.Client httpClient;

  HomeApi({
    required this.httpClient,
  });

  Future getItems() async {
    final url = Uri.parse(Constants.GetItems);
    final response = await getAPICall(url);
    return response;
  }

  Future getEmployees() async {
    final url = Uri.parse(Constants.GetEmployees);
    final response = await getAPICall(url);
    return response;
  }


  Future addItem(Map data) async {
    final url = Uri.parse(Constants.AddItems);
    final response = await postAPICall(url, body: data);
    return response;
  }
}
