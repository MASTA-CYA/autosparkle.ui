abstract interface class SerializableModel<T> {
  List<String> get keys;
  T get model;

  T modifyProperty(String field, dynamic value);
}
