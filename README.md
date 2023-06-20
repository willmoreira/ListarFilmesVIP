# ListarFilmesVIP

App feito em Swift que lista filmes, contendo Login sendo feito pelo Auth do firebase, consumindo api publica de lista de filmes.

## Descrição

App ListarFilmes consiste em uma aplicação feita com a finalidade de aplicação de conceitos adquiridos.

Na primeira tela temos 3 funcionalidades:
- Logar na aplicação para visualizar a lista de filmes 
- Botão de recuperar a senha
- Botão para criar uma conta de acesso informando sempre email e senha.

Na tela de Listar Filmes depois de logado temos uma tableView que lista os filmes encontrados, cada celula mostra alguns dados do filme.
Quando tocar em alguma celula ira para tela de detalhes do filme.

Na tela de detalhes mostra a sinopse do filme

## Login

![Captura de Tela 2023-06-20 às 19 03 01](https://github.com/willmoreira/ListarFilmesVIP/assets/32074474/4aa82c03-848a-4f9a-b1d7-867f2b18e2b8)

## Recuperar senha

![Captura de Tela 2023-06-20 às 19 03 10](https://github.com/willmoreira/ListarFilmesVIP/assets/32074474/873135d2-91f2-4537-ad45-8a3fa51529d2)

## Cadastrar Login

![Captura de Tela 2023-06-20 às 19 03 21](https://github.com/willmoreira/ListarFilmesVIP/assets/32074474/0eeef5d4-8511-4111-9ceb-67924f0cd9cd)

## Listar Filmes

![Captura de Tela 2023-06-20 às 19 03 51](https://github.com/willmoreira/ListarFilmesVIP/assets/32074474/267623c2-5b11-4525-ba47-c282189597a6)

## Detalhe do Filme

![Captura de Tela 2023-06-20 às 19 04 03](https://github.com/willmoreira/ListarFilmesVIP/assets/32074474/aee53b66-4c2f-46c7-a896-2f064dce41a2)

## Requisitos

- Swift 5.0 ou superior
- Xcode 13.4 ou superior
- iOS 13.0 ou superior

## Uso

Para usar a aplicação basta criar uma conta com um email valido e uma senha seguindo as regras do AUTH do firebase, quando criar e tiver o restorno de conta criada com sucesso logar no app com as credenciais e verá
a tela de listar filmes, quando clicar em algum filme mostra na tela de detalhes o filme clicado com a descrição do filme.

## Técnicas utlizadas

- Utilizado a arquitetura VIP para organização do projeto.
- Para login utilizamos via SPM o firebaseAuth para ter acesso ao app.
- Teste Unitarios utilizando XCTTeste do proprio Swift
- Internacionalização de Strings via arquivo Localizable, ingles e portugues a principio.
- Aplicação de conceitos do SOLID
- Telas feitas utilizando viewCode
- Usando template para agilizar na construção das camadas do projeto (VIP Swift Xcode Templates)
