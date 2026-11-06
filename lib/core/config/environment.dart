class Environment {
  // En Android Emulator, localhost es 10.0.2.2. En iOS es 127.0.0.1.
  // Cuando despliegues el backend a Azure, cambia esto por tu URL de App Service:
  // static const String apiUrl = 'https://tu-app-service.azurewebsites.net/api';
  static const String apiUrl =
      'https://appserviciosgeneralesbackend-eta6buawbdfzbqgp.westus3-01.azurewebsites.net/api'; // Ajusta el puerto según tu Kestrel
}
