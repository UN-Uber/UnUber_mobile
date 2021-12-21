# unuber_mobile

Este repositiorio contiene la solución móvil de UnUber.

## Vesión actual
0.0.1

## Arquitectura (MVVM)
La arquitectura del proyecto está basada en una arquitectura de referencia propuesta por la comunidad de flutter. Dicha arquitectura lleva por nombre **stacked**. Para más información [click aquí]{https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/}

## Modo de uso
### Actualización o inclusión de una nueva ruta**
- Agregar una View en a carpeta `ui/views`
- Agregar un ViewModel en la carpeta `ui/views`
- Referenciar la nueva vista en el archivo `router.dart`
- Ejecutar el comando:
```
flutter pub run build_runner build
```

### Actualización de imports
- Se está haciendo uso de un paquete que automaticamente ordena los imports, para más información [click aquí]{https://pub.dev/packages/import_sorter}
- Antes de enviar un Pull Request se debe actualizar las rutas ejecutando el siguiente comando:
```
flutter pub run impor_sorter:main
```
