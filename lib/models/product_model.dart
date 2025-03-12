class ProductModel {
  final String id;
  final String nome;
  final String? descricao;
  final double? preco;

  ProductModel({
    required this.id,
    required this.nome,
    this.descricao,
    this.preco,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        nome: json['nome'],
        descricao: json['descricao'],
        preco: json['preco']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'preco': preco,
      };
}
