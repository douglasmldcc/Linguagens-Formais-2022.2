#Palavra = [ '0','1', '0','0','1']
# Alfabeto que será aceito
Alfabeto=['0','1']

# Linguaguem 1: 
# Tem como estado final Q2, estado inicial Q0,
# E tambem a discrição de cada transição apartir de todos os estados
Linguagem_a = {
      'inicial' : 'Q0',
      'final' : 'Q2',
      'Q0' : {'0' : 'Q1', '1' : 'Q0'},
      'Q1' : {'0' : 'Q0', '1' : 'Q2'},
      'Q2' : {'0' : 'Q2', '1' : 'Q1'},
      }
# Linguaguem 1: 
# Tem como estado final S2, estado inicial S0,
# E tambem a discrição de cada transição apartir de todos os estados
Linguagem_b = {
      'inicial': 'S0',
      'final'  : 'S0',
      'S0' : {'0' : 'S0', '1' : 'S1'},
      'S1' : {'0' : 'S2', '1' : 'S0'},
      'S2' : {'0' : 'S1', '1' : 'S2'},
      }


# Esta função recebe uma linguagem e diz se ela é valida ou não
def verifica_linguagem(linguagem):
   # Primeiro testa se ela é A ou B, e se não
   if    linguagem == "A" : linguagem = Linguagem_a
   elif  linguagem == "B" : linguagem = Linguagem_b
   else: 
      # Ele printa que a linguagem é invalida e fecha o programa
      print("\nLinguagem invalida")
      exit()
   # Ela retorna a propria linguagem 
   return linguagem

# Esta função recebe uma palavra, e tem a finalidade de checar se a palavra pertence ao alfabeto
def verifica_palavra(palavra):
   # A variavel valida começa verdadeira,
   # e se torna falsa se um elemento não pertencer ao alfabeto
   valida = True
   
   # While remove todos os espaços da lista
   while(" " in palavra): palavra.remove(" ")
   # For vai percorrer todos os elementos da lista,   
   for i in palavra:
      # Um a um vai conferir se eles estão no alfabeto.
      # Se um não estiver, valida se forna falso,
      if i not in Alfabeto: valida = False
   
   if valida == False:
      # Devolve ao Usuário a mensagem que a palavra não existe no alfabeto 
      print("Palavra não existe nesse alfabeto\n")
      # Encerra o programa com exit()
      exit()
   # Retorna a palavra sem os espaços
   return palavra

# Esta função recebe uma palavra e uma linguagem
# ela percorre todos os estados e envia ao ultimo estado
# confere se ele é o estado final
def verificar(palavra,linguagem):
   # descobre qual o estado inicial  
   inicial = linguagem['inicial']
   # print("Estado inical: ", inicial)
   # descobre qual o estado inicial
   final = linguagem['final']
   #print("Estado final: ", final,"\n")

   estado = inicial
   i = 0
   # For vai percorrer todos os elementos da palavra
   # e enviar para cada estado até chegar no final
   for l in palavra:
      
      # separa os caminhos do estado atual
      q = linguagem[estado]
      print(i," - Estado atual: ", estado, " : ", q)
      # pega como novo estado o caminho escolhido
      estado = q[palavra[i]]   
      
      i = i+1
   print("Ultimo estado: ", estado,"\n")
   #printa se a palavra faz ou não parte da linguagem
   if estado == final: print("Palavra faz parte da linguagem")
   else: print("\nPalavra não faz parte da linguagem")
   return 

# Recebe uma variavel para linguagem
linguagem = (input("\nEntre com uma linguagem [A/B]: ")).upper()
# Chama a função verifica_linguagem() e retorna a linguagem
linguagem = verifica_linguagem(linguagem)
# Recebe uma variavel para palavra
palavra = list(input("\nEntre com uma palavra separada por espaços: "))
# Chama a função verifica_palavra() e retorna a palavra
palavra = verifica_palavra(palavra)
print(palavra,"\n")

# Chama a função verificar() e percorre todos os estados, e retorna se é ou não parte da linguagem
verificar(palavra,linguagem)



