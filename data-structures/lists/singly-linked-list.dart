import 'node.dart';

class SinglyLinkedList<T> {
  Node<T>? _head;
  int length = 0;

  bool get isEmpty => _head == null;
  Node<T> get last {
    var node = _head!;
    while (node.next != null) {
      node = node.next as Node<T>;
    }
    return node;
  }

  SinglyLinkedList map(dynamic Function(T) fn) {
    var list = SinglyLinkedList();
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
      last.next = node;
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
      last.next = nodes[0];
    }
    return this;
  }

  T peek() => last.value;

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
  print(l.insertAll([1, 2, 3, 4, 5]));
}
