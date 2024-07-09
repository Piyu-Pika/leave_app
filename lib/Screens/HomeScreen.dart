import 'package:flutter/material.dart';
import 'LeaveForm.dart';

void main() => runApp(LeaveApplication());

class LeaveApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leave Application',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LeaveApplicationData> applications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade200, Colors.teal.shade50],
          ),
        ),
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                child: applications.isEmpty
                    ? const Center(child: Text('No applications yet'))
                    : ListView.builder(
                        itemCount: applications.length,
                        itemBuilder: (context, index) {
                          final app = applications[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            color: Colors.greenAccent,
                            child: ListTile(
                              title: Text(app.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Reason: ${app.reason}'),
                                  Text(
                                      'From: ${app.startDate.toString().split(' ')[0]}'),
                                  Text(
                                      'To: ${app.endDate.toString().split(' ')[0]}'),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: const Text('Apply for Leave'),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaveForm()),
                    );
                    if (result != null) {
                      setState(() {
                        applications.add(result);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
