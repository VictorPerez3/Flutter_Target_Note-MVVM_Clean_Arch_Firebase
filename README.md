# 📋 Project Flutter Target Note App

* 👨‍💻 Desenvolvedor : Victor Vagner Perez

* 🏅 Mentoria e Revisão: João Felipe Gonçalves (Desenvolvedor Mobile Especialista)

* 🎨 Design UI: Gabriel Pole

*  Data de Desenvolvimento/Ultima modificação : 11/12/2024

# 

# 1 - Sobre o aplicativo
É um aplicativo criado em flutter para dispositivos Android e IOS, com autenticação e sistema de cadastro criptografado de notas.

#

# 2 - Características
### 🛠️ Clean Architecture aplicada ao MVVM
Normalmente utilizada em projetos mais robustos e complexos, apresenta vantagens como: Separação de responsabilidades, testabilidade, reusabilidade, escalabilidade e independência de frameworks.\
Nesse projeto em especifico, um projeto pequeno e sem muita complexidade, a utilização de MVVM com Clean Architecture seria um "Over Engineering" proposital visando o meu aprendizado em uma arquitetura mais complexa.

### 🛠️ Armazenamento local com Get_Storage

### 🛠️ Gerenciamento de estado nativo com Value Notifier + Get_it 

### 🛠️ Inversão de Dependência e Vinculação (Binding) com Get_It

### 🛠️ Programação reativa com RxDart

### 🛠️ Firebase Authentication

### 🛠️ Firebase Realtime DataBase

### 🛠️ Criptografia (via lib encrypt)

### 🛠️ Firebase Crashlytics
Durante a execução do app, se ocorrer um erro não tratado, o Crashlytics registrará o erro. Isso inclui informações como a stack trace, mensagens de erro e outras informações customizadas. Através do uso de abstrações e injeção de dependências na implementação do crashlytics, o app consegue registrar e reportar erros de maneira eficaz e segregando por ambientes de execução.

### 🛠️ Firebase Analytics

### 🛠️ Push Notifications com Firebase Cloud Messaging

### 🛠️ Deeplink - Android

### 🛠️ Serviço de tradução utilizando i18n

### 🛠️ Flutter Version Management (FVM)

#

# 3 - Telas

### 1) Sign In/Sign Up Page 🔒
Pagina de autenticação, onde inclui:
1. Login e Criação de usuário.
2. Validação de campos: necessario para ativar o botão de autenticação.
3. Firebase Authentication como API.

<div style="display: flex; gap: 10px;">
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-sign-in.jpg" alt="Sign In Screen" width="200"/>
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-sign-up.jpg" alt="Sign Up Screen" width="200"/>
</div>

### 2) Note List Page 📋
A tela apresenta uma lista CRUD de notas, com suas respectivas funcionalidades.
1. As notas são divididas por usuário e tipo.
2. Hasheamento de conteudo dependendo do tipo de nota (Contas Pessoais, Notas Bancários e Notas Ocultas).
3. Criptografia: Utilizando a lib encrypt, todas as notas são criptografadas no envio ao banco de dados (Firebase Realtime Database).
4. Exceptions são sinalizadas através de SnackBar personalizada.

<div style="display: flex; gap: 10px;">
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-geral-list.jpg" alt="Genera - Note List Screen" width="200"/>
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-contas-pessoais-list.jpg" alt="Personal Account - Note List Screen" width="200"/>
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-notas-ocultas-list.jpg" alt="Hidden Note - Note List Screen" width="200"/>
</div>

### 3) Note Details Page 🗒️
A tela apresenta os detalhes com Criação e Edição de Nota : Titulo, conteudo, cor de fundo, alinhamento de texto do conteudo, etc.

<div style="display: flex; gap: 10px;">
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-unfocus-details.jpg" alt="Unfocus - Note List Details" width="200"/>
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-bottom-sheet-enabled-details.jpg" alt="Bottom Sheet Enabled - Note List Details" width="200"/>
  <img src="https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/blob/develop/assets/images/documentation/doc-bottom-sheet-disabled-details.jpg.jpg" alt="Bottom Sheet Disabled - Note List Details" width="200"/>
</div>

# 4 - Passos para clonar, configurar e executar o App 📜
### 1) Clonando o repositório através do terminal

```
git clone -b main https://github.com/VictorPerez3/Flutter_Target_Note-MVVM_Clean_Arch_Firebase.git
```

### 2) Configure a versão do flutter via fvm

```
fvm use 3.22.0
```

### 3) Baixe as dependências necessárias

```
fvm flutter pub get 
```

### 4) Execute o projeto

```
fvm flutter run
```

# 5 - Testes Unitários ⛓️‍💥

```
fvm flutter test
```

# 6 - Deep Links Android 🛜
Para acessar a tela requerida, utilize os comandos abaixo no terminal bash.
- Sign In Screen:
```
adb shell am start -W -a android.intent.action.VIEW -d "https://victorperez3.github.io/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/.well-known/auth/sign_in" com.example.flutter_project_target
```
- Sign Up Screen:
```
adb shell am start -W -a android.intent.action.VIEW -d "https://victorperez3.github.io/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/.well-known/auth/sign_up" com.example.flutter_project_target
```
- Note List Screen:
```
adb shell am start -W -a android.intent.action.VIEW -d "https://victorperez3.github.io/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/.well-known/note/list" com.example.flutter_project_target
```
- Note Details Screen:
```
adb shell am start -W -a android.intent.action.VIEW -d "https://victorperez3.github.io/Flutter_Target_Note-MVVM_Clean_Arch_Firebase/.well-known/note/details" com.example.flutter_project_target
```

