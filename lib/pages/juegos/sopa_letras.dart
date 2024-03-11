import 'dart:math';

import 'package:dislexia/pages/juegos.dart';
import 'package:flutter/material.dart';

class SopaLetrasPage extends StatefulWidget {
  final List<String> palabras = [
    'uno',
    'dos',
    'tres',
    'cuatro',
    'cinco',
    'seis',
    'siete',
    'ocho'
  ];
  final int numRows = 8;
  final int numColumns = 8;

  @override
  _SopaLetrasPageState createState() => _SopaLetrasPageState();
}

class _SopaLetrasPageState extends State<SopaLetrasPage> {
  late List<String> letras;
  late List<List<bool>> selectedCells;
  List<List<bool>>? selectedWordCells;
  List<List<List<bool>>> foundWords = [];

  @override
  void initState() {
    super.initState();
    letras = _generateSopaLetras();
    selectedCells = List.generate(
      widget.numRows,
      (_) => List.generate(widget.numColumns, (_) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/regresar.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xff7cd164),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Sopa de letras',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Selecciona las palabras de la lista',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.numColumns,
                  ),
                  itemCount: widget.numRows * widget.numColumns,
                  itemBuilder: (context, index) {
                    int rowIndex = index ~/ widget.numColumns;
                    int colIndex = index % widget.numColumns;
                    return GestureDetector(
                      onTap: () => _selectLetter(rowIndex, colIndex),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: _getCellColor(rowIndex, colIndex),
                        ),
                        child: Container(
                          color: _getOverlayColor(rowIndex, colIndex),
                          child: Text(
                            letras[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 60, // Altura fija para la lista de palabras
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.palabras.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE84B2C), // Color de fondo
                      borderRadius: BorderRadius.circular(20), // Bordes curvos
                    ),
                    child: Text(
                      widget.palabras[index],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Color de texto blanco
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getOverlayColor(int rowIndex, int colIndex) {
    for (var wordCells in foundWords) {
      if (wordCells[rowIndex][colIndex]) {
        return Colors
            .yellow; // Amarillo cuando la letra es parte de una palabra correcta
      }
    }
    return Colors.transparent; // Transparente por defecto
  }

  Color _getCellColor(int rowIndex, int colIndex) {
    if (selectedCells[rowIndex][colIndex]) {
      return const Color(0xFF2EB8AC); // Verde cuando se selecciona la letra
    } else if (selectedWordCells != null &&
        selectedWordCells![rowIndex][colIndex]) {
      return Colors
          .yellow; // Amarillo cuando la letra es parte de una palabra correcta
    } else {
      return Colors.white; // Blanco por defecto
    }
  }

  void _selectLetter(int rowIndex, int colIndex) {
    setState(() {
      // Verificar si la celda ya está seleccionada
      if (selectedCells[rowIndex][colIndex]) {
        // Desmarcar la celda si ya está seleccionada
        selectedCells[rowIndex][colIndex] = false;
      } else {
        // Verificar si ya se han seleccionado 8 letras
        int selectedCount = _getSelectedCount();
        if (selectedCount >= 8) {
          // Si ya se seleccionaron 8 letras, no hacer nada
          return;
        }

        // Marcar la celda como seleccionada
        selectedCells[rowIndex][colIndex] = true;

        // Verificar si se ha formado una palabra
        _checkForWord();

        // Verificar si la palabra formada es válida
        if (selectedCount >= 5 && selectedWordCells == null) {
          // Si no se ha formado una palabra válida, desmarcar todas las celdas
          _clearSelection();
        }
      }
    });
  }

  void _checkForWord() {
    List<List<bool>> tempSelectedCells = List.generate(
        widget.numRows, (_) => List.generate(widget.numColumns, (_) => false));
    for (int i = 0; i < widget.numRows; i++) {
      for (int j = 0; j < widget.numColumns; j++) {
        if (selectedCells[i][j]) {
          tempSelectedCells[i][j] = true;
        }
      }
    }

    // Aquí puedes agregar la lógica para verificar si las letras seleccionadas forman una palabra
    bool foundWord = _checkForValidWord(tempSelectedCells);
    if (foundWord) {
      foundWords.add(tempSelectedCells);
      _showWordFoundDialog();
      setState(() {
        selectedCells = List.generate(widget.numRows,
            (_) => List.generate(widget.numColumns, (_) => false));
      });

      // Verificar si todas las palabras han sido encontradas
      if (foundWords.length == widget.palabras.length) {
        _showCongratulationsDialog();
      }
    }
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¡Felicidades!'),
          content: Text('¡Todas las palabras fueron encontradas!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JuegosPage(),
                  ),
                );
              },
              child: Text('Regresar'),
            ),
          ],
        );
      },
    );
  }

  bool _checkForValidWord(List<List<bool>> selectedCells) {
    // Convertir la lista de celdas seleccionadas en una lista de letras seleccionadas
    List<String> selectedLetters = [];
    for (int i = 0; i < widget.numRows; i++) {
      for (int j = 0; j < widget.numColumns; j++) {
        if (selectedCells[i][j]) {
          selectedLetters.add(letras[i * widget.numColumns + j]);
        }
      }
    }
    // Convertir las palabras de la lista de palabras a mayúsculas
    List<String> palabrasMayusculas =
        widget.palabras.map((palabra) => palabra.toUpperCase()).toList();
    // Verificar si la combinación de letras seleccionadas forma exactamente una de las palabras de la lista
    String selectedWord = selectedLetters.join('');
    return palabrasMayusculas.contains(selectedWord);
  }

  List<String> _generateSopaLetras() {
    List<String> sopaLetras =
        List.filled(widget.numRows * widget.numColumns, '');
    Random random = Random();
    // Colocar palabras en la sopa de letras
    widget.palabras.forEach((palabra) {
      bool inserted = false;
      while (!inserted) {
        int row = random.nextInt(widget.numRows);
        int col = random.nextInt(widget.numColumns);
        bool horizontal = random.nextBool();
        if (_canInsertWord(row, col, palabra.length, horizontal, sopaLetras)) {
          _insertWord(row, col, palabra, horizontal, sopaLetras);
          inserted = true;
        }
      }
    });
    // Llenar el resto de la sopa de letras con letras aleatorias
    for (int i = 0; i < sopaLetras.length; i++) {
      if (sopaLetras[i] == '') {
        sopaLetras[i] = _getRandomLetter(random);
      }
    }
    return sopaLetras;
  }

  bool _canInsertWord(
      int row, int col, int length, bool horizontal, List<String> sopaLetras) {
    if (horizontal) {
      if (col + length > widget.numColumns) return false;
      for (int i = 0; i < length; i++) {
        if (sopaLetras[row * widget.numColumns + col + i] != '') return false;
      }
    } else {
      if (row + length > widget.numRows) return false;
      for (int i = 0; i < length; i++) {
        if (sopaLetras[(row + i) * widget.numColumns + col] != '') return false;
      }
    }
    return true;
  }

  void _insertWord(
      int row, int col, String word, bool horizontal, List<String> sopaLetras) {
    if (horizontal) {
      for (int i = 0; i < word.length; i++) {
        sopaLetras[row * widget.numColumns + col + i] = word[i].toUpperCase();
      }
    } else {
      for (int i = 0; i < word.length; i++) {
        sopaLetras[(row + i) * widget.numColumns + col] = word[i].toUpperCase();
      }
    }
  }

  String _getRandomLetter(Random random) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return letters[random.nextInt(letters.length)];
  }

  void _showWordFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Palabra encontrada'),
          content: Text('¡Has encontrado una palabra!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  int _getSelectedCount() {
    int count = 0;
    for (var row in selectedCells) {
      for (var cell in row) {
        if (cell) {
          count++;
        }
      }
    }
    return count;
  }

  void _clearSelection() {
    setState(() {
      selectedCells = List.generate(widget.numRows,
          (_) => List.generate(widget.numColumns, (_) => false));
    });
  }
}
