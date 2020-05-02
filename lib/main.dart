import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  List<int> listItem = [1, 2, 3];
  bool isLoading = false;

  Future<void> _refresh() async {
    // ローディング
    setState(() {
      isLoading = true;
    });

    // 1秒待つ
    await Future.delayed(Duration(seconds: 1));

    // 新しいリストを代入
    setState(() {
      listItem = listItem.map((f) => f + 3).toList();
    });

    // 1秒待つ
    await Future.delayed(Duration(seconds: 1));

    // ロード終わり
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(title: Text('Dialog'),),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('${listItem[index]}'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('ok'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    }
                  );
                  await  _refresh();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MySecondScreen()));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child: Text('INDEX = ${listItem[index]}')),
                  ),
                ),
              );
            },
            itemCount: listItem.length,
          ),
        ),
        Visibility(
          visible: isLoading,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0x44000000),
            ),
            child: Center(child: const CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}

class MySecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dialog'),),
      body: Center(
        child: Text('Second Screen')
      ),
    );
  }
}
