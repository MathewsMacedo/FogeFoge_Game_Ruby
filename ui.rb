def da_boas_vindas
	puts "Bem vindo ao Foge-Foge"
	puts "Qual o seu nome?"
	nome = gets.strip
	puts "\n\n\n\n\n\n\n"
	puts "Bem vindo ao jogo: #{nome}"
end

def desenha_mapa(mapa)

	puts mapa

end

def pede_movimento

	puts "Para onde deseja ir:"
	movimento = gets.strip
	movimento
end