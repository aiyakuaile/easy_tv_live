// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_de_DE.dart' as messages_de_de;
import 'messages_en_US.dart' as messages_en_us;
import 'messages_es_ES.dart' as messages_es_es;
import 'messages_ja_JP.dart' as messages_ja_jp;
import 'messages_ko_KR.dart' as messages_ko_kr;
import 'messages_th_TH.dart' as messages_th_th;
import 'messages_zh_CN.dart' as messages_zh_cn;
import 'messages_zh_HK.dart' as messages_zh_hk;
import 'messages_zh_TW.dart' as messages_zh_tw;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'de_DE': () => new SynchronousFuture(null),
  'en_US': () => new SynchronousFuture(null),
  'es_ES': () => new SynchronousFuture(null),
  'ja_JP': () => new SynchronousFuture(null),
  'ko_KR': () => new SynchronousFuture(null),
  'th_TH': () => new SynchronousFuture(null),
  'zh_CN': () => new SynchronousFuture(null),
  'zh_HK': () => new SynchronousFuture(null),
  'zh_TW': () => new SynchronousFuture(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case 'de_DE':
      return messages_de_de.messages;
    case 'en_US':
      return messages_en_us.messages;
    case 'es_ES':
      return messages_es_es.messages;
    case 'ja_JP':
      return messages_ja_jp.messages;
    case 'ko_KR':
      return messages_ko_kr.messages;
    case 'th_TH':
      return messages_th_th.messages;
    case 'zh_CN':
      return messages_zh_cn.messages;
    case 'zh_HK':
      return messages_zh_hk.messages;
    case 'zh_TW':
      return messages_zh_tw.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new SynchronousFuture(false);
  }
  var lib = _deferredLibraries[availableLocale];
  lib == null ? new SynchronousFuture(false) : lib();
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new SynchronousFuture(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
