SET SERVEROUTPUT ON


-------------------------laço for com condicional
BEGIN
    FOR poke IN (select numero id, nome n, hp h, ataque a, defesa d from pokemons p 
                where p.tipo1 = 'grass' OR p.tipo1 = 'psychic' order by id) LOOP
        dbms_output.put_line(
        'O pokemon ' || poke.id ||'-' || poke.n 
        || ' tem ' || poke.h || ' de HP, '
        || poke.a || ' de ataque,'
        || 'e ' || poke.d || ' de defesa');  
    END LOOP;
END;


BEGIN
    FOR rec_empregados IN (select dname, count(dname) c from emp e, dept d  where e.deptno = d.deptno group by dname order by c) LOOP
        
        dbms_output.put_line('O departamento ' || rec_empregados.dname || ' tem ' || rec_empregados.c || ' funcionários');  
        
    end loop;
    
end;

--essa eh a condicao ->   where e.deptno = d.deptno
---------------------------------------------------------------

 
DECLARE 
poke pokemons%rowtype;
BEGIN
SELECT * INTO poke FROM pokemons WHERE numero = 1;
    FOR i in /*REVERSE*/ 1..length(poke.nome) LOOP
    dbms_output.put_line(substr(poke.nome, i, 1));
    END LOOP;
END;

/*
B           r
u           u
l           a
b           s
a           a
s           b
a           l
u           u
r           B
*/

---------------------------------------------------------------

declare
poke pokemons%rowtype;
begin
select * into poke from pokemons where numero = 1;
dbms_output.put_line('Nome: ' || poke.nome || chr(10) || 'Tipo: ' || poke.tipo1 || chr(10) || 'Hoje é: '|| TO_CHAR (SYSDATE, 'fmDay, DD/Month/YYYY'));
end;

-- Nome: Bulbasaur
-- Tipo: grass
-- Hoje e: Sabado, 28/Maio/2022


declare
poke pokemons%rowtype;
begin
select * into poke from pokemons where numero = 150;
    dbms_output.put_line('Nome: ' || poke.nome || chr(10) || 'Tipo: ' || poke.tipo1 || chr(10) || 'Hoje é: '|| TO_CHAR (SYSDATE, 'fmDay, DD/Month/YYYY'));
    IF poke.tipo1 = 'grass' OR poke.tipo2 = 'grass' 
    THEN dbms_output.put_line('Um dos tipos e de grama...');
    ELSE dbms_output.put_line('Nao e grama!');
    END IF;
end;

-- Nome: Mewtwo
-- Tipo: psychic
-- Hoje e: Sabado, 28/Maio/2022
-- Nao e grama!


DECLARE 
poke pokemons%rowtype;
quantidade NUMBER;
letra VARCHAR(2);
BEGIN
letra:= 'a';
SELECT * INTO poke FROM pokemons WHERE numero = 1;
SELECT REGEXP_COUNT (poke.nome, letra) INTO quantidade FROM dual;
dbms_output.put_line('A letra: ' || letra || ' aparece '|| quantidade || ' vezes na palavra: ' || poke.nome);
END;

-- A letra: a aparece 2 vezes na palavra: Bulbasaur














































SET SERVEROUTPUT ON

-- declarando e imprimindo uma variavel na tela
DECLARE
    variavel_nome VARCHAR(30);
BEGIN 
    variavel_nome := 'Marquinhos';
    DBMS_OUTPUT.PUT_LINE ('Ola, ' || variavel_nome);
    -- Ola, Marquinhos
END;




-- atribuindo um dado que esta dentro da tabela para a minha variavel de acordo com a condicao que eu quiser
DECLARE
    minha_variavel VARCHAR(30);
BEGIN
    SELECT coluna_da_tabela INTO minha_variavel FROM nome_da_tabela WHERE condicao_que_eu_quero;
    DBMS_OUTPUT.PUT_LINE (minha_variavel);
END;




-- adicionando uma mascara ao valor da variavel
DECLARE
    texto VARCHAR(30);
    dinheiro NUMBER(7,2) := 69000.99;
BEGIN
    texto := 'Saldo';
    DBMS_OUTPUT.PUT_LINE(texto || ': ' || dinheiro);
    -- Saldo: 69000,99
    DBMS_OUTPUT.PUT_LINE(texto || ' ' || TO_CHAR(dinheiro, 'L99G999D99'));
    -- Saldo          R$69.000,99
END;




-- declarar uma variavel not null sem inicializar dara erro
DECLARE
    v_dptno NUMBER(2) NOT NULL;
    -- erro
    v_dptno NUMBER(2) NOT NULL := 10;
    -- valor de v_dptno sera 10




-- delimitador literal de uma string (uso do apostrofo)
DECLARE
    evento VARCHAR(20);
BEGIN
    evento := q'!Saint Patrick's day!';
    DBMS_OUTPUT.PUT_LINE('Eu adoro o ' || evento);
    -- Eu adoro o Saint Patrick's day
END;




-- declarando variaveis escalares
DECLARE
    v_job         VARCHAR2(9);               /* null */
    v_loop        BINARY_INTEGER := 0;       /* 0 */
    v_total_sal   NUMBER(9,2) := 0           /* 0 */
    v_date        DATE := SYSDATE + 7;       /* data atual + 7 dias */
    v_boolean     BOOLEAN;                   /* por padrao o valor e false*/
    v_boolean2    BOOLEAN NOT NULL := true;  /* true */



-- criando uma variavel com mesmo tipo de dado e mesmo tamanho de uma coluna da tabela 
DECLARE
    minha_variavel  tabela.coluna%TYPE;
BEGIN
    SELECT coluna INTO minha_variavel
    FROM tabela
    WHERE minha_condicao;
END;

-- exemplo: 
DECLARE
    nome_do_funcionario   empregados.funcionarios%TYPE;
BEGIN
    SELECT funcionarios INTO nome_do_funcionario
    FROM empregados
    WHERE codigo_do_funcionario = 7900;
    -- estou atribuindo a variavel o nome do funcionario que possui o codigo 7900 
END; 

-- exemplo 2 
DECLARE
    data_contratacao_funcionario   empregados.data_contratacao%TYPE;
    salario_funcionario            empregados.salario%TYPE;
BEGIN
    SELECT data_contratacao, salario
    INTO data_contratacao_funcionario, salario_funcionario
    FROM empregados
    WHERE codigo_do_funcionario = 7900;
END;




-- pegando a soma dos salarios de todos os funcionarios de um departamento especifico
DECLARE
    soma_salario  NUMBER(10,2);
    codigo_dpto  NUMBER NOT NULL := 60;
BEGIN
    SELECT SUM(salario)
    INTO soma_salario
    FROM empregados
    WHERE id_departamento = codigo_dpto;
    DBMS_OUTPUT.PUT_LINE('A soma dos salarios e de: ' || soma_salario);
END;




-- pegando o maior codigo de funcionario
DECLARE 
    maior_codigo NUMBER(5);
BEGIN
    SELECT MAX(id_funcionario)
    INTO maior_codigo
    FROM empregados;
    DBMS_OUTPUT.PUT_LINE('O maior codigo de funcionario e: ' || maior_codigo);
END;



-- aumentando o salario medio dos funcionarios em 10% e deixando com 2 casas decimais 
DECLARE
    reajuste_salario     empregados.salario%TYPE;
BEGIN
    SELECT ROUND(AVG(salario), 2)
    INTO reajuste_salario 
    FROM empregados;
    reajuste_salario := reajuste_salario * 1.10;
END;



-- deletando as linhas que pertencem ao departamento 10 
DECLARE
    tchau_departamento   empregados.id_departamento%TYPE := 10;
BEGIN
    DELETE FROM empregados
    WHERE id_departamento = tchau_departamento;
END;



-- contando quantas linhas foram deletadas 
DECLARE
    tchau_departamento   empregados.id_departamento%TYPE := 10;
    mensagem  VARCHAR2(80);
BEGIN
    DELETE FROM empregados
    WHERE id_departamento = tchau_departamento;
    mensagem := SQL%ROWCOUNT || ' linhas deletadas'
    DBMS_OUTPUT.PUT_LINE(mensagem);
END;



-- pegando o proximo valor de uma sequence 
DECLARE
    proximo_valor  NUMBER;
BEGIN
    proximo_valor := nome_da_sequence.NEXTVAL;
END;



-- data por extenso 
DECLARE
    minha_data   empregados.data_contratacao%TYPE := '22/FEVEREIRO/2022';
BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(minha_data, 'Day, DD MONTH YYYY'))
    -- Terca-feira, 22 FEVEREIRO 2022
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(minha_data, 'Day, DD "de" MONTH "de" YYYY'))
    -- Terca-feira, 22 de FEVEREIRO de 2022


-- convertendo uma data para o formato americano 
    minha_data := TO_DATE('22/02/2022', 'MM/DD/YYYY');




-- exemplo de insert numa tabela 
INSERT INTO empregados(id, nome, salario) VALUES (69, 'Marquinhos', 2000);

-- exemplo descricao de uma tabela
DESC nome_da_tabela

-- exemplo select de tudo de uma tabela
SELECT * FROM nome_da_tabela

-- contando a quantidade de linhas na coluna de uma tabela
COUNT(funcionarios)   

-- pegar o tamanho de uma string 
LENGTH(minha_variavel)

-- contando os meses de uma data a outra 
MONTHS_BETWEEN(data_atual, data_anterior);

-- exemplo de drop table 
DROP TABLE nome_da_tabela PURGE;

-- funcoes 
TO_CHAR
TO_DATE
TO_NUMBER
TO_TIMESTAMP

-- exemplo de if 
BEGIN
    IF x=0 THEN
    y := 1;
    END IF;
END;





-- mergeando duas tabelas
MERGE INTO departamento_fisico
    USING departamento_online
    ON (departamento_fisico.id_departamento = departamento_online.id_departamento)
    WHEN MATCHED THEN 
        UPDATE SET departamento_fisico.funcionarios = departamento_online.funcionarios, departamento_fisico.localizacao = departamento_online.localizacao
    WHEN NOT MATCHED THEN 
        INSERT (departamento_fisico.id_departamento, departamento_fisico.id_departamento, departamento_fisico.localizacao)
        VALUES (departamento_online.id_departamento, departamento_online.id_departamento, departamento_online.localizacao)

-- deixando o merge mais legivel, seria assim 
MERGE INTO departamento_fisico f
    USING departamento_online o 
    ON (f.id_departamento = o.id_departamento)
    WHEN MATCHED THEN 
        UPDATE SET f.funcionarios = o.funcionarios, f.localizacao = o.localizacao
    WHEN NOT MATCHED THEN 
        INSERT (f.id_departamento, f.id_departamento, f.localizacao)
        VALUES (o.id_departamento, o.id_departamento, o.localizacao)





-- acredito que a linha 129 poderia ter sido escrita assim 
SELECT ROUND(AVG(salario), 2) * 1.10;













