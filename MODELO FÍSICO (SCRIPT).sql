create database Sistema_De_Gestao_De_Eventos;
use Sistema_De_Gestao_De_Eventos;
show tables;


create table TIPO_EVENTO(
    idtipo_evento int primary key auto_increment,
    tipo varchar(255)
);

describe TIPO_EVENTO;

create table PALESTRANTE (
    idpalestrante int primary key auto_increment,
    nome varchar(255),
    cpf varchar(15),
    data_nascimento date,
    endereco varchar(255),
    email varchar(255),
    celular varchar(15)
);

create table PARTICIPANTE(
    idparticipante int primary key auto_increment,
    nome varchar(255),
    cpf varchar(15),
    data_nascimento date,
    endereco varchar(255),
    email varchar(255),
    celular varchar(15)
);

create table PAGAMENTO(
    idpagamento int primary key auto_increment,
    total_compra double,
    num_boleto_transacao double
);

create table INGRESSO (
    idingresso int primary key auto_increment,
    idpagamento int,
    idparticipante int,
    desconto double,
    valor double,
    status_ingresso int,
    foreign key (idparticipante) references PARTICIPANTE(idparticipante),
    foreign key (idpagamento) references PAGAMENTO(idpagamento)
);

create table EVENTO (
    idevento int primary key auto_increment,
    idtipo_evento int,
    idingresso int, 
    idpalestrante int,
    descricao varchar(255),
    data_evento date,
    horario time,
    duracao time,
    qtd_max int,
    foreign key (idtipo_evento) references TIPO_EVENTO(idtipo_evento),
	foreign key (idingresso) references INGRESSO(idingresso),
	foreign key (idpalestrante) references PALESTRANTE(idpalestrante)
);

insert into TIPO_EVENTO (tipo) values 
('Palestra'),
('Workshop'),
('Congresso');

SELECT * FROM TIPO_EVENTO;

insert into PALESTRANTE (nome, cpf, data_nascimento, endereco, email, celular) values 
('Leandro Karnal', '000.123.789-10', '1963-01-02', 'Rua 1, 123, RS', 'karnalhistoria@email.com', '11996969696'),
('Clóvis de Barros Filho', '000.234.678-90', '1966-10-21', 'Av. B, 456, SP', 'clovisfilosofo@email.com', '11998989898'),
('Gabriela Prioli Della Vedova', '000.345.567-80', '1986-01-21', 'Setor Sul, 321, SP', 'prioligabi@gmail.com','11997979797'),
('Pablo Henrique Costa Marçal', '000.567.456-70', '1987-04-18', 'Vila Olimpea, 21, SP', 'marcalpablo@gmail.com', '11995959595');

SELECT * FROM PALESTRANTE;

insert into PARTICIPANTE (nome, cpf, data_nascimento, endereco, email, celular) values 
('Giovanna Ferreira', '111.222.333-44', '2002-01-01', 'Rua C, 789', 'jgiovannaferreira@email.com', '11992929292'),
('Catarina Alves', '555.666.777-88', '2001-11-03', 'Rua comercial. D, 202', 'catarinaalves@email.com', '11991919191'),
('Eny Mauriz', '555.555.777-88', '2001-02-15', 'Av. D, 321', 'maurizeny@email.com', '11993939393'),
('Nadu Medeiros', '555.666.666-88', '2002-02-15', 'Av. Palmeiras, 32', 'anadumedeiros@email.com', '11995959595'),
('Stefany', '555.777.777-88', '2003-02-15', 'Setor Norte, 340', 'stefany@email.com', '11994949494'),
('Sabrina', '555.888.777-88', '2003-10-15', 'Setor Sul, 22', 'sabrinah@email.com', '11994949494');

SELECT * FROM PARTICIPANTE;

insert into PAGAMENTO (total_compra, num_boleto_transacao) values 
(200.00, 123456789),
(150.00, 134678012),
(150.00, 674890112),
(100.00, 789456123),
(200.00, 132563344),
(100.00, 228854901);

SELECT * FROM PAGAMENTO;

insert into INGRESSO (idpagamento, idparticipante, desconto, valor, status_ingresso) values 
(1, 1, 10.0, 190.00, 1),
(2, 2, 20.0, 130.00, 2),
(3, 3, 5.0, 145.00, 3),
(4, 4, 5.0, 195.00, 4),
(5, 5, 10.00, 190.00, 5),
(6, 6, 20.00, 80.00, 6);

select *from INGRESSO;

insert into EVENTO (idtipo_evento, idingresso, idpalestrante, descricao, data_evento, horario, duracao, qtd_max) values 
(1, 1, 1, 'Palestra sobre Gestão de Projetos', '2024-10-10', '09:00:00', '02:00:00', 100),
(2, 2, 2, 'Workshop de Inteligência Emocional', '2024-11-05', '14:00:00', '03:00:00', 50),
(3, 3, 3, 'Congresso dos Engenheiros de software e as novas tecnologias do mercado', '2024-12-10', '10:00:00', '02:00:00', 100),
(2, 4, 4, 'Workshop de Inteligência Emocional', '2024-11-05', '14:00:00', '03:00:00', 50),
(1, 5, 1, 'Palestra sobre Gestão de Projetos', '2024-10-10', '09:00:00', '02:00:00', 100),
(3, 6, 3, 'Congresso dos Engenheiros de software e as novas tecnologias do mercado', '2024-12-10', '10:00:00', '02:00:00', 100);

select *from EVENTO;

SELECT * FROM ingresso WHERE idingresso IN (1, 3);

-- Remove a chave estrangeira para idparticipante
ALTER TABLE INGRESSO DROP FOREIGN KEY ingresso_ibfk_1;

-- Adiciona a chave estrangeira para idparticipante com exclusão em cascata
ALTER TABLE INGRESSO ADD CONSTRAINT ingresso_ibfk_1
FOREIGN KEY (idparticipante) REFERENCES PARTICIPANTE(idparticipante)
ON DELETE CASCADE;

-- Remove a chave estrangeira para idpagamento
ALTER TABLE INGRESSO DROP FOREIGN KEY ingresso_ibfk_2;

-- Adiciona a chave estrangeira para idpagamento com exclusão em cascata
ALTER TABLE INGRESSO ADD CONSTRAINT ingresso_ibfk_2
FOREIGN KEY (idpagamento) REFERENCES PAGAMENTO(idpagamento)
ON DELETE CASCADE;


-- Remove a chave estrangeira para idtipo_evento
ALTER TABLE EVENTO DROP FOREIGN KEY evento_ibfk_1;

-- Adiciona a chave estrangeira para idtipo_evento com exclusão em cascata
ALTER TABLE EVENTO ADD CONSTRAINT evento_ibfk_1
FOREIGN KEY (idtipo_evento) REFERENCES TIPO_EVENTO(idtipo_evento)
ON DELETE CASCADE;

-- Remove a chave estrangeira para idingresso
ALTER TABLE EVENTO DROP FOREIGN KEY evento_ibfk_2;

-- Adiciona a chave estrangeira para idingresso com exclusão em cascata
ALTER TABLE EVENTO ADD CONSTRAINT evento_ibfk_2
FOREIGN KEY (idingresso) REFERENCES INGRESSO(idingresso)
ON DELETE CASCADE;

-- Remove a chave estrangeira para idpalestrante
ALTER TABLE EVENTO DROP FOREIGN KEY evento_ibfk_3;

-- Adiciona a chave estrangeira para idpalestrante com exclusão em cascata
ALTER TABLE EVENTO ADD CONSTRAINT evento_ibfk_3
FOREIGN KEY (idpalestrante) REFERENCES PALESTRANTE(idpalestrante)
ON DELETE CASCADE;