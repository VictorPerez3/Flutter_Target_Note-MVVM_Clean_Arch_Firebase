# 📋 Project Flutter Target Note App

* Data de Desenvolvimento/Ultima modificação : 18/09/2024

* 👨‍💻 Desenvolvedor : Victor Vagner Perez

* 🏅 Mentoria e Revisão: João Felipe Gonçalves (Desenvolvedor Mobile Especialista)

* 🎨 Design UI: Gabriel Pole

# 

# 1 - Sobre o aplicativo
É um aplicativo criado em flutter para dispositivos Android e IOS, com autenticação e sistema de cadastro criptografado de notas.

#

# 2 - Características
### 🛠️ Clean Architecture aplicada ao MVVM
Normalmente utilizada em projetos mais robustos e complexos, apresenta vantagens como: Separação de responsabilidades, testabilidade, reusabilidade, escalabilidade e independência de frameworks.\
Nesse projeto em especifico, um projeto pequeno e sem muita complexidade, a utilização de MVVM com Clean Architecture seria um "Over Engineering" proposital visando o meu aprendizado em uma arquitetura mais complexa.

### 🛠️ Armazenamento local com Get_Storage
Solução de armazenamento leve e rápida que simplifica o armazenamento local de dados.

### 🛠️ Gerenciamento de estado com Get it + Value Notifier
Essa união nativa conta com uma das reatividades mais rápidas existentes no Flutter.

### 🛠️ Injeção de Dependência e Vinculação (Binding) com Get It

### 🛠️ Programação reativa com RxDart

### 🛠️ Firebase Authentication

### 🛠️ Firebase Realtime DataBase

### 🛠️ Criptografia (via lib encrypt)
Criptografia AES com preenchimento PKCS7 nos dados armazenados.

### 🛠️ Firebase Crashlytics
Durante a execução do app, se ocorrer um erro não tratado, o Crashlytics registrará o erro. Isso inclui informações como a stack trace, mensagens de erro e outras informações customizadas. Através do uso de abstrações e injeção de dependências na implementação do crashlytics, o app consegue registrar e reportar erros de maneira eficaz e segregando por ambientes de execução.
#### Crashlytics Mock
É como uma versão de "brincadeira" do Crashlytics. Ele não envia dados para lugar nenhum, mas imprime mensagens e erros no console quando o app roda em debug mode, o que facilita encontrar e corrigir problemas durante o desenvolvimento.

### 🛠️ Firebase Analytics
Registro de eventos no aplicativo.

### 🛠️ Push Notifications com Firebase Cloud Messaging

### 🛠️ Serviço de tradução utilizando i18n

### 🛠️ Flutter Version Management (FVM)

#

# 3 - Telas
### 1) Auth Page 🔒
Pagina de autenticação, onde inclui:
1. Login e criação de usuário.
2. Validação de campos: necessario para ativar o botão de autenticação.
3. Firebase Authentication como API.
4. Label "Política de privacidade" no rodapé da pagina. Se clicado, direciona para o navegador no site da Google.

[//]: # (   ![splash screen_300x600]&#40;https://github.com/VictorPerez3/Project_Flutter_Target/blob/main/login_page.jpg&#41;)


### 2) Note Page 📋
A tela apresenta uma lista CRUD de notas, permitindo criação, edição e exclusão de notas.
1. As notas são divididas por usuário e tipo.
2. Hasheamento de conteudo da nota dependendo do tipo de nota (contas pessoais e detalhes bancários).
3. Criptografia: Utilizando a lib encrypt, todas as notas são criptografadas no envio ao banco de dados (Firebase Realtime Database).
4. Ações e Exception são sinalizadas através de uma SnackBar personalizada.

[//]: # (   ![main3_727x600 &#40;3&#41;]&#40;https://github.com/VictorPerez3/Project_Flutter_Target/blob/main/dashboard_flutter.jpg&#41;)


# 4 - Passos para clonar, configurar e executar o App 📜
### 1) Clonando o repositório (Remoto -> Maquina Local) através do terminal:

```
git clone https://github.com/VictorPerez3/Project_Flutter_Target.git
```

### 2) Siga para a raiz do projeto e execute o seguinte comando no terminal para obter as dependências necessárias:

```
fvm flutter pub get 
```

### 3) executar o projeto:

```
fvm flutter run
```

# 5 - Testes Unitários ⛓️‍💥
xxxxxxxxxxxxxx


