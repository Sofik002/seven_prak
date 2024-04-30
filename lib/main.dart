import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.amber,
  ),
  home: const UserPanel(),
));

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("7 практическая работа"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[200],
      ),
      body:  SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children:[
                const Padding(padding: EdgeInsets.only(top: 40),),
                ElevatedButton(child: const Text("ListView.builder"),onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const Home()));},),
                const Padding(padding: EdgeInsets.only(top: 40),),
                ElevatedButton(child: const Text("Column"),onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const NewWindow()));},),
                const Padding(padding: EdgeInsets.only(top: 40),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String vVod;
  List myList = [];

  Future<void> fetchData() {
    return Future.delayed(Duration(seconds: 15), () {
      myList.addAll(['почитать', 'помыть посуду', 'спорт']);
    });
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((value) {
      setState(() {}); // Обновляем состояние после загрузки данных
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[200],
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(myList[index]),
            child: Card(
              child: ListTile(
                title: Text(myList[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.blueGrey[200]),
                  onPressed: () {
                    setState(() {
                      myList.removeAt(index);
                    });
                  },
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                myList.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[200],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Добавить задачу'),
                content: TextField(
                  onChanged: (String value) {
                    vVod = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        myList.add(vVod);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить'),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add_box, color: Colors.blueGrey.shade200),
      ),
    );
  }
}

class NewWindow extends StatefulWidget {
  const NewWindow({Key? key});

  @override
  State<NewWindow> createState() => _NewWindowState();
}

class _NewWindowState extends State<NewWindow> {
  late String type;
  List newMyList = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      setState(() {
        // Данные уже будут загружены через 15 секунд
      });
    });
  }

  Future<void> fetchData() async {
    return Future.delayed(Duration(seconds: 15), () {
      newMyList.addAll(['почитать', 'помыть посуду', 'спорт']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[200],
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: newMyList.map((item) => GestureDetector(
                key: ValueKey(item),
                onTap: () => setState(() => newMyList.remove(item)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(item),
                ),
              )).toList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[200],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Добавить задачу'),
                content: TextField(
                  onChanged: (String value) {
                    type = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        newMyList.add(type);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add_box, color: Colors.blueGrey.shade200),
      ),
    );
  }
}



