# 🎮 Menu Estilo VXA

Menu customizado para **RPG Maker XP**, desenvolvido em **Ruby / RGSS1** e inspirado no estilo do menu do **RPG Maker VX Ace**.

Custom menu for **RPG Maker XP**, developed with **Ruby / RGSS1** and inspired by the **RPG Maker VX Ace** menu style.

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![RPG Maker XP](https://img.shields.io/badge/RPG%20Maker-XP-red)
![RGSS1](https://img.shields.io/badge/RGSS-1-darkred)
![Ruby](https://img.shields.io/badge/Ruby-RGSS1-red)

🇧🇷 [Português](#-português) • 🇺🇸 [English](#-english)

---

# 🇧🇷 Português

## 📖 Sobre o projeto

O **Menu Estilo VXA** é um sistema de menu personalizado para o **RPG Maker XP**, desenvolvido em **Ruby utilizando RGSS1**.

O projeto substitui o menu padrão da engine por uma interface inspirada no **RPG Maker VX Ace**, oferecendo uma apresentação mais moderna das informações do grupo e adicionando funcionalidades próprias ao sistema de menu.

A versão atual é a **1.1.0**.

---

## ✨ Funcionalidades

- Menu principal personalizado
- Faces individuais para os personagens
- Exibição de nome, classe, nível, estados e experiência
- Barras personalizadas de HP e SP
- Sistema de **Formação** para reorganizar os integrantes do grupo
- Destaque visual durante a seleção de personagens
- Imagem de fundo personalizada
- Exibição dos gráficos do mapa como parte da composição visual
- Controle de comandos disponíveis conforme o estado do jogo
- Opção **Salvar** desabilitada visualmente quando o salvamento não estiver disponível
- Retorno correto do cursor após as telas de **Salvar** e **Sair**

### 🕹️ Comandos disponíveis

- Itens
- Habilidades
- Equipamentos
- Condições
- Formação
- Salvar
- Sair

---

## ⚙️ Requisitos

- RPG Maker XP

---

## ⬇️ Recursos Gráficos

- [Mediafire](https://www.mediafire.com/file/4dpk3oeufk7xwzp/Graphics_Faces_MEVXA.zip/file)

---

## 🌐 Página do Sistema

- [Somnium System](https://somniumsystem.blogspot.com/2018/10/sistema-menu-estilo-rmvxa.html)

---

## 📦 Instalação

1. Abra o projeto no **RPG Maker XP**.
2. Acesse o **Editor de Scripts**.
3. Crie uma nova seção acima de `Main`.
4. Cole o código do **Menu Estilo VXA**.
5. Dentro da pasta `Graphics`, crie uma nova pasta chamada:

```text
Graphics/Faces/
```

6. Adicione as imagens das faces dos personagens nessa pasta.
7. Adicione a imagem utilizada como fundo em:

```text
Graphics/Pictures/
```

8. Execute o projeto.

---

## 🖼️ Recursos gráficos

A estrutura esperada é semelhante a:

```text
Graphics/
├── Faces/
│   ├── 001-Fighter01.png
│   ├── 002-Fighter02.png
│   └── ...
│
└── Pictures/
    └── Fundo.png
```

---

### 🙂 Faces dos personagens

Cada personagem deve possuir uma imagem de rosto correspondente dentro de:

```text
Graphics/Faces/
```

O nome do arquivo da face deve ser igual ao nome do gráfico `Character` utilizado pelo respectivo personagem.

### Exemplo

```text
Character: 001-Fighter01
Face:      001-Fighter01.png
```

O tamanho utilizado para as faces é:

```text
100 x 96 px
```

---

### 🌄 Imagem de fundo

O sistema utiliza uma imagem externa como fundo do menu.

Por padrão, o arquivo utilizado é:

```text
Graphics/Pictures/Fundo
```

O nome pode ser alterado diretamente nas configurações do script:

```ruby
module MENU
  VERSION = "1.1.0"
  FUNDO = "Fundo"
end
```

A imagem é exibida abaixo das janelas do menu, permitindo modificar sua identidade visual sem alterar a lógica principal do sistema.

---

## 🔄 Sistema de Formação

A opção **Formação** permite modificar a ordem dos personagens do grupo.

O sistema funciona em duas etapas:

1. Selecione o primeiro personagem.
2. Selecione o personagem que deverá trocar de posição com ele.

Caso o mesmo personagem seja selecionado novamente, a operação é cancelada.

Também é possível cancelar a primeira seleção sem sair da opção Formação.

---

## 🧩 Estrutura do sistema

O script é dividido em diferentes componentes responsáveis pelo funcionamento do menu.

### `MENU`

Armazena configurações gerais do sistema, como:

- versão atual;
- nome da imagem de fundo.

### `RPG::Cache`

Adiciona ao sistema de cache do RGSS o carregamento das imagens armazenadas em:

```text
Graphics/Faces/
```

### `MenuVXA`

Responsável pela janela principal de comandos.

Controla:

- exibição das opções;
- cursor;
- desenho dos comandos;
- comandos habilitados e desabilitados.

### `Window_MenuStatusVXA`

Responsável pela apresentação das informações dos personagens.

Exibe:

- face;
- nome;
- classe;
- nível;
- estados;
- experiência;
- HP;
- SP.

Também gerencia as barras personalizadas de HP e SP.

### `JanelaEscolha`

Cria o destaque visual utilizado durante a seleção do primeiro personagem no sistema de Formação.

### `Scene_Menu`

Controla o funcionamento geral do menu, incluindo:

- criação das janelas;
- navegação;
- comandos;
- elementos gráficos;
- sistema de Formação;
- troca da ordem dos personagens;
- gerenciamento dos recursos utilizados pela cena.

### `Scene_Save`

Possui ajustes para que o cursor retorne corretamente à opção **Salvar** ao voltar para o menu.

### `Scene_End`

Possui ajustes para que o cursor retorne corretamente à opção **Sair** ao voltar para o menu.

---

## 🧪 Compatibilidade

O script modifica e estende algumas classes relacionadas ao menu padrão do RPG Maker XP.

Scripts que também alterem diretamente essas classes podem exigir ajustes de compatibilidade:

```text
Scene_Menu
Window_MenuStatus
Scene_Save
Scene_End
```

É recomendado testar o sistema quando utilizado em conjunto com outros scripts que modifiquem o menu ou essas cenas.

---

## 🚀 Versão 1.1.0

A versão **1.1.0** recebeu uma revisão estrutural voltada à organização, manutenção e estabilidade do código.

Entre as principais melhorias estão:

- versionamento formal do script;
- organização das configurações do menu;
- separação da janela de status personalizada;
- otimização das barras de HP e SP;
- proteção contra valores inválidos durante o cálculo das barras;
- reorganização do sistema de Formação;
- remoção de variáveis globais utilizadas pela Formação;
- cálculo automático da posição da janela de seleção;
- centralização da limpeza do estado da Formação;
- gerenciamento dos elementos gráficos utilizados pela cena;
- tratamento visual da opção Salvar quando indisponível;
- correções no retorno do cursor;
- revisão da documentação interna do código.

---

## 👨‍💻 Autor

**Rayner Brito**

Desenvolvido para **RPG Maker XP / RGSS1**.

---

# 🇺🇸 English

## 📖 About the project

**Menu Estilo VXA** is a custom menu system for **RPG Maker XP**, developed in **Ruby using RGSS1**.

The project replaces the engine's default menu with an interface inspired by **RPG Maker VX Ace**, providing a more modern presentation of party information and additional menu functionality.

Current version: **1.1.0**.

---

## ✨ Features

- Custom main menu
- Individual character faces
- Character name, class, level, states and experience
- Custom HP and SP gauges
- **Formation** system for party reordering
- Visual highlight during character selection
- Custom background image
- Map graphics displayed as part of the menu composition
- Dynamic command availability based on the game state
- **Save** command visually disabled when saving is unavailable
- Correct cursor restoration after **Save** and **Exit**

### 🕹️ Available commands

- Items
- Skills
- Equipment
- Status
- Formation
- Save
- Exit

---

## ⚙️ Requirements

- RPG Maker XP

---

## ⬇️ Graphic Features

- [Mediafire](https://www.mediafire.com/file/4dpk3oeufk7xwzp/Graphics_Faces_MEVXA.zip/file)

---

## 🌐 System Page

- [Somnium System](https://somniumsystem.blogspot.com/2018/10/sistema-menu-estilo-rmvxa.html)

---

## 📦 Installation

1. Open your project in **RPG Maker XP**.
2. Open the **Script Editor**.
3. Create a new section above `Main`.
4. Paste the **Menu Estilo VXA** script.
5. Inside the `Graphics` directory, create:

```text
Graphics/Faces/
```

6. Add the character face images to this folder.
7. Add the menu background image to:

```text
Graphics/Pictures/
```

8. Run the project.

---

## 🖼️ Graphic resources

The expected structure is:

```text
Graphics/
├── Faces/
│   ├── 001-Fighter01.png
│   ├── 002-Fighter02.png
│   └── ...
│
└── Pictures/
    └── Fundo.png
```

---

### 🙂 Character faces

Each character must have a corresponding face image stored in:

```text
Graphics/Faces/
```

The face filename must match the `Character` graphic filename used by the corresponding actor.

### Example

```text
Character: 001-Fighter01
Face:      001-Fighter01.png
```

The face size used by the system is:

```text
100 x 96 px
```

---

### 🌄 Background image

The system uses an external image as the menu background.

By default, the script loads:

```text
Graphics/Pictures/Fundo
```

The filename can be changed directly in the script configuration:

```ruby
module MENU
  VERSION = "1.1.0"
  FUNDO = "Fundo"
end
```

The image is rendered below the menu windows, allowing the interface appearance to be customized without changing the main system logic.

---

## 🔄 Formation system

The **Formation** command allows the player to reorder party members.

The system works in two steps:

1. Select the first character.
2. Select another character to swap positions.

Selecting the same character again cancels the operation.

The first selection can also be canceled without leaving Formation mode.

---

## 🧩 System structure

The script is divided into different components responsible for the menu behavior.

### `MENU`

Stores general system configuration such as:

- current version;
- background image filename.

### `RPG::Cache`

Adds support for loading face images stored in:

```text
Graphics/Faces/
```

### `MenuVXA`

Handles the main command window.

Responsible for:

- displaying menu options;
- cursor selection;
- command rendering;
- enabled and disabled commands.

### `Window_MenuStatusVXA`

Handles the character status display.

Shows:

- face;
- name;
- class;
- level;
- states;
- experience;
- HP;
- SP.

It also manages the custom HP and SP gauges.

### `JanelaEscolha`

Creates the visual highlight displayed when the first character is selected in the Formation system.

### `Scene_Menu`

Controls the overall menu behavior, including:

- window creation;
- navigation;
- command processing;
- graphic elements;
- Formation system;
- party member reordering;
- scene resource management.

### `Scene_Save`

Adds compatibility adjustments so the cursor correctly returns to the **Save** command.

### `Scene_End`

Adds compatibility adjustments so the cursor correctly returns to the **Exit** command.

---

## 🧪 Compatibility

The script modifies and extends classes related to the default RPG Maker XP menu.

Scripts that also modify these classes may require compatibility adjustments:

```text
Scene_Menu
Window_MenuStatus
Scene_Save
Scene_End
```

Testing is recommended when using the system together with other scripts that modify the menu or these scenes.

---

## 🚀 Version 1.1.0

Version **1.1.0** includes a structural revision focused on code organization, maintainability and stability.

Main improvements include:

- formal script versioning;
- centralized menu configuration;
- dedicated custom status window;
- optimized HP and SP gauges;
- protection against invalid gauge calculations;
- redesigned Formation system;
- removal of Formation-related global variables;
- automatic selection-window positioning;
- centralized Formation state cleanup;
- graphic resource management;
- visual handling of the disabled Save command;
- cursor restoration fixes;
- revised and expanded internal source documentation.

---

## 👨‍💻 Author

**Rayner Brito**

Developed for **RPG Maker XP / RGSS1**.
