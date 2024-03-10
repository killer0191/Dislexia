import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageModel {
  final String imagePath;
  final String id;

  ImageModel(this.imagePath, this.id);
}

class VocabularioPage extends StatefulWidget {
  @override
  _VocabularioPageState createState() => _VocabularioPageState();
}

class _VocabularioPageState extends State<VocabularioPage> {
  final List<ImageModel> _images = [
    ImageModel('assets/cabello.png', 'cabello'),
    ImageModel('assets/gato.png', 'gato'),
    ImageModel('assets/naranja.jpg', 'naranja'),
    ImageModel('assets/niño.png', 'niño'),
    ImageModel('assets/perro.png', 'perro'),
  ];

  ImageModel? _selectedImage;

  List<ImageModel> _imagesList = [];

  @override
  void initState() {
    super.initState();
    _imagesList = _generateImagesList();
  }

  List<ImageModel> _generateImagesList() {
    List<ImageModel> duplicatedImages = [];
    for (int i = 0; i < _images.length; i++) {
      duplicatedImages.add(_images[i]);
      duplicatedImages.add(ImageModel(_images[i].imagePath,
          '${_images[i].id}2')); // Agregar la segunda imagen con un id único
    }
    duplicatedImages
        .shuffle(); // Mezclar la lista para obtener una distribución aleatoria
    return duplicatedImages;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Vocabulario'),
        leading: IconButton(
          icon: Image.asset('assets/regresar.png'),
          onPressed: () {
            Navigator.pop(context);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          },
        ),
      ),
      backgroundColor: const Color(0xFF7CD164),
      body: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        children: List.generate(_imagesList.length, (index) {
          final image = _imagesList[index];
          return GestureDetector(
            onTap: () {
              _handleImageSelection(image);
            },
            child: Center(
              child: Container(
                width: 150.0,
                height: 150.0,
                padding: const EdgeInsets.all(8.0),
                color: _selectedImage == image
                    ? const Color(0xFF2EB8AC)
                    : Colors.white,
                child: Image.asset(
                  image.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _handleImageSelection(ImageModel image) {
    setState(() {
      if (_selectedImage == null) {
        _selectedImage = image;
      } else {
        if ((_selectedImage!.id.endsWith('2') &&
                _selectedImage!.id
                        .substring(0, _selectedImage!.id.length - 1) ==
                    image.id) ||
            (image.id.endsWith('2') &&
                image.id.substring(0, image.id.length - 1) ==
                    _selectedImage!.id)) {
          _showCongratulationsDialog();
        }
        _selectedImage = null;
      }
    });
  }

  void _showCongratulationsDialog() {
    ImageModel? selectedImageCopy = _selectedImage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (selectedImageCopy != null) {
          // Obtener el nombre de la imagen solo si selectedImageCopy no es nulo
          String imageName = _getImageName(selectedImageCopy.id);

          return AlertDialog(
            title: Text('¡Felicidades!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  selectedImageCopy.imagePath,
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 10),
                Text(imageName),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        } else {
          // Si selectedImageCopy es nulo, mostrar un AlertDialog básico
          return AlertDialog(
            title: Text('¡Felicidades!'),
            content: Text('Has encontrado un par de imágenes iguales.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        }
      },
    );
  }

// Función auxiliar para obtener el nombre de la imagen
  String _getImageName(String id) {
    // Verificar si el id termina con '2' y eliminarlo si es así
    if (id.endsWith('2')) {
      id = id.substring(0, id.length - 1);
    }
    // Convertir la primera letra a mayúscula y el resto a minúsculas
    return id.substring(0, 1).toUpperCase() + id.substring(1);
  }
}
