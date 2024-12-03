import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConsultaPorNombreScreen extends StatefulWidget {
  @override
  _ConsultaPorNombreScreenState createState() =>
      _ConsultaPorNombreScreenState();
}

class _ConsultaPorNombreScreenState extends State<ConsultaPorNombreScreen> {
  TextEditingController nameController = TextEditingController();
  Map<String, dynamic>? countryData;

  Future<void> fetchCountryByName(String name) async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/name/$name'));
    if (response.statusCode == 200) {
      setState(() {
        countryData = jsonDecode(response.body)[0];
      });
    } else {
      setState(() {
        countryData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar por Nombre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del País',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                fetchCountryByName(nameController.text.trim());
              },
              child: Text('Buscar'),
            ),
            SizedBox(height: 20),
            countryData != null
                ? Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nombre: ${countryData!['name']['common']}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Región: ${countryData!['region']}'),
                          Text('Población: ${countryData!['population']}'),
                          Text(
                              'Capital: ${countryData!['capital']?[0] ?? 'N/A'}'),
                        ],
                      ),
                    ),
                  )
                : Text('No se encontró información',
                    style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
