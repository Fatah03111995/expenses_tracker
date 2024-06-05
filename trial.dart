List<Map> list = [
  {'no': 3, 'jawaban': 'c'},
  {'no': 2, 'jawaban': 'b'},
  {'no': 4, 'jawaban': 'd'},
  {'no': 1, 'jawaban': 'a'},
];

List<Map> myList = [
  {'name': 'ifredom', 'age': 23},
  {'name': 'JackMa', 'age': 61},
  {'name': 'zhazhahui', 'age': 48},
];

void main() {
  list.sort((a, b) => a['no'].compareTo(b['no']));
  print(list);
}
