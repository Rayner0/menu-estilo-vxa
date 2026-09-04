#===========================================================================
# Menu Estilo VXA 1.1.0
#---------------------------------------------------------------------------
# Autor: Rayner B.
#---------------------------------------------------------------------------
# Versão: 1.1.0
#---------------------------------------------------------------------------
# O Script serve basicamente para deixar o Menu o mais parecido
# possível com o Menu do RPG Maker VX Ace.
#---------------------------------------------------------------------------
# Para fazer o menu funcionar, basta criar dentro da pasta Graphics
# uma nova pasta chamada Faces e colocar as imagens das faces
# dos personagens dentro da pasta e nomea-las de acordo com o
# nome do Character do respectivo personagem.
#
# Ex: Personagem 1 se chama Ash e o nome do seu gráfico Character
# é 001-Fighter01, neste caso o nome da face correspondente
# a este personagem deverá ser 001-Fighter01.
#
# O Tamanho das imagens das faces deverá ser o mesmo tamanho das
# faces disponibilizadas no projeto (100 x 96).
#
# A imagem Fundo funciona como uma camada visual exibida sobre o mapa e abaixo
# das janelas do menu. Ela pode ser opaca ou possuir transparência, permitindo
# que os gráficos do mapa continuem parcialmente visíveis.
#
# Recomenda-se utilizar uma imagem de 640 x 480 pixels, armazenada na pasta
# Graphics/Pictures com o nome definido em MENU::FUNDO.
#
# Qualquer coisa, acesse:
#                        https://somniumsystem.blogspot.com/
#                        http://espacorpgmaker.umforum.net/
#=============================================================================


#==============================================================================
# Configurações do Menu VXA
#==============================================================================

module MENU
  # Versão atual do script
  VERSION = "1.1.0"
  
  # Nome da imagem utilizada como fundo
  FUNDO = "Fundo"
end


#==============================================================================
# RPG::Cache — Carregamento de Faces
#------------------------------------------------------------------------------
# Esta extensão adiciona ao cache do RGSS o carregamento das imagens de rosto
# armazenadas na pasta Graphics/Faces.
#==============================================================================

module RPG
  module Cache
    
  #--------------------------------------------------------------------------
  # Carregar imagem de rosto
  #
  #     filename : Nome do arquivo da imagem
  #     hue      : Variação de matiz aplicada à imagem
  #--------------------------------------------------------------------------

    def self.faces(filename, hue)
      self.load_bitmap("Graphics/Faces/", filename, hue)
    end
  end
end


#==============================================================================
# Menu VXA
#------------------------------------------------------------------------------
# Esta classe exibe a janela de comandos do Menu Estilo VXA.
# Ela desenha as opções, controla a seleção do cursor e permite desabilitar
# comandos. A execução das opções é tratada pela Scene_Menu.
#==============================================================================

class MenuVXA < Window_Selectable
  
  #--------------------------------------------------------------------------
  # Inicialização dos Objetos
  #
  #     x        : Posição da Coordenada X
  #     y        : Posição da Coordenada Y
  #     width    : largura da janela
  #     commands : ordem dos comandos
  #--------------------------------------------------------------------------
  
  def initialize(x, y, width, commands)
    # Aqui é calculada a altura da janela em relação ao número de escolhas
    super(x, y, width, commands.size * 32 + 32)
    @item_max = commands.size
    @commands = commands
    self.contents = Bitmap.new(width - 32, @item_max * 32)
    refresh
    self.index = 0
    self.back_opacity = 175
    self.z = 7000
  end
  
  #--------------------------------------------------------------------------
  # Atualização
  #--------------------------------------------------------------------------
  
  def refresh
    self.contents.clear
    for i in 0...@item_max
      draw_item(i, normal_color)
    end
  end
  
  #--------------------------------------------------------------------------
  # Desenhar Item
  #
  #     index : índice
  #     color : cor do texto
  #--------------------------------------------------------------------------
  
  def draw_item(index, color)
    self.contents.font.color = color
    rect = Rect.new(4, 32 * index, self.contents.width - 8, 32)
    self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
    self.contents.draw_text(rect, @commands[index])
  end
  
  #--------------------------------------------------------------------------
  # Desabitar Item 
  #
  #     index : índice
  #--------------------------------------------------------------------------
  
  def disable_item(index)
    draw_item(index, disabled_color)
  end
  
end

#==============================================================================
# Window_MenuStatusVXA
#------------------------------------------------------------------------------
# Esta classe personaliza a janela de status dos personagens no Menu VXA.
# Ela exibe as faces, informações dos integrantes do grupo e barras de HP e SP.
# A classe herda o comportamento original de Window_MenuStatus.
#==============================================================================

class Window_MenuStatusVXA < Window_MenuStatus
  
  #--------------------------------------------------------------------------
  # Desenhar a Imagem da Face do Herói 
  #
  #     actor : Personagem
  #     x     : Posição de Coordenada
  #     y     : Posição de Coordenada
  #--------------------------------------------------------------------------
  
  def desenhar_face(actor, x, y)
    bitmap = RPG::Cache.faces(actor.character_name, actor.character_hue)
    cw = bitmap.width
    ch = bitmap.height
    src_rect = Rect.new(0, 0, cw, ch)
    self.contents.blt(x - cw / 2, y - ch, bitmap, src_rect)
  end
  
  #--------------------------------------------------------------------------
  # Desenhar o HP e MP dos personagens 
  #
  #  x      : Coordenada - Posição na tela
  #  y      : Coordenada - Posição na tela
  #  width  : Largura
  #  height : Altura
  #  pv     : Pontos de Vida dos personages
  #  pv0    : Pontos de Vida totais dos personagens
  #  cores  : Cor da Hud
  #--------------------------------------------------------------------------
  
  def desenhar_barra(x, y, width, height, atual, maximo, cor)
    largura_fundo = width - 1
    
    # Desenhar o fundo
    self.contents.fill_rect(
      x + 1,
      y + 6,
      largura_fundo,
      height,
      Color.new(50, 50, 50, 255)
    )
    
    # Evitar divisão por zero
    return if maximo <= 0
    
    # Calcular e limitar o percentual entre 0% e 100%
    proporcao = atual.to_f / maximo.to_f
    proporcao = 0.0 if proporcao < 0.0
    proporcao = 1.0 if proporcao > 1.0
    
    largura = (largura_fundo * proporcao).to_i
    
    # Desenhar o preenchimento em uma única operação
    self.contents.fill_rect(x + 1, y + 6, largura, height, cor)
  end
  
  
  def hp_na_tela(x, y, width, height, pv, pv0)
    desenhar_barra(
      x, y, width, height, pv, pv0,
      Color.new(220, 0, 0, 255)
    )
  end
  
  
  def mp_na_tela(x, y, width, height, mp, mp0)
    desenhar_barra(
      x, y, width, height, mp, mp0,
      Color.new(0, 220, 0, 255)
    )
  end
  
  def draw_actor_hp(actor, x, y, width = 126)
    #Desenhar a Imagem da HUD na tela
    hp_na_tela(x + 21, y + 15, width, 6, actor.hp, actor.maxhp)
    # Desenhar string de texto do HP
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 32, 32, $data_system.words.hp)
    # Calcular se há espaço para o HP Max
    if width - 32 >= 94
      hp_x = x + width - 94
      flag = true
    elsif width - 32 >= 34
      hp_x = x + width - 34
      flag = false
    end
    # Desenhar HP
    self.contents.font.color = actor.hp == 0 ? knockout_color :
      actor.hp <= actor.maxhp / 4 ? crisis_color : normal_color
    self.contents.draw_text(hp_x, y, 48, 32, actor.hp.to_s, 2)
    # Desenhar HP Max
    if flag
      self.contents.font.color = normal_color
      self.contents.draw_text(hp_x + 48, y, 12, 32, "/", 1)
      self.contents.draw_text(hp_x + 60, y, 48, 32, actor.maxhp.to_s)
    end
  end
  
  def draw_actor_sp(actor, x, y, width = 126)
     #if actor.id <= 5  
   mp_na_tela(x + 21, y + 15, width, 6, actor.sp, actor.maxsp)
    # Desenhar o string de texto do MP
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 32, 32, $data_system.words.sp)
    # Calcular se há espaço para o MP Max
    if width - 32 >= 94
      sp_x = x + width - 94
      flag = true
    elsif width - 32 >= 34
      sp_x = x + width - 34
      flag = false
    end
    # Desenhar MP
    self.contents.font.color = actor.sp == 0 ? knockout_color :
      actor.sp <= actor.maxsp / 4 ? crisis_color : normal_color
    self.contents.draw_text(sp_x, y, 48, 32, actor.sp.to_s, 2)
    # Desenhar MP Max
    if flag
      self.contents.font.color = normal_color
      self.contents.draw_text(sp_x + 48, y, 12, 32, "/", 1)
      self.contents.draw_text(sp_x + 60, y, 48, 32, actor.maxsp.to_s)
    end
   end
end

#==============================================================================
# Window_MenuStatusVXA - Inicialização e conteúdo
#------------------------------------------------------------------------------
# Esta é a continuação da classe Window_MenuStatusVXA.
# Ela inicializa a janela personalizada e desenha as informações dos
# integrantes do grupo.
#==============================================================================

class Window_MenuStatusVXA
  
  #--------------------------------------------------------------------------
  # Inicialização dos Objetos
  #--------------------------------------------------------------------------
  def initialize
    # Executar o initialize da Window_MenuStatus original
    super
    
    # Definir a opacidade da janela personalizada
    self.back_opacity = 175
  end
            
  #--------------------------------------------------------------------------
  # Redesenho do conteúdo
  #--------------------------------------------------------------------------
  
  def refresh
    self.contents.clear
    @item_max = $game_party.actors.size
    for i in 0...$game_party.actors.size
      x = 64
      y = i * 116
      actor = $game_party.actors[i]
      desenhar_face(actor, x - 15, y + 96)
      draw_actor_name(actor, x + 40, y)
      draw_actor_class(actor, x + 125, y)
      draw_actor_level(actor, x + 40, y + 32)
      draw_actor_state(actor, x + 128, y + 32)
      draw_actor_exp(actor, x + 40, y + 64)
      draw_actor_hp(actor, x + 236, y + 32)
      draw_actor_sp(actor, x + 236, y + 64)
    end
  end
  
end


#==============================================================================
# JanelaEscolha
#------------------------------------------------------------------------------
# Esta classe cria a janela de destaque exibida sobre o primeiro personagem
# selecionado durante a troca de posições na opção Formação.
#==============================================================================

class JanelaEscolha < Window_Base
  
  def initialize(x, y, width, height)
    super(x, y, width, height)
    self.back_opacity = 100
    # Manter a seleção acima dos elementos do mapa
    self.z = 7000
  end
end


#==============================================================================
# Scene_Menu
#------------------------------------------------------------------------------
# Esta classe controla o Menu Estilo VXA.
# Ela cria os elementos visuais, processa os comandos, abre as demais telas
# do jogo e gerencia a troca de personagens pela opção Formação.
#==============================================================================

class Scene_Menu
  
  def initialize(cursor_index = 0)
    @cursor_index = cursor_index
  
    # Dados utilizados pela opção Formação
    @indice_formacao = nil
    @janela_formacao = nil
  end
  
  def main
    # Criar os gráficos do mapa exibidos ao fundo
    @mapa = Spriteset_Map.new
    
    # Criar a imagem de fundo do menu
    @fundo = Sprite.new
    @fundo.bitmap = RPG::Cache.picture(MENU::FUNDO)
    @fundo.z = 6000
    
    op  = $data_system.words.item
    op0 = $data_system.words.skill
    op1 = $data_system.words.equip
    op2 = "Condições" # Status
    op3 = "Formação"
    op4 = "Salvar"
    op5 = "Sair"
    
    @janela_de_comando = MenuVXA.new(0, 0, 160, [op, op0, op1, op2, op3, op4, op5])
    @janela_de_comando.index = @cursor_index

    # Se a quantidade de personagens no grupo for 1 ou 0...
    if $game_party.actors.size <= 1
      # Desabilitar o Item / Opção de escolha 4, Formação.
      @janela_de_comando.disable_item(4)
    end
    
    # Se a quantidade de personagens no grupo for 0...
    if $game_party.actors.size == 0
      # Desabilar as janelas de Item, Habilidades, Equipamento e Status
      @janela_de_comando.disable_item(0)
      @janela_de_comando.disable_item(1)
      @janela_de_comando.disable_item(2)
      @janela_de_comando.disable_item(3)
    end
    
    # Se Salvar estiver proibido...
    if $game_system.save_disabled
      # Desabilitar visualmente a opção Salvar
      @janela_de_comando.disable_item(5)
    end
    
    # Criar janela de Dinheiro
    @gold_window = Window_Gold.new
    @gold_window.x = 0
    @gold_window.y = 416
    @gold_window.back_opacity = 175
    @gold_window.z = 7000
    # Criar janela de Condições / Status
    @status_window = Window_MenuStatusVXA.new
    @status_window.x = 160
    @status_window.y = 0
    @status_window.z = 7000
    # Executar transição
    Graphics.transition
    # Loop principal
    loop do
      # Atualizar a tela de jogo
      Graphics.update
      # Atualizar a entrada de informações
      Input.update
      # Atualizar Frame
      update
      # Abortar loop se a tela for alterada
      if $scene != self
        break
      end
    end
    # Preparar para transiçõa
    Graphics.freeze
    # Garantir a liberação da janela utilizada pela Formação
    limpar_selecao_formacao
    # Exibição das janelas
    @janela_de_comando.dispose
    @gold_window.dispose
    @status_window.dispose
    
    # Liberar os gráficos pertencentes à Scene
    @fundo.dispose unless @fundo.nil? || @fundo.disposed?
    @mapa.dispose unless @mapa.nil?
  end
  
  def update
    # Atualizar janelas
    @janela_de_comando.update
    @gold_window.update
    @status_window.update
    # Se a janela de comandos estiver ativo: chamar update_command
    if @janela_de_comando.active
      update_command
      return
    end
    # Se a janela de Status estiver ativa: Chamar update_status
    if @status_window.active
      update_status
      return
    end
  end
  
  def update_command
    # Se o botão B for pressionado
    if Input.trigger?(Input::B)
      # Reproduzir SE de cancelamento
      $game_system.se_play($data_system.cancel_se)
      # Alternar para a tela do mapa
      $scene = Scene_Map.new
      return
    end
    # Se o botão Enter for pressionado...
    if Input.trigger?(Input::C)
      # Se o número de Heróis no Grupo for 0 e o comando for outro senão 
      # Salvar e Fim de Jogo... 
      if $game_party.actors.size == 0 and @janela_de_comando.index < 5
        # Reproduzir SE de erro
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      
    # Se a quantidade de Heróis no grupo for menor ou igual a 1 e o comando
    # for igual a opção Formação...
    if $game_party.actors.size <= 1 && @janela_de_comando.index == 4
      # Reproduzir SE de erro
      $game_system.se_play($data_system.buzzer_se)
      return
    end
      
      case @janela_de_comando.index
      when 0  # Itens
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Alternar para a tela de Itens
        $scene = Scene_Item.new
      when 1  # Habilidades
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Ativar o status da janela
        @janela_de_comando.active = false
        @status_window.active = true
        @status_window.index = 0
      when 2  # Equipamentos
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Ativar o status da janela
        @janela_de_comando.active = false
        @status_window.active = true
        @status_window.index = 0
      when 3 # Status
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Ativar o status da janela
        @janela_de_comando.active = false
        @status_window.active = true
        @status_window.index = 0
      when 4 # Formação
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Ativar o status da janela
        @janela_de_comando.active = false
        @status_window.active = true
        @status_window.index = 0
      when 5 # Salvar
        # Se Salvar for proibido
        if $game_system.save_disabled
          # Reproduzir SE de erro
          $game_system.se_play($data_system.buzzer_se)
          return
        end
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Alternar para a tela de save
        $scene = Scene_Save.new
      when 6 # Fim de Jogo
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Alternar para a tela de Fim de Jogo
        $scene = Scene_End.new
      end
      return
    end

  end
  
  #--------------------------------------------------------------------------
  # Atualização do Frame (Quando o status da Janela estiver Ativo)
  #--------------------------------------------------------------------------
  
  def update_status
    # Se o botão B for pressionado
    if Input.trigger?(Input::B)
      # Reproduzir SE de cancelamento uma única vez
      $game_system.se_play($data_system.cancel_se)
      
      # Se um personagem já tiver sido escolhido...
      if @indice_formacao != nil
        # Cancelar apenas a primeira seleção e permanecer na Formação
        limpar_selecao_formacao
        return
      end
      
      # Retornar à janela de comandos
      @janela_de_comando.active = true
      @status_window.active = false
      @status_window.index = -1
      return
    end
    # Se o botão C for pressionado
    if Input.trigger?(Input::C)
      # Ramificação por posição do cursor na janela de comandos
      case @janela_de_comando.index
      when 1  # Habilidades
        # Se o limite de ação deste Herói for de 2 ou mais
        if $game_party.actors[@status_window.index].restriction >= 2
          # Reproduzir SE de erro
          $game_system.se_play($data_system.buzzer_se)
          return
        end
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Alternar para a tela de Habilidades
        $scene = Scene_Skill.new(@status_window.index)
      when 2  # Equipamento
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Alternar para a tela de Equipamento
        $scene = Scene_Equip.new(@status_window.index)
      when 3  # Status
        # Reproduzir SE de OK
        $game_system.se_play($data_system.decision_se)
        # Alternar para a tela de Status
        $scene = Scene_Status.new(@status_window.index)
      when 4  # Formação
        indice_atual = @status_window.index
        
        # Se ainda não houver um primeiro personagem selecionado...
        if @indice_formacao == nil
          # Reproduzir SE de OK
          $game_system.se_play($data_system.decision_se)
          
          # Guardar a posição do primeiro personagem
          @indice_formacao = indice_atual
          
          # Calcular a posição vertical da janela de seleção
          y = 15 + (@indice_formacao * 116)
          
          # Criar a janela sobre o personagem selecionado
          @janela_formacao = JanelaEscolha.new(175, y, 450, 98)
          
        # Se o jogador selecionar novamente o primeiro personagem...
        elsif @indice_formacao == indice_atual
          # Reproduzir SE de cancelamento
          $game_system.se_play($data_system.cancel_se)
          
          # Cancelar a seleção
          limpar_selecao_formacao
          
        else
          # Reproduzir SE de OK
          $game_system.se_play($data_system.decision_se)
          
          # Trocar as posições dos personagens
          atores = $game_party.actors
          primeiro_personagem = atores[@indice_formacao]
          
          atores[@indice_formacao] = atores[indice_atual]
          atores[indice_atual] = primeiro_personagem
          
          # Atualizar a janela e o gráfico do jogador
          @status_window.refresh
          $game_player.refresh
          
          # Encerrar a seleção
          limpar_selecao_formacao
        end
      end
      return
    end
  end
  
  #--------------------------------------------------------------------------
  # Limpar a seleção da Formação
  #--------------------------------------------------------------------------
  
  def limpar_selecao_formacao
    if @janela_formacao != nil
      @janela_formacao.dispose
      @janela_formacao = nil
    end
    
    @indice_formacao = nil
  end
  
end

#==============================================================================
# Compatibilidade com os índices do menu original
#==============================================================================

class Scene_Save
  
  alias somnium_menu_vxa_on_decision on_decision
  
  def on_decision(filename)
    somnium_menu_vxa_on_decision(filename)
    
    # Se o Save estiver retornando ao Menu...
    if $scene.is_a?(Scene_Menu)
      # Posicionar o cursor novamente sobre Salvar
      $scene = Scene_Menu.new(5)
    end
  end
  
  alias somnium_menu_vxa_on_cancel on_cancel
  
  def on_cancel
    somnium_menu_vxa_on_cancel
    
    # Se o Save estiver retornando ao Menu...
    if $scene.is_a?(Scene_Menu)
      # Posicionar o cursor novamente sobre Salvar
      $scene = Scene_Menu.new(5)
    end
  end
  
end


#==============================================================================
# Scene_End - Compatibilidade com o Menu VXA
#------------------------------------------------------------------------------
# Esta extensão ajusta o retorno da tela de encerramento ao Menu VXA.
# Ao cancelar, o cursor retorna corretamente para a opção Sair, no índice 6.
#==============================================================================

class Scene_End
  
  alias somnium_menu_vxa_update update
  
  def update
    somnium_menu_vxa_update
    
    # Se a tela de encerramento estiver retornando ao Menu...
    if $scene.is_a?(Scene_Menu)
      # Posicionar o cursor novamente sobre Sair
      $scene = Scene_Menu.new(6)
    end
  end
  
end

#===========================================================================
#                      Somnium System
#===========================================================================
