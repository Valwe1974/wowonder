import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Screens/Live/providers/usuario.dart';

class LiveProvider extends ChangeNotifier {
  final List<Usuario> _audiencia = [];

  UnmodifiableListView<Usuario> get audiencia =>
      UnmodifiableListView(_audiencia);

  join(Usuario usuario) {
    _audiencia.add(usuario);
    notifyListeners();
  }

  leave(Usuario usuario) {
    _audiencia.remove(usuario);
    notifyListeners();
  }
}
