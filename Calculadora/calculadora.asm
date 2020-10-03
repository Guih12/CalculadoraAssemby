section .data
         msg_bem_vindo db "*** calculadora em Assembly X86 ***" 
               tam_msg_bem_vindo equ $ - msg_bem_vindo


         msg_operacoes db "(+ soma) (- subtração) (* multiplicão) (/ divisão) (0 - sair)"
               tam_msg_operacoes equ $ - msg_operacoes

         msg_numero1   db "Digite o primeiro numero: "
               tam_msg_numero1 equ $ - msg_numero1

         msg_numero2   db  "digite o segundo numero: "
               tam_msg_numero2 equ $ - msg_numero2

         msg_escolha_operacao db "escolha a operção a ser realizada: "
               tam_msg_escolha_operacao equ $ - msg_escolha_operacao

         soma equ "+" ;constantes
         subt equ "-"
         mult equ "*"
         divid equ "/"
         sair equ "0"

         msg_resultado db "Resultado: "
               tam_msg_resultado equ $ - msg_resultado
        
section .bss
         n1 resb 2
         n2 resb 2
         op resb 2   ;operacao

         result_soma resb 1
         result_subt resb 1
         result_mult resb 1
         result_divid resb 1
         resto resb 1


section .text

global _start


_start:
         mov eax, 4
         mov ebx, 1
         mov ecx, msg_bem_vindo
         mov edx, tam_msg_bem_vindo
         int 0x80
         

         ;quebraLinha
         mov eax, 4
         mov ebx, 1
         mov [ecx], byte 0xa
         mov edx, 1
         int 0x80
         
         mov eax, 4
         mov ebx, 1
         mov ecx, msg_operacoes
         mov edx, tam_msg_operacoes
         int 0x80
         
         ;quebraLinha
         mov eax, 4
         mov ebx, 1
         mov [ecx], byte 0xa
         mov edx, 1
         int 0x80
         

         LOOP:
         mov eax, 4
         mov ebx, 1
         mov [ecx], byte 0xa
         mov edx, 1
         int 0x80
         
         mov eax, 4
         mov ebx, 1
         mov ecx, msg_numero1
         mov edx, tam_msg_numero1
         int 0x80
         
         ;leitura de n1
         mov eax, 3
         mov ebx, 0
         mov ecx, n1
         mov edx, 2
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, msg_numero2
         mov edx, tam_msg_numero2
         int 0x80

         
         ;leitura de n2
         mov eax, 3
         mov ebx, 0
         mov ecx, n2
         mov edx, 2
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, msg_escolha_operacao
         mov edx, tam_msg_escolha_operacao
         int 0x80


         mov eax, 3
         mov ebx, 0
         mov ecx, op
         mov edx, 2
         int 0x80

         mov al, [op]
         cmp al, soma
         je SOMA

         cmp al, subt
         je SUBTRACAO

         cmp al, mult
         je MULTI

         cmp al, divid
         je DIVISAO

         cmp al, sair
         jmp SAIR
         
         ;opção soma
         SOMA:
         mov al, [n1]
         mov bl, [n2]
         sub al, '0'
         sub bl, '0'
         add al, bl
         add al, '0'
         mov [result_soma], al
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, msg_resultado
         mov edx, tam_msg_resultado
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, result_soma
         mov edx, 1
         int 0x80

         jmp LOOP
         
         ;opcao subtração
         SUBTRACAO:
         mov al, [n1]
         mov bl, [n2]
         sub al, '0'
         sub bl, '0'
         sub al, bl
         add al, '0'
         mov [result_subt], al
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, msg_resultado
         mov edx, tam_msg_resultado
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, result_subt
         mov edx, 1
         int 0x80
         
         jmp LOOP
         
         ;opção de multiplicação
         MULTI:
         mov eax, [n1]
         mov ebx, [n2]
         sub eax, '0'
         sub ebx, '0'
         mul ebx
         add eax, '0'
         mov [result_mult], eax
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, msg_resultado
         mov edx, tam_msg_resultado
         int 0x80


         mov eax, 4
         mov ebx, 1
         mov ecx, result_mult
         mov edx, 1
         int 0x80

         jmp LOOP
         
         ;opção de divisão
         DIVISAO:
         mov al, [n1]
         mov bl, [n2]
         sub al, '0'
         sub bl, '0'
         div bl
         add al, '0'
         add ah, '0'
         mov [result_divid], al
         mov [resto], ah
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, msg_resultado
         mov edx, tam_msg_resultado
         int 0x80

         mov eax, 4
         mov ebx, 1
         mov ecx, result_divid
         mov edx, 1
         int 0x80

         jmp LOOP

         SAIR:        
  exit:
         mov eax, 1
         int 0x80
