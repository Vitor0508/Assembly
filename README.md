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
