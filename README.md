Este projeto é uma API para fornecer informações sobre estados e cidades do Brasil. A API utiliza dados de uma fonte externa e os armazena em cache para melhorar a performance.

## Estrutura do Projeto

```
├── .dart_tool/
├── .dockerignore
├── .env
├── .gitignore
├── .vscode/
├── analysis_options.yaml
├── bin/
│   └── server.dart
├── CHANGELOG.md
├── docker/
│   ├── redis.conf
│   ├── docker-compose.yml
│   └── Dockerfile
├── http/
│   └── location.http
├── lib/
│   ├── app/
│   │   ├── data/
│   │   ├── http/
│   │   ├── models/
│   │   ├── providers/
│   │   └── repository/
│   ├── cache/
│   └── route/
├── LICENSE
├── public/
├── pubspec.lock
├── pubspec.yaml
├── README.md
└── storage/
```

## Instalação

1. **Clone o repositório:**

    ```sh
    git clone https://github.com/seu-usuario/estados-cidades-api.git
    cd estados-cidades-api
    ```

2. **Instale as dependências:**

    ```sh
    dart pub get
    ```

3. **Configure o ambiente:**

    Crie um arquivo 

.env

 na raiz do projeto e adicione as variáveis de ambiente necessárias.

4. **Inicie o servidor:**

    ```sh
    dart run bin/server.dart
    ```

## Endpoints

### `GET /api/states`

Retorna uma lista de estados.

### `GET /api/cities/{state}`

Retorna uma lista de cidades para um estado específico.

## API Externa

Este projeto utiliza a [BrasilAPI](https://brasilapi.com.br/docs#tag/IBGE/paths/~1ibge~1municipios~1v1~1{siglaUF}?providers=dados-abertos-br,gov,wikipedia/get) para obter informações sobre estados e cidades do Brasil.

## Testes

Para rodar os testes, execute:

```sh
dart test
```

## Estrutura de Código

### 

location_controller.dart



Controlador responsável por lidar com as requisições HTTP relacionadas a estados e cidades.

### 

location_repository.dart



Repositório que gerencia a lógica de obtenção de dados, seja da API externa ou do cache.

### 

location_cache_datasource.dart



Datasource que gerencia o cache dos dados utilizando Redis.

### 

location_brasil_api_datasource.dart



Datasource que obtém os dados da API externa.

### 

city_model.dart



Modelo que representa uma cidade.

### 

state_model.dart



Modelo que representa um estado.

## Docker

Para rodar o projeto utilizando Docker, execute:

```sh
docker-compose up --build
```

## Contribuição

1. Faça um fork do projeto.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`).
4. Faça um push para a branch (`git push origin feature/nova-feature`).
5. Crie um novo Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo 

LICENSE

 para mais detalhes.
