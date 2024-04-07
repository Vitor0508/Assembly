# Assembly
Programa desenvolvidos na disciplina de Microprocessadores e Microcontroladores

02 - Programação Assembly - Acionamento sequencial(4 luzes)
Montar um programa para interface McLab 1 para realizar as seguintes funcionalidades:
- Ao iniciar o programa, os LEDS RB0, RB1, RB2 e RB3 devem estar apagados
- Como os leds apagados, apenas o led RB0 pode ser aceso, através do acionamento da chave RA1, nenhuma outra chave tem ação no momento.
- Com o led RB0 aceso, apenas o led RB1 pode ser aceso através do acionamento da chave RA2, nenhuma outra chave tem ação no momento.
- Com o led RB1 aceso, apenas o led RB2 pode ser aceso através do acionamento da chave RA3, nenhuma outra chave tem ação no momento.
- Com o led RB2 aceso, apenas o led RB3 pode ser aceso através do acionamento da chave RA4, nenhuma outra chave tem ação no momento.
- Após o acionamento de todos os leds, a chave RA1 é usada para apagar o led RB0, e apenas ela tem esta função.
- Após desligar o led RB0, é permitido desligar o led RB1 através da chave RA2, apenas esta opção é disponibilizada.
- Após desligar o led RB1, é permitido desligar o led RB2 através da chave RA3, apenas esta opção é disponibilizada.
- Após desligar o led RB2, é permitido desligar o led RB3 através da chave RA4, apenas esta opção é disponibilizada.
- Com isso, volta-se ao estado inicial, todos os leds apagados e é permitido a nova sequência

03 - Acionamento de motor com reversão
Um engenheiro foi contratado para automatizar um sistema de partida de motor com reversão. Para isso usou o módulo McLab1 para simular a operação do programa de controle.

O sistema de controle consiste basicamente na energização de um motor através de 2 saídas do PIC, uma para acionar no sentido horário e outra no sentido anti-horário. O sistema também tem algumas sinalizações conforme mostrado abaixo, bem como as entradas e saídas usadas no módulo:

Entradas:
- RA1 - Botão LIGA HORÁRIO - liga o motor no sentido horário.
- RA2 - Botão LIGA ANTI-HORÁRIO - liga o motor no sentido anti-horário.
- RA3 - Botão DESLIGA - desliga o motor em qualquer situação - este botão tem prioridade sobre os botões LIGA, ou seja, se ele estiver pressionado os "LIGA" não são lidos.
- RA4 - Botão EMERGÊNCIA/PROTEÇÃO - desliga o motor, caso esteja ligado, e bloqueia o seu funcionamento até o que o botão DESLIGA seja acionado.

Saídas:
- RA0 - Indicação de motor ligado (independente do sentido) - ativo quando o motor é acionado, independente do sentido.
- RB0 - Indicação/acionamento de motor ligado - sentido horário, aciona o relé que comanda a conexão para que o motor gire no sentido horário.
- RB1 - Indicação/acionamento de motor ligado - sentido anti-horário, aciona o relé que comanda a conexão para que o motor gire no sentido anti-horário.
- RB2 - Indicação de motor desligado, ativo quando o motor estiver parado.
- RB3 - Indicação de emergência/proteção acionado, ativo quando a emergência for ativado.

Clock: 4MHz

Funcionamento:
- ao energizar, nenhum acionamento do motor deve estar ativo, somente a indicação de motor desligado.
- com o motor não acionado, o motor pode ser acionado em qualquer sentido, horário ou anti-horário, as respectivas indicações devem ser ativas simultaneamente quando o motor for acionado.


04 - Contador de 0 a 9 - progressivo/regressivo 

Modificar o programa contador de 0 a 9, para interface McLab1, para realizar as seguintes tarefas:
- o botão RA1 reinicializa a sequência, ou seja, volta a indicar "zero" no display;
- o botão RA2, contagem progressiva, a cada acionamento do botão;
- o botão RA3, contagem regressiva, a cada acionamento do botão;
- o botão RA1 tem prioridade sobre os outros, ou seja, se ele estiver pressionado o contador não conta para cima nem para baixo.
- uma vez ativo em uma direção, horário ou anti-horário, não poderá ter a direção alterada enquanto em funcionamento, para que possa inverter o sentido é necessário, primeiro, desligar o motor.

- quando um acionamento de emergência, RA4, for ativado, o motor deve ser desligado, caso esteja em funcionamento, e o religamento bloqueado até que o botão DESLIGA seja acionado. O acionamento do botão DESLIGA permite reconhecer que houve uma emergência e permite que o motor seja novamente religado.

05 - Pisca pisca duplo

Montar um programa em Assembly que acione um pisca pisca na saída RA0. Use o módulo McLab1.

Ao iniciar o sistema, a saída RA0 deve estar apagada.

Para acionar o pisca um dos botões devem ser acionado, RA1 ou RA2.

O botão RA3 desliga os pisca-piscas.

Somente pode ser acionado qualquer um dos piscas se estiver parado, isto é, se for acionado o pisca com frequência de 2HZ e desejar acionar o de 5Hz, é necessário desligar o pisca através do botão RA3 antes de acionar o botão da outra frequência.

As frequências são:
RA1 => 2Hz

06 - Contador 00a99

Montar um programa em Assembly, baseado no módulo McLab1, que execute a contagem de 00 a 99, de  forma crescente e decrescente. O contador deve iniciar em “00” ao ser ligado e os comandos  devem ser dados pelos seguintes botões:

o botão RA1 faz com que a contagem crescente seja iniciada, o incremento deve ser automático com intervalo de 1s;
o botão RA2, faz com que a contagem decrescente seja iniciada, o decremento deve ser automático com intervalo de 1s;
o botão RA3, para o contador e tem prioridade sobre os outros, isto é, se estiver pressionado, os botões RA1 e RA2 não acionam a contagem;
o botão RA4, zera o contador e tem prioridade sobre os outros, isto é, se estiver pressionado, os botões RA1 e RA2 não acionam a contagem;
a mudança de sequência crescente para decrescente só pode ser feita se o contador estiver parado;
o tempo de varredura dos displays multiplexados deve ser de 8ms, ou seja, cada display deve ficar aceso por 4ms.
Obs: quando o contador chegar a 99 ele retorna a 00 caso a contagem seja crescente e, quando chegar a 00, ele retorna a 99 se a contagem for decrescente.

Bom programa.
Clock: 4MHz

RA2 => 5Hz

Clock: 4MHz
