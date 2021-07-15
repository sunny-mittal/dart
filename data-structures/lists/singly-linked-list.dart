import 'node.dart';
import 'package:collection/collection.dart';

class SinglyLinkedList<T> {
  Node<T>? _head;
  int length = 0;

  bool get isEmpty => _head == null;
  Node<T> get _last {
    var node = _head!;
    while (node.next != null) {
      node = node.next as Node<T>;
    }
    return node;
  }

  SinglyLinkedList<U> map<U>(U Function(T) fn) {
    var list = SinglyLinkedList<U>();
    var node = _head;
    while (node != null) {
      list.insert(fn(node.value));
      node = node.next;
    }
    return list;
  }

  SinglyLinkedList<T> insert(T value) {
    var node = Node(value);
    if (isEmpty) {
      _head = node;
    } else {
      _last.next = node;
    }
    length++;
    return this;
  }

  SinglyLinkedList<T> insertAll(List<T> values) {
    if (values.length == 1) {
      insert(values[0]);
      return this;
    }
    var nodes = values.map((T value) => Node(value)).toList();
    for (var i = 0; i < values.length - 1; i++) {
      var node = nodes[i];
      node.next = nodes[i + 1];
    }
    if (isEmpty) {
      _head = nodes[0];
    } else {
      _last.next = nodes[0];
    }
    return this;
  }

  T peek() => _last.value;

  List<T> toList() {
    List<T> list = [];
    var node = _head;
    while (node != null) {
      list.add(node.value);
      node = node.next;
    }
    return list;
  }

  String toString() {
    List<String> strings = [];
    var node = _head;
    while (node != null) {
      strings.add("${node.value}");
      node = node.next;
    }
    return strings.join(",");
  }
}

void main() {
  var l = SinglyLinkedList<int>();
  l.insertAll([1, 2, 3, 4, 5]);
  assert(l.toString() == "1,2,3,4,5");
  l.insert(6);
  assert(l.peek() == 6);
  var mapped = l.map((value) => value.toString());
  var list = mapped.toList();
  assert(const ListEquality().equals(list, ["1", "2", "3", "4", "5", "6"]));
  assert(mapped.toList().every((element) => element.runtimeType == String));
}
