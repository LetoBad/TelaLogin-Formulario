import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetolista/model/pessoa.dart';
import 'package:projetolista/sextou.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App",
      home: Tela1(),
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  List<Pessoa> lista = [
    Pessoa(
        nome: "Thiago", idade: 22, sobrenome: "Torres", cpf: "000.000.000-00"),
    Pessoa(nome: "Leto", idade: 22, sobrenome: "Bad", cpf: "000.000.000-00"),
  ];

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();

  void removerItem(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }

  void openModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: [
                  Text(
                    "Ingrese los datos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                                    TextField(
                    controller: nomeController,
                    decoration: InputDecoration(label: Text("Nome")),
                  ),
                  TextField(
                    controller: sobrenomeController,
                    decoration: InputDecoration(label: Text("Sobrenome")),
                  ),
                  TextField(
                    controller: idadeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, // Permite apenas dígitos
                    ],
                    decoration: InputDecoration(
                      label: Text("Idade"),
                    ),
                  ),
                    TextField(
                    controller: cpfController,
                    decoration: InputDecoration(
                      label: Text("CPF"),
                    ),
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 66, 177, 32)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                      onPressed: () {
                        setState(() {
                          lista.add(Pessoa(
                              nome: nomeController.text,
                              idade: int.parse(idadeController.text),
                              sobrenome: sobrenomeController.text,
                              cpf: cpfController.text));
                        });
                        Navigator.pop(context);
                        nomeController.clear();
                        sobrenomeController.clear();
                        idadeController.clear();
                        cpfController.clear();
                      },
                      child: Text("Cadastrar")),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Lista para Widget",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 66, 177, 32),
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          //return Text(lista[index].nome);
          return Sextou(
            nome: lista[index].nome,
            sobrenome: lista[index].sobrenome,
            onRemove: () => removerItem(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal();
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 66, 177, 32),
      ),
    );
  }
}
