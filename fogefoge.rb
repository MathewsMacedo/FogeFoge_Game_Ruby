require_relative 'ui'
require_relative 'heroi'

def le_mapa(numero)
	arquivo = "mapa#{numero}.txt"
	texto = File.read arquivo
	mapa = texto.split "\n"
end


def encontra_jogador(mapa)
	caractere_do_heroi = "H"
	mapa.each_with_index do |linha_atual, linha|
		coluna_do_heroi = linha_atual.index caractere_do_heroi
		if coluna_do_heroi
			jogador = Heroi.new
			jogador.linha = linha
			jogador.coluna = coluna_do_heroi
			return jogador
		end

	end
	nil
end




def posicao_valida?(mapa, posicao)

	estourou_linhas = posicao[0] < 0 || posicao[0] >= mapa.size
	estourou_colunas = posicao[1] < 0 || posicao[1] >= mapa[0].size

	if estourou_linhas
		return false
	end
	if estourou_colunas
		return false
	end
	valor_atual = mapa[posicao[0]][posicao[1]] 
	if valor_atual == "X" || valor_atual == "F"
		return false
	end
	true
end

def soma_vetor(movimento,posicao)
	[posicao[0] + movimento[0],posicao[1] + movimento[1]]
end

def posicoes_validas(mapa,novo_mapa,posicao)
	posicoes = []
	movimentos = [[+1,0],[0,+1],[-1,0],[0,-1]]
	movimentos.each do |movimento|
		nova_posicao = soma_vetor movimento, posicao
		if posicao_valida?(mapa,nova_posicao) && posicao_valida?(novo_mapa,nova_posicao)
			posicoes << nova_posicao
		end
	end
	posicoes
end


def move_fantasma(mapa, novo_mapa, linha, coluna)

	posicoes = posicoes_validas mapa, novo_mapa, [linha,coluna]
	return	if posicoes.empty?
	aleatoria = rand posicoes.size
	posicao = posicoes[aleatoria]

	mapa[linha][coluna] = " "
	novo_mapa[posicao[0]][posicao[1]] = "F"
end


def copia_mapa(mapa)

	novo_mapa = mapa.join("\n").tr("F"," ").split("\n")

end

def move_fantasmas(mapa)

	caractare_fantasma = "F"
	novo_mapa = copia_mapa mapa
	mapa.each_with_index do |linha_atual, linha|
		linha_atual.chars.each_with_index do  |caractare_atual, coluna|
			eh_fantasma = caractare_atual == caractare_fantasma
			if eh_fantasma
				move_fantasma mapa, novo_mapa, linha, coluna
			end
		end

	end

	novo_mapa

end



def joga(nome)



	mapa = le_mapa 2

	while true
		desenha_mapa mapa
		direcao = pede_movimento
		heroi = encontra_jogador mapa
		nova_posicao = heroi.calcula_nova_posicao direcao
		next if not posicao_valida? mapa,nova_posicao.to_array
		heroi.remove_do mapa
		nova_posicao.coloca_no mapa
		mapa = move_fantasmas mapa
		if not encontra_jogador mapa
			game_over
			break
		end

	end
	

end

def inicia_fogefoge
	nome = da_boas_vindas
	joga nome
end