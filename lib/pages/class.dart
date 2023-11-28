import 'package:client/models/class_model.dart';
import 'package:client/models/department_model.dart';
import 'package:client/models/student_model.dart';
import 'package:client/pages/class_students.dart';
import 'package:client/pages/department.dart';
import 'package:client/pages/home.dart';
import 'package:client/services/class_service.dart';
import 'package:client/services/student_service.dart';
import 'package:client/services/department_service.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  Future<List<Class>> _classes = getAllClasses();
  Future<List<Student>> _students = getAllStudents();
  Future<List<Department>> _departments = getDepartments();


  void fetchClasses() async {
    setState(() {
      _classes = getAllClasses();
    });
  }
void addClass(Class classe) async {
    await createClass(classe);
    fetchClasses();
  }
  
  
  void fetchStudents() async {
    setState(() {
      _students = getAllStudents();
      _classes = getAllClasses();
      _departments = getDepartments();
    });

    List<Class> classes = await _classes;
    List<Department> departments = await _departments;

    setState(() {
      _selectedClass = classes.isNotEmpty ? classes.first : null;
      _updatedSelectedClass = classes.isNotEmpty ? classes.first : null;
    });
    setState(() {
      _selectedDep = departments.isNotEmpty ? departments.first : null;
      _updatedSelectedDep = departments.isNotEmpty ? departments.first : null;
    });
  }
  Class? _selectedClass;
  Class? _updatedSelectedClass;
  Department? _selectedDep;
  Department? _updatedSelectedDep;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberOfStudentsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color.fromARGB(255, 221, 66, 66),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF1E2432),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 66, 66),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Manage students'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              title: const Text('Manage classes'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ClassPage()));
              },
            ),
            ListTile(
              title: const Text('Manage departments'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DepartmentPage()));
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Manage classes',
                style: TextStyle(
                  color: Color(0xFF1E2432),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Add class'),
                            content: SizedBox(
                              width: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                    ),
                                  ),
                                  TextField(
                                    controller: _numberOfStudentsController,
                                    decoration: const InputDecoration(
                                      labelText: 'Number of students',
                                    ),
                                  ), FutureBuilder<List<Department>>(
                  future: _departments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField<Department>(
                        value: _selectedDep,
                        onChanged: (Department? newValue) {
                          setState(() {
                            _selectedDep = newValue!;
                          });
                        },
                        items: snapshot.data!.map((Department value) {
                          return DropdownMenuItem<Department>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select a Departement',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final Class classRoom = Class(
                                    name: _nameController.text,
                                    numberOfStudents: int.parse(
                                        _numberOfStudentsController.text),
                                        departmentSpace: _selectedDep,
                                  );
                                  

                                  addClass(classRoom);
                                  Navigator.pop(context);
                                  SnackBar snackBar = SnackBar(
                                    content:
                                        Text('${_nameController.text} added'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  fetchClasses();
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add class'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      fetchClasses();
                    },
                    child: const Text('Refresh'),
                  ),
                  
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Class>>(
                future: _classes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClassStudentsPage(
                                        classRoom: snapshot.data![index],
                                      )),
                            );
                          },
                          
                          title: Text(snapshot.data![index].name
                              .toString()
                              .toUpperCase()),
                          subtitle: Text(
                              'Number of students : ${snapshot.data![index].numberOfStudents}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteClass(snapshot.data![index].id!);
                                  SnackBar snackBar = SnackBar(
                                    content: Text(
                                        '${snapshot.data![index].name} deleted'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  fetchClasses();
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
