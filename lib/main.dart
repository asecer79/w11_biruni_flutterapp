import 'package:flutter/material.dart';
import 'package:w11_biruni_flutterapp/dbcontext.dart';
import 'package:w11_biruni_flutterapp/department.dart';
import 'package:w11_biruni_flutterapp/departmentmanagerpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // var db = await DbContext.initialize();

  // print(db.isOpen);

  // await DbContext.insertDepartment(Department(departmentname: "Software eng."));

  // print((await DbContext.getDepartments()).length);

  //print((await DbContext.getDepartment(2)).departmentname);

//   print((await DbContext.getDepartments()).length);
// await DbContext.deleteDepartment(2);
//    print((await DbContext.getDepartments()).length);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: DbContext.getDepartments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(data[index].id.toString(),
                          style: TextStyle(fontSize: 20)),
                      SizedBox(width: 15),
                      Text(data[index].departmentname.toString(),
                          style: TextStyle(fontSize: 20)),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit,
                                  color: Colors.blue, size: 20)),
                          IconButton(
                              onPressed: () async {
                                await DbContext.deleteDepartment(
                                    data[index].id!);

                                setState(() {});
                              },
                              icon: Icon(Icons.delete,
                                  color: Colors.red, size: 20)),
                        ],
                      )
                    ],
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text("Loading"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DepartmentManagerPage();
          }));
        },
        tooltip: 'Add new',
        child: const Icon(Icons.add),
      ),
    );
  }
}
