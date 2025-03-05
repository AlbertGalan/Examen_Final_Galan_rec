import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/services.dart';
import '../models/geo.dart';


class HomeScreen extends StatelessWidget {
  // Método para cerrar sesión
  
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<Service>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: userService.users.isEmpty
          ? Center(child: Text('No hi ha usuaris disponibles'))
          : ListView.builder(
              itemCount: userService.users.length,
              itemBuilder: (context, index) {
                final user = userService.users[index];
                return ListTile(
                  title: Text(user['nom'] ?? 'Sense Nom'),  //Li deim que només mostri es nom
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/userDetail',
                      arguments: user,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserDialog(context, userService);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context, Service userService) { //Aqui tenim un dialog que ens permet afegir un usuari
    final _idController = TextEditingController();
    final _nomController = TextEditingController();
    final _descripcioController = TextEditingController();
    final _emailController = TextEditingController();
    final _addressController = TextEditingController();
    final _photoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Afegir usuari'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'ID'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _descripcioController,
                  decoration: InputDecoration(labelText: 'Descripcio'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Adreça'),
                ),
                TextField(
                  controller: _photoController,
                  decoration: InputDecoration(labelText: 'URL de la foto'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel·lar'),
            ),
            TextButton(
              onPressed: () {
                final newUser = {
                  'id': _idController.text,
                  'nom': _nomController.text,
                  'descripcio': _descripcioController.text,
                  'email': _emailController.text,
                  'address': _addressController.text,
                  'photo': _photoController.text,
                };
                userService.createUser(newUser);
                userService.loadUsers();
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}