extension EmailExtension on String {
  bool get isEmail {
    return contains('@');
  }
}

void main() {
  String email = "thais.burity@ufape.edu.br";
  print(email.isEmail); //true
}
