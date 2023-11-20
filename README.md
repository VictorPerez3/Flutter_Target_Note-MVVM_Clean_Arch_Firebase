# Project Flutter Target App

Data de Desenvolvimento/ultima modificação : 19/11/2023

Nome do desenvolvedor : Victor Vagner Perez

Nome do projeto : Project Flutter Target App

# Desafio Pratico (Dev.Flutter)

 # Sobre o aplicativo 
 É um aplicativo com login e sistema de cadastro de textos.
 
 # Características 
 Este aplicativo representa Login Page e Dashboard Page 
 1. Login Page
 2. Dashboard Page

# 1. Login Page
Pagina de Login, onde inclui:
1. Uma tela de autenticação onde o usuário é obrigado a digitar seu login e senha.
2. Validação de campos necessario para ativar o botão "Entrar" (O campo senha não pode ter menos que dois caracteres, não pode ter caracteres especiais, sendo apenas possível informar 'a' até 'Z' e '0' até '9').
3. Tratamento de campos terminados em espaço.
4. MockAPI: Validação dos dados de login.
5. Label "Política de privacidade" no rodapé da pagina. Se clicado, direciona para o navegador no site da Google.
![splash screen_300x600](https://github.com/VictorPerez3/Project_Flutter_Target/blob/main/login_page.jpg)

 
# 2. Dashboard Page
A tela salva as informações digitadas pelo usuário em um card, listando essas informações salvas e dando a opção de editar ou excluir. Essas informações não são perdidas ao fechar o app, ou seja, ao abrir a tela as informações salvas anteriormente são mostradas na ordem. Vale citar algumas regras:
1. O foco da digitação esta o tempo todo no campo de "Digite seu texto" e não é perdido ao interagir com a tela.
2. Ao acionar o "enter" o campo verifica se a informação foi preenchida.
3. O Icone de excluir abre um pop-up confirmando a ação.
 ![main3_727x600 (3)](https://github.com/VictorPerez3/Project_Flutter_Target/blob/main/dashboard_flutter.jpg)


# Passos para clonar, configurar e executar o App
### 1 - Clonando o repositório (Remoto -> Maquina Local) através do terminal:

```
git clone https://github.com/VictorPerez3/Project_Flutter_Target.git
```

### 2 - Siga para a raiz do projeto e execute o seguinte comando no terminal para obter as dependências necessárias:

```
flutter pub get 
```

### 3 - executar o projeto:

```
flutter run
```
 
 # Bibliotecas utilizadas 
 * MOBX\
 Sobre: https://pub.dev/packages/mobx \
 mobx: ^2.1.3 - flutter_mobx: ^2.0.6+5 - mobx_codegen: ^2.1.1

 * Url Launcher\
 Sobre: https://pub.dev/packages/url_launcher \
 url_launcher: ^6.2.1

 * Fluttertoast\
 Sobre: https://pub.dev/packages/fluttertoast \
 fluttertoast: ^8.0.8

 * Shared Preferences\
 Sobre: https://pub.dev/packages/shared_preferences \
 shared_preferences: ^2.2.2

 * Testes Mockito\
 Sobre: https://pub.dev/packages/mockito \
 mockito: ^5.0.0\
 ![main3_727x600 (3)](https://github.com/VictorPerez3/Project_Flutter_Target/blob/main/test_flutter.png)



