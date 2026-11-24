class Categoria {
final String nome;
const Categoria(this.nome);



}

void main() {
const c1 = Categoria("Cachorro");
const c2 = Categoria("Cachorro");
const c3 = Categoria("Gato");
print(identical(c1, c2)); // true
print(identical(c1, c3)); // false

}

