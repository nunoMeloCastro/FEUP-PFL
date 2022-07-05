# README - PFL TP1
### Ângela Coelho up201907549
### Nuno Castro up202003324

## Funções implementadas e casos de teste

### Fib.hs
#### fibRec
Função que calcula o enésimo número de Fibonacci através de recursão

```
*Main> fibRec 0
0
*Main> fibRec 1
1
*Main> fibRec 10
55
```


#### fibLista
Função que calcula o enésimo número de Fibonacci através de uma lista de resultados parciais

```
*Main> fibLista 0
0
*Main> fibLista 1
1
*Main> fibLista 10
55
```


#### generateLista
Função auxiliar a fibList que gera listas de resultados parciais

```
*Main> generateLista [1,1,2,3] 0
[1]
*Main> generateLista [1,1,2,3] 1
[1,1,2,3]
*Main> generateLista [1,1,2,3] 2
[1,1,2,3,5]
```


#### fibListaInfinita
Função que calcula o enésimo número de Fibonacci através de uma lista infinita

```
*Main> fibListaInfinita 0
0
*Main> fibListaInfinita 1
1
*Main> fibListaInfinita 10
55
```


### BigNumber.hs

#### scanner
Função que recebe uma string e converte-a em BigNumber.

```
*BigNumbers> scanner "12345"
BigNumber {signal = Pos, number = [5,4,3,2,1]}
*BigNumbers> scanner "-12345"
BigNumber {signal = Neg, number = [5,4,3,2,1]}
```


#### output
Função que recebe um BigNumber e converte-oem string.

```
*BigNumbers> output (BigNumber Pos [5,4,3,2,1])
"12345"
*BigNumbers> output (BigNumber Neg [5,4,3,2,1])
"-12345"
```


#### myHead
Função devolve o primeiro elemento de uma lista ou zero se esta for vazia.

```
*BigNumbers> myHead []
0
*BigNumbers> myHead [1,2,3,4,5]
1
```


#### myTail
Função que devolve todos os elementos de uma lista excepto o primeiro.

```
*BigNumbers> myTail []
[]
*BigNumbers> myTail [1,2,3,4,5]
[2,3,4,5]
```


#### myLast
Função que devolve o último BigNumber de uma lista de BigNumbers ou o BigNumber zero se esta for vazia.

```
*BigNumbers> myLast [(BigNumber Pos [1,2,3,4,5]),(BigNumber Pos [1,2,3,4,5,6]),(BigNumber Pos [1,2,3,4,5,6,7])]
BigNumber {signal = Pos, number = [1,2,3,4,5,6,7]}
*BigNumbers> myLast []
BigNumber {signal = Zero, number = [0]}
```


#### convertToPos
Função que recebe um BigNumber negativo e devolve o simétrico.

```
*BigNumbers> convertToPos (BigNumber Neg [1,2,3,4,5])
BigNumber {signal = Pos, number = [1,2,3,4,5]}
```


#### convertToNeg
Função que recebe um BigNumber positivo e devolve o simétrico.

```
*BigNumbers> convertToNeg (BigNumber Pos [1,2,3,4,5])
BigNumber {signal = Neg, number = [1,2,3,4,5]}
```


#### convertToInt
Função que recebe um BigNumber e converte-o num inteiro.

```
*BigNumbers> convertToInt (BigNumber Zero [0])
0
*BigNumbers> convertToInt (BigNumber Pos [1,2,3])
321
*BigNumbers> convertToInt (BigNumber Neg [1,2,3])
-321
```


#### getLarger
Função que devolve o maior de dois BigNumbers.

```
*BigNumbers> getLarger (BigNumber Zero [0]) (BigNumber Pos [1])
BigNumber {signal = Pos, number = [1]}
*BigNumbers> getLarger (BigNumber Pos [1]) (BigNumber Zero [0])
BigNumber {signal = Pos, number = [1]}
*BigNumbers> getLarger (BigNumber Zero [0]) (BigNumber Neg [1])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> getLarger (BigNumber Neg [1]) (BigNumber Zero [0])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> getLarger (BigNumber Pos [1]) (BigNumber Pos [2])
BigNumber {signal = Pos, number = [2]}
*BigNumbers> getLarger (BigNumber Neg [1]) (BigNumber Neg [2])
BigNumber {signal = Neg, number = [1]}
*BigNumbers> getLarger (BigNumber Neg [1]) (BigNumber Pos [2])
BigNumber {signal = Pos, number = [2]}
*BigNumbers> getLarger (BigNumber Pos [1]) (BigNumber Neg [2])
BigNumber {signal = Pos, number = [1]}
```

#### getLargerAux
Função auxiliar de getLarger chamada quando dois BigNumbers não são iguais mas têm o mesmo comprimento.
Necessário dar reverse da lista de dígitos quando chamada para funcionar corretamente.
Compara dígitos da mesma ordem e devolve True se o primeiro BigNumber for o maior ou false se o segundo.

```
*BigNumbers> getLargerAux (BigNumber Pos [2,2,5]) (BigNumber Pos [2,2,4])
True
*BigNumbers> getLargerAux (BigNumber Pos [2,2,5]) (BigNumber Pos [2,4,4])
False
```


#### (+++)
Função que faz a concatenação das listas de dígitos de dois BigNumbers.

```
*BigNumbers> (+++) (BigNumber Zero [0]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [0,1,2]}
*BigNumbers> (+++) (BigNumber Pos []) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [1,2]}
*BigNumbers> (+++) (BigNumber Pos [3,4]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [3,4,1,2]}
```


#### removeZero
Função auxiliar que remove um zero indesejado do início de um BigNumber.

```
*BigNumbers> removeZero (BigNumber Pos [1,2,0])
BigNumber {signal = Pos, number = [1,2]}
```


#### somaBN
Função que realiza a soma de dois BigNumbers.

```
*BigNumbers> somaBN (BigNumber Neg [1,2]) (BigNumber Zero [0])
BigNumber {signal = Neg, number = [1,2]}
*BigNumbers> somaBN (BigNumber Pos [1,2]) (BigNumber Zero [0])
BigNumber {signal = Pos, number = [1,2]}
*BigNumbers> somaBN (BigNumber Zero [0]) (BigNumber Neg [1,2])
BigNumber {signal = Neg, number = [1,2]}
*BigNumbers> somaBN (BigNumber Zero [0]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [1,2]}
*BigNumbers> somaBN (BigNumber Pos [9,9]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [0,2,1]}
*BigNumbers> somaBN (BigNumber Neg [9,9]) (BigNumber Neg [1,2])
BigNumber {signal = Neg, number = [0,2,1]}
*BigNumbers> somaBN (BigNumber Pos [9,9]) (BigNumber Neg [1,2])
BigNumber {signal = Pos, number = [8,7]}
*BigNumbers> somaBN (BigNumber Neg [9,9]) (BigNumber Pos [1,2])
BigNumber {signal = Neg, number = [8,7]}
```


#### soma
Função auxiliar a somaBN. Realiza, recursivamente a soma de dois dígitos da mesma ordem de dois BigNumbers e também é encarregue do carry desta mesma.

```
*BigNumbers> soma (BigNumber Pos [1,9,9]) (BigNumber Pos [1,2]) 0
BigNumber {signal = Pos, number = [2,1,0,1]}
*BigNumbers> soma (BigNumber Pos []) (BigNumber Pos []) 2
BigNumber {signal = Pos, number = [2]}
*BigNumbers> soma (BigNumber Pos [1,2]) (BigNumber Pos []) 2
BigNumber {signal = Pos, number = [3,2]}
*BigNumbers> soma (BigNumber Pos []) (BigNumber Pos [1,9,9]) 2
BigNumber {signal = Pos, number = [3,9,9]}
*BigNumbers> soma (BigNumber Pos []) (BigNumber Pos [1,9,9]) 0
BigNumber {signal = Pos, number = [1,9,9]}
*BigNumbers> soma (BigNumber Pos [1,2]) (BigNumber Pos []) 0
BigNumber {signal = Pos, number = [1,2]}
*BigNumbers> soma (BigNumber Pos [1,2]) (BigNumber Pos [1,9,9]) 0
BigNumber {signal = Pos, number = [2,1,0,1]}
```


#### subBN
Função que realiza a subtração de um BigNumber a outro.

```
*BigNumbers> subBN (BigNumber Pos [1,2]) (BigNumber Pos [1,2])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> subBN (BigNumber Pos [1,1]) (BigNumber Pos [1,2])
BigNumber {signal = Neg, number = [0,1]}
*BigNumbers> subBN (BigNumber Pos [1,1]) (BigNumber Pos [0,1])
BigNumber {signal = Pos, number = [1]}
*BigNumbers> subBN (BigNumber Neg [1,1]) (BigNumber Neg [1,1])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> subBN (BigNumber Neg [1,1]) (BigNumber Neg [1,2])
BigNumber {signal = Pos, number = [0,1]}
*BigNumbers> subBN (BigNumber Neg [1,2]) (BigNumber Neg [1,1])
BigNumber {signal = Neg, number = [0,1]}
*BigNumbers> subBN (BigNumber Pos [1,2]) (BigNumber Neg [1,2])
BigNumber {signal = Pos, number = [2,4]}
*BigNumbers> subBN (BigNumber Neg [1,2]) (BigNumber Pos [1,2])
BigNumber {signal = Neg, number = [2,4]}
```


#### sub
Função auxiliar a subBN. Realiza a subtração recursiva entre dois dígitos da mesma ordem de um BigNumber.
Tem que ser filtrada préviamente porque esta função foi desenvolvida para receber primeiro o número maior como primeiro argumento e apenas depois o menor.

```
*BigNumbers> sub (BigNumber Pos []) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [1,2]}
*BigNumbers> sub (BigNumber Pos [1,2]) (BigNumber Pos [])
BigNumber {signal = Pos, number = [1,2]}
*BigNumbers> sub (BigNumber Pos [1,2]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = []}
*BigNumbers> sub (BigNumber Pos [1,4]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [0,2]}
```


#### mulBN
Função que realiza a multiplicação entre dois BigNumbers.

```
*BigNumbers> mulBN (BigNumber Pos [1,2]) (BigNumber Zero [0])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> mulBN (BigNumber Zero [0]) (BigNumber Neg [1,2])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> mulBN (BigNumber Pos [3,5]) (BigNumber Pos [1,2])
BigNumber {signal = Pos, number = [3,1,1,1]}
*BigNumbers> mulBN (BigNumber Neg [3,5]) (BigNumber Neg [1,2])
BigNumber {signal = Pos, number = [3,1,1,1]}
*BigNumbers> mulBN (BigNumber Neg [3,5]) (BigNumber Pos [1,2])
BigNumber {signal = Neg, number = [3,1,1,1]}
*BigNumbers> mulBN (BigNumber Pos [3,5]) (BigNumber Neg [1,2])
BigNumber {signal = Neg, number = [3,1,1,1]}
```


#### mul
Função auxiliar a mulBN. Esta função filtra casos em que o BigNumber apresenta lista vazia de dígitos antes de proceder com a multiplicação.

```
*BigNumbers> mul (BigNumber Pos [1,2,3]) (BigNumber Pos [])
BigNumber {signal = Pos, number = []}
*BigNumbers> mul (BigNumber Pos []) (BigNumber Pos [1,2,3])
BigNumber {signal = Pos, number = []}
*BigNumbers> mul (BigNumber Pos [3,2,1]) (BigNumber Pos [1,2,3])
BigNumber {signal = Pos, number = [3,8,4,9,3]}
```


#### mulAux
Função auxiliar a mul. Responsável pela multiplicação de um dígito por um BigNumber. É também responsável pelo processamento do carry resultante.

```
*BigNumbers> mulAux 3 (BigNumber Pos []) 0
BigNumber {signal = Pos, number = []}
*BigNumbers> mulAux 3 (BigNumber Pos []) 2
BigNumber {signal = Pos, number = [2]}
*BigNumbers> mulAux 3 (BigNumber Pos [1,2]) 2
BigNumber {signal = Pos, number = [5,6]}
*BigNumbers> mulAux 3 (BigNumber Pos [1,2]) 0
BigNumber {signal = Pos, number = [3,6]}
```


#### divBN
Função que realiza a divisão inteira entre dois BigNumbers e devolve um tuplo constituido por dois BigNumbers, o quociente e o resto dessa divisão.

```
*BigNumbers> divBN (BigNumber Zero [0]) (BigNumber Pos [1,2])
(BigNumber {signal = Zero, number = [0]},BigNumber {signal = Zero, number = [0]})
*BigNumbers> divBN (BigNumber Pos [3]) (BigNumber Pos [1,2])
(BigNumber {signal = Zero, number = [0]},BigNumber {signal = Pos, number = [3]})
*BigNumbers> divBN (BigNumber Pos [1,2]) (BigNumber Pos [1,2])
(BigNumber {signal = Pos, number = [1]},BigNumber {signal = Zero, number = [0]})
*BigNumbers> divBN (BigNumber Pos [1,2]) (BigNumber Pos [3])
(BigNumber {signal = Pos, number = [7]},BigNumber {signal = Zero, number = [0]})
*BigNumbers> divBN (BigNumber Pos [1,2]) (BigNumber Pos [4])
(BigNumber {signal = Pos, number = [5]},BigNumber {signal = Pos, number = [1]})
```


#### divAux
Função auxiliar a divBN. Calcula, recursivamente, o último múltiplo do segundo argumento menor ou igual ao primeiro argumento.

```
*BigNumbers> divAux (BigNumber Pos [0,3,1]) (BigNumber Pos [3,1]) 0
BigNumber {signal = Pos, number = [0,1]}
*BigNumbers> divAux (BigNumber Pos [9,5,4]) (BigNumber Pos [2,2]) 0
BigNumber {signal = Pos, number = [0,2]}
```

#### fibRecBN
Função que calcula o enésimo número de Fibonacci através de recursão para BigNumbers.

```
*BigNumbers> fibRecBN (BigNumber Zero [0])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> fibRecBN (BigNumber Pos [1])
BigNumber {signal = Pos, number = [1]}
*BigNumbers> fibRecBN (BigNumber Pos [0,2])
BigNumber {signal = Pos, number = [5,6,7,6]}
```


#### fibListaBN
Função que calcula o enésimo número de Fibonacci através de uma lista de resultados parciais para BigNumbers.

```
*BigNumbers> fibListaBN (BigNumber Zero [0])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> fibListaBN (BigNumber Pos [1])
BigNumber {signal = Pos, number = [1]}
*BigNumbers> fibListaBN (BigNumber Pos [0,2])
BigNumber {signal = Pos, number = [5,6,7,6]}
```


#### generateListaBN
Função auxiliar a fibList que gera listas de resultados parciais para BigNumbers.

```
*BigNumbers> generateListaBN [(BigNumber Pos [1]),(BigNumber Pos [1]),(BigNumber Pos [2]),(BigNumber Pos [3])] (BigNumber Zero [0])
[BigNumber {signal = Pos, number = [1]}]
*BigNumbers> generateListaBN [(BigNumber Pos [1]),(BigNumber Pos [1]),(BigNumber Pos [2]),(BigNumber Pos [3])] (BigNumber Pos [1])
[BigNumber {signal = Pos, number = [1]},BigNumber {signal = Pos, number = [1]},BigNumber {signal = Pos, number = [2]},BigNumber {signal = Pos, number = [3]}]
*BigNumbers> generateListaBN [(BigNumber Pos [1]),(BigNumber Pos [1]),(BigNumber Pos [2]),(BigNumber Pos [3])] (BigNumber Pos [2])
[BigNumber {signal = Pos, number = [1]},BigNumber {signal = Pos, number = [1]},BigNumber {signal = Pos, number = [2]},BigNumber {signal = Pos, number = [3]},BigNumber {signal = Pos, number = [5]}]
```


#### fibListaInfinitaBN
Função que calcula o enésimo número de Fibonacci através de uma lista infinita para BigNumbers.

```
*BigNumbers> fibListaInfinitaBN (BigNumber Zero [0])
BigNumber {signal = Zero, number = [0]}
*BigNumbers> fibListaInfinitaBN (BigNumber Pos [1])
BigNumber {signal = Pos, number = [1]}
*BigNumbers> fibListaInfinitaBN (BigNumber Pos [0,2])
BigNumber {signal = Pos, number = [5,6,7,6]}
```


#### safeDivBN
Função que deteta a divisão de um BigNumber por zero recorrendo ao monad Maybe. Caso o divisor seja diferente de zero chama a função divBN.

```
*BigNumbers> safeDivBN (BigNumber Pos [1,2,3]) (BigNumber Zero [0])
Nothing
*BigNumbers> safeDivBN (BigNumber Pos [1,2,3]) (BigNumber Pos [1,1])
Just (BigNumber {signal = Pos, number = [7,2]},BigNumber {signal = Pos, number = [4,2]})
```


## Estratégias utilizadas para a tarefa 2

### BigNumber
Pretendia-se que o tipo BigNumber representasse um número, positivo ou negativo, como uma lista dos seu dígitos.
Para tal, definimos que um BigNumber seria constituido pelo nome do tipo BigNumber seguido do seu sinal (positivo ou negativo) e, por fim, a lista dos seus dígitos em ordem invertida.

### scanner
A função scanner tem como objetivo a conversão de Strings em BigNumbers. Para tal, recorremos a alternativas com guardas para determinar o primeiro elemento da cadeia de carateres. Se este fosse um '-' significa que o número é negativo e portanto é convertida num BigNumber negativo. Caso contrário, procede-se com a conversão num BigNumber positivo.

### output
A função output tem o objetivo oposto da scanner, converter de BigNumber para String.
Através de pattern-matching, indentifica-se qual o sinal do BigNumber e procede-se com a conversão conforme este mesmo.

### somaBN
Para a implementação da função somaBN recorreu-se a pattern-matching, alternativas com guardas e recursão.
Iniciou-se com a implementação para números positivos apenas e só depois se expandiu para os restantes casos.
O procedimento consiste em somar os dígitos de mesma ordem, recursivamente, até que não hajam mais.
No caso de haver carry da soma, este é passado na recursão e adicionado na soma seguinte.
Caso haja um número de menor ordem que o outro, quando se esgotam os dígitos do menor, completa-se o resultado com os dígitos restantes do número de ordem superior mas, obviamente, tendo em atenção o carry.
Para a expansão, de modo a contemplar também soma de números negativos e outras combinações, recorremos à função subBN que será explicada de seguida.

### subBN
Para a implementação da função subBN recorreu-se a pattern-matching, alternativas com guardas e recursão.
Tal como na função anterior, consideramos que para contemplar todas as combinações de sinais em subtrações utilizaríamos a função somaBN para processar os casos em que uma subtração se torna uma soma. Implementou-se também uma função getLarger, que determina o maior de dois BigNumbers, com o intuito de facilitar a avaliação de proceder com uma soma ou subtração.  
Novamente, iniciou-se a implementação a contemplar apenas números positivos.
O procedimento consiste em subtrair dígitos da mesma ordem, recursivamente. Quando o segundo dígito é superior ao primeiro, soma-se 10 a este primeiro e só depois se dá a subtração. Caso contrário esta processa-se normalmente.


### mulBN
A ideia para implementação desta função foi recorrer a pattern matching, alternativas com guardas e recursão.
Começamos por implementar apenas para números positivos e depois procedemos com a expansão para as restantes situações.
O procedimento consiste em obter o dígito de menor ordem do primeiro número e efetuar a multiplicação com o segundo recursivamente até que não hajam mais números para multiplicar.
Também, recursivamente se procede a multiplicação do dígito retirado por cada dígito de segundo número até que estes se esgotem.
Caso se verifique que ao efetuar uma multiplicação irá existir carry, este será passado como argumento e adicionado ao resultado da multiplicação seguinte. Ao passar para a multiplicação com um dígito de ordem superior é se adicionado na recursão um zero ao início da lista resultante, como que a múltiplicar por 10, para que, no final as sucessivas somas do resultados de cada multiplicação batam certo.

### divBN
A estratégia para a implementação consistiu em recorrer a pattern matching, alternativas com guardas e recursão.
Inicialmente, antes de passar para a divisão em si, é feita uma filtragem de argumentos.
A divisão fica encarregue para uma função auxiliar (divAux) que calcula, recursivamente, o último múltiplo do segundo argumento menor ou igual ao primeiro argumento. Esse valor é correspondente ao quociente que depois é utilizado para obtenção do resto.


## Números de Fibonacci (Integer vs BigNumber)
Para todas as situações a conclusão foi a mesma. Em termos de performance, tempo e memória verificou-se que as funções a trabalhar com Integers são mais eficientes que as que utilizam BigNumbers.
Para valor limite assumimos valores para quais o tempo de espera era de tal maneira prolongado que consideramos não ser funcional a utilização desta solução para a sua obtenção.
De notar que para obtenção do número de Fibonacci através de programação dinâmica conseguimos obter um valor máximo superior para a versão de BigNumbers. Quando esse mesmo valor foi experimentado na versão para Integer obtivemos um Segmentation fault error.

| Função             | Valor máximo |
|--------------------|--------------|
| fibRec             | 42           |
| fibRecBN           | 40           |
| fibLista           | 20000        |
| fibListaBN         | 25000        |
| fibListaInfinita   | 5000000      |
| fibListaInfinitaBN | 100000       |

	>fibRec

	```
	*Main> fibRec 40
	102334155
	(254.66 secs, 165,000,423,200 bytes)
	*Main> fibRec 42
	267914296
	(1611.08 secs, 431,976,603,144 bytes)
	```


	>fibRecBN

	```
	*BigNumbers> fibRecBN (BigNumber Pos [40])
	BigNumber {signal = Pos, number = [5,5,1,4,3,3,2,0,1]}
	(1350.67 secs, 935,509,906,304 bytes)
	```


	>fibLista

	```
	*Main> fibLista 20000
	25311623237323612422401550035206072917663564858024852789519298419913127817605413152301534234637588316374434882192110376890336735314627428853297240715551876180269316304491931589227713316423020303319710986892357808434782585027792002936356518974833096860428609963644435145587721560436914041558195729849717542785131124879858927182295933294835785314191488053802816242609003629935569166386139399770746850161882585843123291395263935580968408129704229524185589918557723068824425748555892371652199122382013111847490751373229876560498663053669137349244258226813389665074638551802362835824098611992123238359478911437654149133450084560220094557042108916377919112654751677697...
	(255.33 secs, 17,551,330,184 bytes)

	*Main> fibLista 25000
	Segmentation fault (core dumped)
	```


	>fibListaBN

	```
	*BigNumbers> fibListaBN (BigNumber Pos [0,0,0,0,2])
	BigNumber {signal = Pos, number = [5,2,1,3,9,0,3,1,2,1,7,9,3,8,6,7,5,8,9,3,6,0,6,4,0,2,2,4,7,1,5,0,7,3,6,5,6,9,0,5,2,1,6,1,5,7,6,3,6,1,8,2,1,9,6,1,4,1,2,6,7,4,9,8,6,9,7,9,2,7,2,6,7,8,4,3,2,8,5,1,9,8,9,3,1,1,4,3,2,0,2,0,9,1,6,5,7,8,5,8,0,7,5,0,5,3,3,8,2,2,0,2,7,9,0,4,8,4,5,9,8,2,9,7,6,6,3,1,1,8,9,9,7,8,9,7,7,8,9,1,6,7,7,5,3,5,6,5,3,6,5,0,3,7,8,7,6,5,3,1,2,3,4,5,8,6,6,8,2,6,4,7,1,8,8,2,6,6,2,8,4,4,0,8,8,4,0,2,0,7,9,7,7,1,0,3,6,8,7,7,3,0,9,0,6,9,0,7,3,8,8,9,6,1,6,2,2,0,2,8,6,9,6,9,0,8,5,5,1,0,3,9,2,4,2,5,9,3,0,8,4,1,7,6,1,8,5,8,9,1,2,7,9,7,0,5,5,0,4,5,6...
	(433.30 secs, 71,938,028,512 bytes)
	*BigNumbers> fibListaBN (BigNumber Pos [0,0,0,5,2])
	BigNumber {signal = Pos, number = [5,7,8,6,9,5,7,7,7,1,3,2,7,8,5,6,3,0,7,7,3,1,4,3,7,0,8,6,2,2,6,1,3,8,3,8,4,4,5,7,6,4,3,1,6,0,3,4,6,9,1,9,9,8,6,2,5,3,5,2,3,0,9,9,6,0,1,0,0,9,7,4,3,4,6,9,4,4,4,7,1,2,8,7,1,5,4,3,1,9,1,6,9,3,3,3,4,6,9,8,3,3,5,9,6,9,1,2,2,6,0,1,3,9,5,5,4,8,6,0,6,5,9,7,6,8,5,5,3,7,8,7,6,3,4,8,4,0,8,9,1,9,7,1,3,1,3,6,7,5,5,9,9,8,6,8,0,3,0,3,6,0,3,0,7,2,6,3,6,3,5,7,2,7,6,3,5,8,7,1,7,8,9,3,7,3,3,4,3,0,0,1,5,0,9,3,3,0,1,5,7,7,3,6,6,9,6,4,9,0,4,1,1,1,6,7,3,9,8,2,3,4,9,8,1,2,5,3,8,8,3,0,0,7,5,2,9,4,8,1,2,9,3,5,1,7,6,0,7,4,1,6,6,8,8,4,7,8,3,5,6,2,2,6,9,4,0,3,5,1,1,6,9,9,9,9,6,0,4,3,1,2,0,7,9,2,8,7,1,9,0,0,5,5,3,2,4,7,7,4,0,8,2,1,9,0,6,9,6,6,2,4,5,3,1,6,4,2,9,2,2,7,7,9,9,6,1,5,1,1,5...
	(3554.50 secs, 112,500,144,352 bytes)
	```


	>fibListaInfinita

	```
	*Main>  fibListaInfinita 100000
	25974069347221724166155034021275915414880485386517696584724770703952534543511273686265556772836716744754637587223074432111638399473875091030965697382188304493052287638531334921353026792789567010512765782716356080730505322002432331143839865161378272381247774537783372999162146340500546698603908627509966393664092118901252719601721050603003505868940285581036751176582513683774386849364134573388343651587754253719124105003321959913300622043630352137565254218239986908485563740801792517616293917549634585586163007628199...
	(1.38 secs, 474,189,560 bytes)
	*Main> fibListaInfinita 5000000
	71082859720585272369711719561721532204351224908624778809444940633648108011774800240652110207174636463676909320641039717098819243220720917683988549034026064783291162472780077538262977104247662771490978089466257903322750240253760671810477659409029943408249991941969274321601608582573523104869378931889852729678367049311215254554575840140944580911869037230949917181855394711707471...
	(735.50 secs, 1,098,298,900,736 bytes)
	```


	>fibListaInfinitaBN

	```
	*BigNumbers> fibListaInfinitaBN (BigNumber Pos [0,0,0,0,0,1])
	BigNumber {signal = Pos, number = [5,7,8,6,4,7,8,2,4,3,5,6,4,7,3,5,9,8,9,4,3,2,6,3,6,3,2,9,8,2,0,8,7,9,9,6,5,1,0,0,7,9,9,0,6,5,5,3,4,7,2,6,6,1,3,5,9,8,1,0,9,3,9,3,8,8,3,8,3,4,1,5,3,0,6,5,9,8,0,6,6,5,3,6,1,2,3,2,7,5,5,3,4,0,3,1,9,5,2,9,0,2,5,1,1,8,8,7,1,2,4,8,9,7,6,1,1,5,2,1,8,3,9,3,9,1,9,8,7,9,2,9,3,2,9,0,0,2,4,0,7,1,0,0,9,4,8,5,8,5,3,7,8,4,0,6,6,6,8,0,7,2,0,6,0,8,0,9,1,2,6,5,8,0,5,3,8,3,0,1,3,1,5,2,1,1,0,4,0,3,9,8,1,9,9,6,4,2,0,5,6,3,1,2,0,6,7,8,2,6,9,8,4,2,4,4,5,0,2,4,8,3,6,6,1,1,3,4,3,7,8,0,7,4,6,0,6,7,8,4,2,2,9,3,9,2,0,3,6,5,1,8,1,9,6,9,2,2,4,2,2,3,9,6,5,5,5,4,6,5,0,6,8,6,2,0,0,5,9,4,3,7,8,3,9,4,0,6,3,5,9,1,3,7,7,5,9,0,8,7,9,0,6,4,4,6,4,9,9,8,4,4,1,8,3,3,9,9,0,9,7,6,4,1,5,4,4,6,7,9,9,0,7,9,3,4,2,7,0,2,6,0,3,5,3,9,3,4,0,0,1,0,5,4,5,3,5,2,5,0,6,7,4,7,8,9,9,0,1,0,6,9,3,1,5,8,7,5,3,2,6,0,5,4,1,0,7,6,8,5,8,8,0,7,3,5,4,5,8,5,2,0,1,1,8,7,9,1,8,3,1,4,0,2,4,8,1,0,9,3,7,7,2,8,9,5,7,0,9,8,8,0,7,3,8,0,6,1,2,2,2,8,3,5,5,8,4,0,9,3,4,0,4,7,8,2,3,3,9,1,2,4,3,4,6,9,4,2,1,8,8,8,9,6,0,7,6,7,7,3,9,7,4,9,2,4,1,5,9,5,6,1,3,1,3,0,1,1,1,4,9,6,7,6,2,1,3,4,8,9,8,0,8,1,4,3,5,6,7,4,2,9,7,3,0,6,7,6,2,7,5,5,1,2,1,5,6,7,0,4,4,8,5,7,2,4,2,4,2,9,8...
	(2095.50 secs, 1,401,370,916,088 bytes)
	```
