CREATE SCHEMA VelozCarDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- O trecho "DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci" foi utilizado para que seja ordenado e aceito textos corretamente em português
USE VelozCarDB;

CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL
);

CREATE TABLE Funcionarios (
    funcionario_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL,
    data_admissao DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Veiculos (
    veiculo_id INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    cor VARCHAR(30),
    ano_fabricacao YEAR NOT NULL,
    valor_diaria DECIMAL(10, 2) NOT NULL,
    status ENUM('disponível', 'alugado', 'em manutenção') NOT NULL
);

CREATE TABLE Alugueis (
    aluguel_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    veiculo_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    status ENUM('ativo', 'finalizado', 'atrasado') NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id) ON DELETE CASCADE,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(veiculo_id) ON DELETE CASCADE,
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(funcionario_id) ON DELETE CASCADE
);

CREATE TABLE Pagamentos (
    pagamento_id INT PRIMARY KEY AUTO_INCREMENT,
    aluguel_id INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL,
    metodo ENUM('cartão', 'pix', 'boleto') NOT NULL,
    status ENUM('pendente', 'concluído', 'cancelado') NOT NULL,
    FOREIGN KEY (aluguel_id) REFERENCES Alugueis(aluguel_id) ON DELETE CASCADE
);

CREATE TABLE Manutencoes (
    manutencao_id INT PRIMARY KEY AUTO_INCREMENT,
    veiculo_id INT NOT NULL,
    funcionario_id INT,
    descricao_servico TEXT NOT NULL,
    custo DECIMAL(10, 2) NOT NULL,
    data_manutencao DATE NOT NULL,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(veiculo_id) ON DELETE CASCADE,
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(funcionario_id) ON DELETE SET NULL
);


INSERT INTO Clientes (nome, cpf, endereco, telefone, email, data_cadastro) VALUES
('João Silva', '12345678901', 'Rua A, 123', '11999990001', 'joao@email.com', '2023-01-10'),
('Maria Souza', '12345678902', 'Rua B, 456', '11999990002', 'maria@email.com', '2023-02-15'),
('Pedro Santos', '12345678903', 'Av. Central, 100', '11999990003', 'pedro@email.com', '2023-03-05'),
('Ana Oliveira', '12345678904', 'Rua C, 78', '11999990004', 'ana@email.com', '2023-04-20'),
('Carlos Pereira', '12345678905', 'Rua D, 90', '11999990005', 'carlos@email.com', '2023-05-12'),
('Fernanda Lima', '12345678906', 'Rua E, 300', '11999990006', 'fernanda@email.com', '2023-06-01'),
('Lucas Almeida', '12345678907', 'Av. Brasil, 500', '11999990007', 'lucas@email.com', '2023-07-10'),
('Juliana Costa', '12345678908', 'Rua F, 67', '11999990008', 'juliana@email.com', '2023-08-15');

INSERT INTO Funcionarios (nome, cpf, cargo, data_admissao, telefone, email) VALUES
('Ricardo Mendes', '22345678901', 'Atendente', '2022-01-10', '11988880001', 'ricardo@email.com'),
('Patrícia Souza', '22345678902', 'Gerente', '2021-03-12', '11988880002', 'patricia@email.com'),
('André Santos', '22345678903', 'Atendente', '2022-05-05', '11988880003', 'andre@email.com'),
('Camila Rocha', '22345678904', 'Mecânica', '2023-02-01', '11988880004', 'camila@email.com'),
('Roberto Dias', '22345678905', 'Supervisor', '2020-10-20', '11988880005', 'roberto@email.com'),
('Beatriz Martins', '22345678906', 'Atendente', '2023-04-15', '11988880006', 'beatriz@email.com'),
('Marcelo Nunes', '22345678907', 'Atendente', '2021-11-22', '11988880007', 'marcelo@email.com'),
('Tatiane Lopes', '22345678908', 'Mecânica', '2023-06-10', '11988880008', 'tatiane@email.com');

INSERT INTO Veiculos (placa, modelo, cor, ano_fabricacao, valor_diaria, status) VALUES
('ABC1A23', 'Fiat Uno', 'Branco', 2018, 100.00, 'alugado'),
('BCD2B34', 'Honda Civic', 'Preto', 2020, 200.00, 'disponível'),
('CDE3C45', 'Toyota Corolla', 'Prata', 2019, 220.00, 'disponível'),
('DEF4D56', 'Chevrolet Onix', 'Vermelho', 2021, 150.00, 'disponível'),
('EFG5E67', 'Volkswagen Gol', 'Azul', 2017, 120.00, 'em manutenção'),
('FGH6F78', 'Jeep Compass', 'Branco', 2022, 250.00, 'disponível'),
('GHI7G89', 'Renault Kwid', 'Cinza', 2020, 90.00, 'alugado'),
('HIJ8H90', 'Hyundai HB20', 'Prata', 2019, 140.00, 'disponível');

INSERT INTO Alugueis (cliente_id, veiculo_id, funcionario_id, data_inicio, data_fim, valor_total, status) VALUES
(1, 1, 1, '2023-09-01', '2023-09-05', 500.00, 'ativo'),
(2, 2, 2, '2023-09-10', '2023-09-15', 1000.00, 'finalizado'),
(3, 3, 3, '2023-09-20', '2023-09-25', 1100.00, 'atrasado'),
(4, 4, 1, '2023-10-01', '2023-10-07', 1050.00, 'finalizado'),
(5, 5, 4, '2023-10-10', '2023-10-15', 600.00, 'ativo'),
(6, 6, 2, '2023-11-01', '2023-11-05', 1000.00, 'ativo'),
(7, 7, 3, '2023-11-12', '2023-11-17', 450.00, 'ativo'),
(8, 8, 5, '2023-11-20', '2023-11-25', 700.00, 'ativo');

INSERT INTO Pagamentos (aluguel_id, valor, data_pagamento, metodo, status) VALUES
(1, 500.00, '2023-09-05', 'cartão', 'concluído'),
(2, 1000.00, '2023-09-15', 'pix', 'concluído'),
(3, 1100.00, '2023-09-28', 'boleto', 'pendente'),
(4, 1050.00, '2023-10-07', 'pix', 'concluído'),
(5, 600.00, '2023-10-15', 'cartão', 'pendente'),
(6, 1000.00, '2023-11-05', 'pix', 'pendente'),
(7, 450.00, '2023-11-17', 'boleto', 'pendente'),
(8, 700.00, '2023-11-25', 'cartão', 'pendente');

INSERT INTO Manutencoes (veiculo_id, funcionario_id, descricao_servico, custo, data_manutencao) VALUES
(5, 4, 'Troca de óleo', 150.00, '2023-08-10'),
(5, 8, 'Troca de pneus', 800.00, '2023-09-01'),
(3, 5, 'Revisão geral', 600.00, '2023-07-20'),
(6, 4, 'Alinhamento e balanceamento', 200.00, '2023-10-01'),
(1, 8, 'Substituição de pastilhas de freio', 350.00, '2023-05-15'),
(2, 5, 'Troca de bateria', 400.00, '2023-06-12'),
(4, 4, 'Troca de filtro de ar', 180.00, '2023-09-22'),
(7, 8, 'Conserto do ar-condicionado', 500.00, '2023-07-30');


-- O cliente João devolveu o carro. O aluguel foi finalizado e o status do veículo voltou a ser 'disponível'.
UPDATE Alugueis SET status = 'finalizado' WHERE aluguel_id = 1;
UPDATE Veiculos SET status = 'disponível' WHERE veiculo_id = 1;

-- O valor da diária do Fiat Uno foi ajustado.
UPDATE Veiculos SET valor_diaria = 95.00 WHERE veiculo_id = 1;

-- Quantos clientes foram cadastrados por mês.
SELECT YEAR(data_cadastro) AS ano, MONTH(data_cadastro) AS mes, COUNT(cliente_id) AS total_clientes
FROM Clientes
GROUP BY ano, mes
ORDER BY ano, mes;

-- Média da diária de um carro.
SELECT modelo, AVG(valor_diaria) AS media_diaria
FROM Veiculos
GROUP BY modelo;

-- Valor arrecadado por um método de pagamento.
SELECT metodo, SUM(valor) AS total_arrecadado
FROM Pagamentos
WHERE status = 'concluído'
GROUP BY metodo;

-- Lista de alugueis ativos.
SELECT
    a.aluguel_id,
    c.nome AS nome_cliente,
    v.modelo AS modelo_veiculo,
    f.nome AS nome_funcionario,
    a.data_inicio,
    a.data_fim
FROM Alugueis a
INNER JOIN Clientes c ON a.cliente_id = c.cliente_id
INNER JOIN Veiculos v ON a.veiculo_id = v.veiculo_id
INNER JOIN Funcionarios f ON a.funcionario_id = f.funcionario_id
WHERE a.status = 'ativo';

-- Localizar veículos que não passaram por manutenção.
SELECT
    v.veiculo_id,
    v.placa,
    v.modelo
FROM Veiculos v
LEFT JOIN Manutencoes m ON v.veiculo_id = m.veiculo_id
WHERE m.manutencao_id IS NULL;
