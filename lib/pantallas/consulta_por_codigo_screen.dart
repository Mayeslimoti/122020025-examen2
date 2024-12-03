import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/country_model.dart';
import '../constantes/api_constants.dart';

class ConsultaPorCodigoScreen extends StatefulWidget {
  @override
  _ConsultaPorCodigoScreenState createState() =>
      _ConsultaPorCodigoScreenState();
}

class _ConsultaPorCodigoScreenState extends State<ConsultaPorCodigoScreen> {
  TextEditingController codeController = TextEditingController();
  Country? country;

  Future<void> fetchCountryByCode(String code) async {
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.codeEndpoint}$code'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        country = Country.fromJson(data);
      });
    } else {
      setState(() {
        country = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta por Código')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Código del País'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchCountryByCode(codeController.text.toUpperCase());
              },
              child: Text('Buscar'),
            ),
            if (country != null) ...[
              Text('Nombre: ${country!.name}'),
              Text('Nombre Oficial: ${country!.officialName}'),
              Text('TLD: ${country!.tld}'),
              Text('CCA2: ${country!.cca2}'),
              Text('CCA3: ${country!.cca3}'),
              Text('CIOC: ${country!.cioc}'),
            ] else if (codeController.text.isNotEmpty) ...[
              Text('País no encontrado'),
            ]
          ],
        ),
      ),
    );
  }
}
