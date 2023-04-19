import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma page à trois colonnes'),
      ),
      body: Row(
        children: [
          FractionallySizedBox(
            widthFactor: 0.2,
            child: Container(
              color: Colors.blue, // couleur de fond de la colonne de gauche
              child: Column(
                children: [
                  // Mettez ici le contenu de la colonne de gauche
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.45,
            child: Container(
              color: Colors.green, // couleur de fond de la colonne du centre
              child: Column(
                children: [
                  // Mettez ici le contenu de la colonne du centre
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.35,
            child: Container(
              color: Colors.orange, // couleur de fond de la colonne de droite
              child: Column(
                children: [
                  // Mettez ici le contenu de la colonne de droite
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
