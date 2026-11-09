enum Classificacao { semAvaliacoes, baixa, regular, alta }

void main() {
  const notaMinima = 1;
  const notaMaxima = 5;
  const notaPositiva = 4;

  final notasRecebidas = <String, List<String>>{
    'Agenda UFAPE': ['5', '4', '5', '0', '3', '6'],
    'Biblioteca Digital': ['3', '2', '4', '1'],
    'Mapa do Campus': [],
    'Restaurante Universitário': ['5', '5', '4', '4', '5'],
    'Transporte Universitário': ['0', '6', '-1'],
  };

  final categoriasPorApp = <String, String>{
    'Agenda UFAPE': 'Organização',
    'Biblioteca Digital': 'Serviços',
    'Mapa do Campus': 'Localização',
    'Restaurante Universitário': 'Serviços',
    'Transporte Universitário': 'Serviços',
  };

  final contatosPorApp = <String, String?>{
    'Agenda UFAPE': 'agenda@exemplo.com',
    'Biblioteca Digital': null,
    'Mapa do Campus': 'mapa@exemplo.com',
    'Restaurante Universitário': 'ru@exemplo.com',
  };

  final notasValidasPorApp = <String, List<int>>{};
  final descartadasPorApp = <String, int>{};
  final categoriasUnicas = <String>{};

  for (var nomeApp in notasRecebidas.keys) {
    String categoria = categoriasPorApp[nomeApp]!;
    List<String> notasText = notasRecebidas[nomeApp]!;

    categoriasUnicas.add(categoria);
    notasValidasPorApp[nomeApp] = [];
    descartadasPorApp[nomeApp] = 0;

    for (var notaStr in notasText) {
      int? nota = int.tryParse(notaStr);

      if (nota != null && nota >= notaMinima && nota <= notaMaxima) {
        notasValidasPorApp[nomeApp]!.add(nota);
      } else {
        descartadasPorApp[nomeApp] = (descartadasPorApp[nomeApp] ?? 0) + 1;
      }
    }
  }

  print('RELATÓRIO DE AVALIAÇÕES');
  print('======================');

  for (var nomeApp in notasRecebidas.keys) {
    String categoria = categoriasPorApp[nomeApp]!;

    String contato = contatosPorApp[nomeApp] ?? 'Não informado';

    List<int> notasValidas = notasValidasPorApp[nomeApp]!;
    int qtdValidas = notasValidas.length;
    int qtdDescartadas = descartadasPorApp[nomeApp]!;

    String mediaStr;
    String percentualStr;
    Classificacao classificacaoEnum;

    if (qtdValidas == 0) {
      mediaStr = 'Não calculado';
      percentualStr = 'Não calculado';
      classificacaoEnum = Classificacao.semAvaliacoes;
    } else {
      double soma = notasValidas.fold(0, (prev, element) => prev + element);
      double media = soma / qtdValidas;
      mediaStr = media.toStringAsFixed(2);

      int positivas = notasValidas.where((nota) => nota >= notaPositiva).length;
      double percentual = (positivas / qtdValidas) * 100;
      percentualStr = '${percentual.toStringAsFixed(1)}%';

      if (media < 3) {
        classificacaoEnum = Classificacao.baixa;
      } else if (media >= 3 && media < 4) {
        classificacaoEnum = Classificacao.regular;
      } else {
        classificacaoEnum = Classificacao.alta;
      }
    }

    String classificacaoTexto;
    switch (classificacaoEnum) {
      case Classificacao.semAvaliacoes:
        classificacaoTexto = 'Sem avaliações';
        break;
      case Classificacao.baixa:
        classificacaoTexto = 'Baixa';
        break;
      case Classificacao.regular:
        classificacaoTexto = 'Regular';
        break;
      case Classificacao.alta:
        classificacaoTexto = 'Alta';
        break;
    }

    print('Nome: $nomeApp');
    print('Categoria: $categoria');
    print('Contato: $contato');
    print('Notas válidas: $qtdValidas');
    print('Notas descartadas: $qtdDescartadas');
    print('Média: $mediaStr');
    print('Notas positivas (>= $notaPositiva): $percentualStr');
    print('Classificação: $classificacaoTexto');
    print('---');
  }

  print('\nCATEGORIAS ENCONTRADAS');
  print('Categorias únicas: ${categoriasUnicas.join(", ")}');
}
