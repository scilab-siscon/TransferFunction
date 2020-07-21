//Universidade Veiga de Almeida
//Desenvolvido por:Gabryel Gouveia de Jesus Souza
//Idealizado:Gabryel Gouveia de Jesus Souza
//Matricula:20171102722
//Data da ultima modificação:17/07/2020
//Nome do script:Calcula função de transferencia para 
//   sistemas em série, em paralelo e em feedback além
//   de calcular a estabilidade do circuito

//Bibliografia:
//help.scilab.org/
// Modern Control Engineering,5nd edition, by Katsuhiko Ogata



//Inicio do script 
clc
clear


//define o polinômio com a variavel 's'
s=poly(0,'s');


//flag do loop
volta = 1;

//loop principal do programa
while(volta == 1) 

qtd = input("Digite a Quantidade de elementos   :")

sel=input("digite (se) para serie,(p) para paralelo ou (f) para feedback   :","s")
    
//inicializa o primeiro vetor com uma função de tranfência qualquer
  A=[0,1;0,0];B=[1;1];C=[1,1];
  gss = syslin('c',A,B,C);
  gs(1) = ss2tf(gss); 

n=qtd;
for i=1:n
  gs(i)=type(2);
  
  printf('Digite a função do bloco %g',i)
  
  f = input("Função :");
  
 
  
  
  gs(i) = syslin('c',f);
  
    

end
 


    
 //calcula feedback com apenas um bloco  //editado por gabryel gouveia 17/07/2020
 if sel == 'f' & qtd == 1 
  resp=0
  i=1
  resp = 1/gs(i);
  respo = (resp + 1);
  disp(respo)
  resp = 1/respo;
 end
                                    //fim da edição

//calcula feedback
 if sel == 'f' & qtd <> 1 //editado por gabryel gouveia 17/07/2020
 
 n=qtd   //editado por gabryel gouveia 13/07/2020
 resp=0  //fim da edição
  for i=1:(n-1)
  resp = gs(i) /. gs(i+1);
  end
 end 

//calcula serie
if(sel == 'se') then
resp=1
 for i=1:n
   resp = resp * gs(i);
   
 end

end
 
//calcula paralelo 
if(sel == 'p') then
resp=0
 for i=1:n
   resp = resp + gs(i);
 end

end

printf('    Função de Transferência \n')
disp(resp)

locus=input('Deseja calcular a estabilidade do circuito ?','s')
ulocus=convstr(locus,"u");

if(ulocus == 'S')then
 clf();
 respo=input('O valor de K é conhecido?','s')
 
 urespo=convstr(respo,"u");
 
 equ=syslin('c',resp);
  

  if(urespo == 'S') then
   k=input('informe o ganho  :');

   plzr(equ);
   r=routh_t(equ,k);

   printf('tabela de routh')
   disp(r)
  end

if(urespo =='N') then
 kmax=input('informe o maximo ganho');
  
 evans(equ,kmax);
 
  //plotagem do grafico 
  sgrid('purple')
 [Ki,s]=kpure(equ) // Gains that give pure imaginary closed loop poles
  plot([real(s) real(s)],[imag(s) -imag(s)],'*r')

  [Kr,s]=krac2(equ)
 
end


    
    
end

retorno=input("Deseja fazer outra operação(S/N)?","s")

ret=convstr(retorno,"u");

 if (ret == 'S')then
  volta=1
 end
 
 if(ret == 'N')then
  volta=0
  printf('fim do programa')
 end
 
//'end' referente ao while 
end 
// fim do script
