// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es_ES locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es_ES';

  static String m0(index) => "Línea ${index}";

  static String m1(line, channel) => "Línea ${line} reproduciendo: ${channel}";

  static String m2(code) => "Respuesta anormal ${code}";

  static String m3(version) => "Nueva Versión v${version}";

  static String m4(address) => "Dirección de Push: ${address}";

  static String m5(line) => "Cambiando a la línea ${line} ...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDataSource": MessageLookupByLibrary.simpleMessage(
            "Agregar Fuente de Suscripción"),
        "addFiledHintText": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingresa o pega el enlace de suscripción en formato .m3u o .txt"),
        "addNoHttpLink": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingresa un enlace http/https"),
        "addRepeat": MessageLookupByLibrary.simpleMessage(
            "Esta fuente de suscripción ya ha sido agregada"),
        "appName": MessageLookupByLibrary.simpleMessage("EasyTV"),
        "checkUpdate":
            MessageLookupByLibrary.simpleMessage("Verificar Actualizaciones"),
        "createTime": MessageLookupByLibrary.simpleMessage("Hora de Creación"),
        "dataSourceContent": MessageLookupByLibrary.simpleMessage(
            "¿Estás seguro de que deseas agregar esta fuente de datos?"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "dialogDeleteContent": MessageLookupByLibrary.simpleMessage(
            "¿Estás seguro de que deseas eliminar esta suscripción?"),
        "dialogTitle":
            MessageLookupByLibrary.simpleMessage("Recordatorio Amistoso"),
        "findNewVersion":
            MessageLookupByLibrary.simpleMessage("Nueva versión encontrada"),
        "fullScreen":
            MessageLookupByLibrary.simpleMessage("Alternar Pantalla Completa"),
        "getDefaultError": MessageLookupByLibrary.simpleMessage(
            "Error al obtener la fuente de datos predeterminada"),
        "homePage": MessageLookupByLibrary.simpleMessage("Página Principal"),
        "inUse": MessageLookupByLibrary.simpleMessage("En Uso"),
        "landscape": MessageLookupByLibrary.simpleMessage("Modo Horizontal"),
        "latestVersion": MessageLookupByLibrary.simpleMessage(
            "Ya estás en la última versión"),
        "lineIndex": m0,
        "lineToast": m1,
        "loading": MessageLookupByLibrary.simpleMessage("Cargando"),
        "netBadResponse": m2,
        "netCancel":
            MessageLookupByLibrary.simpleMessage("Solicitud Cancelada"),
        "netReceiveTimeout":
            MessageLookupByLibrary.simpleMessage("Tiempo de respuesta agotado"),
        "netSendTimeout":
            MessageLookupByLibrary.simpleMessage("Tiempo de solicitud agotado"),
        "netTimeOut":
            MessageLookupByLibrary.simpleMessage("Tiempo de conexión agotado"),
        "newVersion": m3,
        "noEPG": MessageLookupByLibrary.simpleMessage(""),
        "okRefresh":
            MessageLookupByLibrary.simpleMessage("【Tecla OK】 Actualizar"),
        "parseError": MessageLookupByLibrary.simpleMessage(
            "Error al analizar la fuente de datos"),
        "pasterContent": MessageLookupByLibrary.simpleMessage(
            "Después de copiar la fuente de suscripción, regresa a esta página para agregar automáticamente la fuente de suscripción"),
        "playError": MessageLookupByLibrary.simpleMessage(
            "Este video no se puede reproducir, por favor cambia a otro canal"),
        "playReconnect": MessageLookupByLibrary.simpleMessage(
            "Ocurrió un error, intentando reconectar..."),
        "portrait": MessageLookupByLibrary.simpleMessage("Modo Vertical"),
        "pushAddress": m4,
        "refresh": MessageLookupByLibrary.simpleMessage("Actualizar"),
        "releaseHistory":
            MessageLookupByLibrary.simpleMessage("Historial de Lanzamientos"),
        "setDefault": MessageLookupByLibrary.simpleMessage(
            "Establecer como Predeterminado"),
        "settings": MessageLookupByLibrary.simpleMessage("Configuraciones"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Suscripción IPTV"),
        "switchLine": m5,
        "tipChangeLine": MessageLookupByLibrary.simpleMessage("Cambiar Línea"),
        "tipChannelList":
            MessageLookupByLibrary.simpleMessage("Lista de Canales"),
        "tvParseParma":
            MessageLookupByLibrary.simpleMessage("Error de Parámetro"),
        "tvParsePushError": MessageLookupByLibrary.simpleMessage(
            "Por favor, empuja el enlace correcto"),
        "tvParseSuccess": MessageLookupByLibrary.simpleMessage("Push Exitoso"),
        "tvPushContent": MessageLookupByLibrary.simpleMessage(
            "En la página de resultados del escaneo, ingresa la nueva fuente de suscripción y haz clic en el botón de push para agregar con éxito"),
        "tvScanTip": MessageLookupByLibrary.simpleMessage(
            "Escanea para agregar fuente de suscripción"),
        "update": MessageLookupByLibrary.simpleMessage("Actualizar Ahora"),
        "updateContent": MessageLookupByLibrary.simpleMessage(
            "Contenido de la Actualización")
      };
}
