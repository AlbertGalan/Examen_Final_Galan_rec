import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  DetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalls Usuari')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user['id'] ?? 'Sense ID'}'),
            Text('Nom: ${user['nom'] ?? 'Sense nom'}'),
            Text('Descripcio: ${user['descripcio'] ?? 'Sense descripcio'}'),
            Text('Email: ${user['email'] ?? 'Sense email'}'),
            Text('Adreça: ${user['address'] ?? 'Sense Direcció'}'),
            SizedBox(height: 20),
            if (user['foto'] != null && user['foto'].isNotEmpty)
              Image.network(user['foto']), //Aqui li deim que empri el Widget Image per mostrar la foto
          ],
        ),
      ),
    );
  }
}