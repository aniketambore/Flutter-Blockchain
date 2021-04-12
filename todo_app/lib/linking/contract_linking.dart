import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  List<Task> todos = [];
  int taskCount = 0;
  bool isLoading = true;

  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey =
      "ea77ba3f64920aa24e484a96c6c77b9206d010e0ec07733446235d746a18ffd8";

  Web3Client _client;

  String _abiCode;
  EthereumAddress _contractAddress;
  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _createTask;
  ContractFunction _updateTask;
  ContractFunction _deleteTask;
  ContractFunction _readTask;
  ContractFunction _taskCount;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbis();
    await getCredentials();
    await getDeployedContract();
  }

  getAbis() async {
    String artifactString =
        await rootBundle.loadString("src/artifacts/Todo.json");
    var jsonFile = jsonDecode(artifactString);
    _abiCode = jsonEncode(jsonFile["abi"]);
    //print(_abiCode);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Todo"), _contractAddress);

    _taskCount = _contract.function("taskCount");
    _readTask = _contract.function("tasks");
    _createTask = _contract.function("createTask");
    _updateTask = _contract.function("updateTask");
    _deleteTask = _contract.function("deleteTask");

    getTodos();
  }

  getTodos() async {
    List totalTasksList = await _client
        .call(contract: _contract, function: _taskCount, params: []);
    BigInt totalTasks = totalTasksList[0];
    print(totalTasks);
    taskCount = totalTasks.toInt();
    todos.clear();

    for (var i = 0; i < taskCount; i++) {
      var allTasks = await _client.call(
          contract: _contract, function: _readTask, params: [BigInt.from(i)]);
      print(allTasks);
      todos.add(Task(
          id: allTasks[0],
          taskTitle: allTasks[1],
          taskDescription: allTasks[2]));
    }
    isLoading = false;
    notifyListeners();
  }

  createTasks(String title, String descp) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _createTask,
            parameters: [title, descp],
            maxGas: 1000000));
    getTodos();
  }

  updateTask(BigInt id, String head, String desc) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _updateTask,
            parameters: [id, head, desc],
            maxGas: 100000));
    getTodos();
  }

  deleteTask(BigInt id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _deleteTask, parameters: [id]));
    getTodos();
  }
}

class Task {
  BigInt id;
  String taskTitle;
  String taskDescription;

  Task({this.id, this.taskTitle, this.taskDescription});
}
