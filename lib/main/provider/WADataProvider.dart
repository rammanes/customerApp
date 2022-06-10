

import 'package:klik/main/models/WAModel.dart';

List<Transactions> getTransactions(){
  List<Transactions> transList = [];

  transList.add(Transactions(amount: 2000.00, date: 'Today at 23:02:20', status: "Successful", location: "Ejule Community", transType: "Credit"));
  transList.add(Transactions(amount: 5000.00, date: 'Today at 23:02:20', status: "Failed", location: "Ejule Community", transType: "Credit"));
  transList.add(Transactions(amount: 7000.00, date: 'Today at 23:02:20', status: "Successful", location: "Ejule Community", transType: "Debit"));
  transList.add(Transactions(amount: 1000.00, date: 'Today at 23:02:20', status: "Failed", location: "Ejule Community", transType: "Credit"));
  transList.add(Transactions(amount: 2000.00, date: 'Today at 23:02:20', status: "Successful", location: "Ejule Community", transType: "Debit"));
  transList.add(Transactions(amount: 2000.00, date: 'Today at 23:02:20', status: "Failed", location: "Ejule Community", transType: "Credit"));
  transList.add(Transactions(amount: 2000.00, date: 'Today at 23:02:20', status: "Successful", location: "Ejule Community", transType: "Credit"));
  transList.add(Transactions(amount: 2000.00, date: 'Today at 23:02:20', status: "Failed", location: "Ejule Community", transType: "Credit"));

  return transList;
}