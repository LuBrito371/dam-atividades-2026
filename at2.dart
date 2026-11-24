abstract interface class Emprestavel {
  bool get disponivel;
  bool emprestar();
  void devolver();
}

abstract class Livro {
  final String codigo;
  String _titulo;
  String? autor;

  Livro({
    required this.codigo,
    required String titulo,
    this.autor,
  }) : _titulo = titulo.trim().isEmpty ? 'Sem título' : titulo.trim();

  String get titulo => _titulo;

  set titulo(String novoTitulo) {
    final tratado = novoTitulo.trim();
    if (tratado.isNotEmpty) {
      _titulo = tratado;
    }
  }

  String get autorExibicao {
    if (autor == null || autor!.trim().isEmpty) {
      return 'Autor desconhecido';
    }
    return autor!.trim();
  }

  String descricao();
}

extension LivroReferencia on Livro {
  String get referencia => '$titulo - $autorExibicao';
}

class LivroFisico extends Livro implements Emprestavel {
  final int numeroPaginas;
  bool _disponivel = true;

  LivroFisico({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.numeroPaginas,
  });

  @override
  bool get disponivel => _disponivel;

  @override
  bool emprestar() {
    if (!_disponivel) {
      return false;
    }
    _disponivel = false;
    return true;
  }

  @override
  void devolver() {
    _disponivel = true;
  }

  @override
  String descricao() {
    final status = _disponivel ? 'Disponível' : 'Indisponível';
    return '[Livro Físico] Código: $codigo | Título: $titulo | Autor: $autorExibicao | Páginas: $numeroPaginas | Status: $status';
  }
}

class LivroDigital extends Livro {
  final double tamanhoMb;

  LivroDigital({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.tamanhoMb,
  });

  @override
  String descricao() {
    return '[Livro Digital] Código: $codigo | Título: $titulo | Autor: $autorExibicao | Tamanho: ${tamanhoMb.toStringAsFixed(1)} MB';
  }
}

void main() {
  final List<Livro> catalogo = [
    LivroFisico(
      codigo: 'FIS-001',
      titulo: 'Tudo é Rio',
      autor: 'Carla Madeira',
      numeroPaginas: 210,
    ),
    LivroDigital(
      codigo: 'DIG-002',
      titulo: 'A Natureza da Mordida',
      autor: 'Carla Madeira',
      tamanhoMb: 1.8,
    ),
    LivroFisico(
      codigo: 'FIS-003',
      titulo: 'Véspera',
      numeroPaginas: 280,
    ),
  ];

  print('CATÁLOGO INICIAL');
  for (final livro in catalogo) {
    print(livro.descricao());
    print('Referência: ${livro.referencia}\n');
  }

  print('ALTERAÇÃO DE TÍTULO');
  final livroAlvo = catalogo[0];
  print('Título original: "${livroAlvo.titulo}"');

  livroAlvo.titulo = '   Tudo é Rio - Edição Comemorativa   ';
  print('Após entrada válida com espaços: "${livroAlvo.titulo}"');

  livroAlvo.titulo = '     ';
  print('Após entrada em branco (mantém anterior): "${livroAlvo.titulo}"\n');

  print('CONTROLE DE EMPRÉSTIMOS');
  final livroFisico = catalogo[0] as LivroFisico;
  print('Disponível inicialmente? ${livroFisico.disponivel}');

  final primeiroEmprestimo = livroFisico.emprestar();
  print('1ª tentativa de empréstimo aceita? $primeiroEmprestimo');
  print('Disponível após 1º empréstimo? ${livroFisico.disponivel}');

  final segundoEmprestimo = livroFisico.emprestar();
  print('2ª tentativa de empréstimo aceita? $segundoEmprestimo (recusada)');

  livroFisico.devolver();
  print('Disponível após devolução? ${livroFisico.disponivel}');

  livroFisico.devolver();
  print('Disponível após nova devolução? ${livroFisico.disponivel}');
}