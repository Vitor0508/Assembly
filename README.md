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

- uma vez ativo em uma direção, horário ou anti-horário, não poderá ter a direção alterada enquanto em funcionamento, para que possa inverter o sentido é necessário, primeiro, desligar o motor.

- quando um acionamento de emergência, RA4, for ativado, o motor deve ser desligado, caso esteja em funcionamento, e o religamento bloqueado até que o botão DESLIGA seja acionado. O acionamento do botão DESLIGA permite reconhecer que houve uma emergência e permite que o motor seja novamente religado.
