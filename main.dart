import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

var request = Uri.https('api.hgbrasil.com', '/finance');

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String ibovespaNome = "";
  String ibovespaLocal = "";
  String ibovespaPontos = "";
  String ibovespaVariacao = "";

  String nasdaqNome = "";
  String nasdaqLocal = "";
  String nasdaqPontos = "";
  String nasdaqVariacao = "";

  String nikkeiNome = "";
  String nikkeiLocal = "";
  String nikkeiVariacao = "";

  String cacNome = "";
  String cacLocal = "";
  String cacVariacao = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bolsa de Valores no Mundo"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),

      body: FutureBuilder<Map>(
        future: pegarDados(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none: 
            case ConnectionState.waiting:
            return Center(
              child: 
              Text(
                "Carregando Dados...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25),
              ),
            );
            default: 
              if(snapshot.hasError){
                return Center(
                  child: 
                  Text("Erro ao carregar os dados!",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center
                  ),
                );
              } else {
                ibovespaNome = snapshot.data!['results']['stocks']['IBOVESPA']['name'].toString();
                ibovespaLocal = snapshot.data!['results']['stocks']['IBOVESPA']['location'].toString();
                ibovespaPontos = snapshot.data!['results']['stocks']['IBOVESPA']['points'].toString();
                ibovespaVariacao = snapshot.data!['results']['stocks']['IBOVESPA']['variation'].toString();

                nasdaqNome = snapshot.data!['results']['stocks']['NASDAQ']['name'].toString();
                nasdaqLocal = snapshot.data!['results']['stocks']['NASDAQ']['location'].toString();
                nasdaqPontos = snapshot.data!['results']['stocks']['NASDAQ']['points'].toString();
                nasdaqVariacao = snapshot.data!['results']['stocks']['NASDAQ']['variation'].toString();

                nikkeiNome = snapshot.data!['results']['stocks']['NIKKEI']['name'].toString();
                nikkeiLocal = snapshot.data!['results']['stocks']['NIKKEI']['location'].toString();
                nikkeiVariacao = snapshot.data!['results']['stocks']['NIKKEI']['variation'].toString();

                cacNome = snapshot.data!['results']['stocks']['CAC']['name'].toString();
                cacLocal = snapshot.data!['results']['stocks']['CAC']['location'].toString();
                cacVariacao = snapshot.data!['results']['stocks']['CAC']['variation'].toString();

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('images/bolsa.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                      ),
                      Divider(),
                      Text(ibovespaNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(ibovespaLocal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(ibovespaPontos,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(ibovespaVariacao,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),)
                    ],
                  ),
                );
              }
          }
        }
      )
    );
  }

  Future<Map> pegarDados() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }
}