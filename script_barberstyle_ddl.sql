-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS barber_style;
USE barber_style;

-- 1. Tabela Clientes
CREATE TABLE CLIENTE (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Completo VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Data_Nascimento DATE
);

-- 2. Tabela Barbeiros
CREATE TABLE BARBEIRO (
    ID_Barbeiro INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Especialidade VARCHAR(50),
    Percentual_Comissao DECIMAL(5,2)
);

-- 3. Tabela Serviços
CREATE TABLE SERVICO (
    ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL,
    Valor_Atual DECIMAL(10,2) NOT NULL,
    Tempo_Estimado INT COMMENT 'Tempo em minutos'
);

-- 4. Tabela Produtos
CREATE TABLE PRODUTO (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Produto VARCHAR(50) NOT NULL,
    Valor_Venda DECIMAL(10,2) NOT NULL,
    Qtd_Estoque INT DEFAULT 0
);

-- 5. Tabela Agendamentos
CREATE TABLE AGENDAMENTO (
    ID_Agendamento INT AUTO_INCREMENT PRIMARY KEY,
    Data_Hora DATETIME NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pendente',
    ID_Cliente INT,
    ID_Barbeiro INT,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    FOREIGN KEY (ID_Barbeiro) REFERENCES BARBEIRO(ID_Barbeiro)
);

-- 6. Tabela Associativa Item_Agendamento (Resolve o N:N)
CREATE TABLE ITEM_AGENDAMENTO (
    ID_Agendamento INT,
    ID_Servico INT,
    Valor_Praticado DECIMAL(10,2),
    PRIMARY KEY (ID_Agendamento, ID_Servico),
    FOREIGN KEY (ID_Agendamento) REFERENCES AGENDAMENTO(ID_Agendamento),
    FOREIGN KEY (ID_Servico) REFERENCES SERVICO(ID_Servico)
);

-- 7. Tabela Comanda
CREATE TABLE COMANDA (
    ID_Comanda INT AUTO_INCREMENT PRIMARY KEY,
    Valor_Total DECIMAL(10,2),
    Forma_Pagamento VARCHAR(30),
    ID_Agendamento INT,
    FOREIGN KEY (ID_Agendamento) REFERENCES AGENDAMENTO(ID_Agendamento)
);

-- 8. Tabela Associativa Consumo_Produto (Resolve o N:N)
CREATE TABLE CONSUMO_PRODUTO (
    ID_Comanda INT,
    ID_Produto INT,
    Quantidade INT,
    Valor_Unitario DECIMAL(10,2),
    PRIMARY KEY (ID_Comanda, ID_Produto),
    FOREIGN KEY (ID_Comanda) REFERENCES COMANDA(ID_Comanda),
    FOREIGN KEY (ID_Produto) REFERENCES PRODUTO(ID_Produto)
);