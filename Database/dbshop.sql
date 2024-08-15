create DATABASE dbshop;

use dbshop;

drop table permissions;
create table permissions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

drop table users;
create table users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    permission_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

drop table categories;
create table categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    description varchar(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

drop table products;
create table products (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    price float(10, 2) NOT NULL,
    category_id BIGINT UNSIGNED NOT NULL,
    description varchar(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

drop table stocks;
create table stocks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT UNSIGNED NOT NULL,
    stock int DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

drop table carts;
create table carts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

drop table products_carts;
create table products_carts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT UNSIGNED NOT NULL,
    cart_id BIGINT UNSIGNED NOT NULL,
    quantity int NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (cart_id) REFERENCES carts(id)
);

--Insert Permission
INSERT INTO permissions (name)
VALUES 
('admin'),
('user');

--Insert Users
INSERT INTO users (name, permission_id)
VALUES 
('Admin', 1),
('Usuário para Teste', 2);

--Insert Categories
INSERT INTO categories (name, description)
VALUES 
('Eletrônicos', 'Produtos eletrônicos como TVs, computadores, etc.'),
('Roupas', 'Vestuário masculino, feminino e infantil'),
('Livros', 'Livros de diversos gêneros e autores'),
('Brinquedos', 'Brinquedos para todas as idades'),
('Móveis', 'Móveis para casa e escritório'),
('Esportes', 'Equipamentos esportivos e acessórios');

--Insert Products
-- Eletrônicos
INSERT INTO products (name, description, price, category_id)
VALUES
('Smart TV 55"', 'TV de 55 polegadas com resolução 4K', 2499.99, 1),
('Notebook Dell', 'Notebook com 16GB RAM e 512GB SSD', 3599.99, 1),
('Smartphone Samsung', 'Smartphone com 128GB de armazenamento', 1999.99, 1),
('Fone de Ouvido Bluetooth', 'Fone sem fio com cancelamento de ruído', 499.99, 1),
('Tablet Apple', 'Tablet com tela retina de 10 polegadas', 3299.99, 1),
('Câmera Digital', 'Câmera com lente intercambiável de 24MP', 2799.99, 1),
('Console de Videogame', 'Console de última geração com 1TB de armazenamento', 4499.99, 1),
('Monitor 27"', 'Monitor LED Full HD', 1099.99, 1),
('Impressora Multifuncional', 'Impressora com scanner e copiadora', 799.99, 1),
('Caixa de Som Bluetooth', 'Caixa de som portátil com bateria de longa duração', 299.99, 1);

-- Roupas
INSERT INTO products (name, description, price, category_id)
VALUES
('Camisa Polo', 'Camisa polo de algodão, várias cores', 89.99, 2),
('Calça Jeans', 'Calça jeans masculina, corte reto', 149.99, 2),
('Vestido Floral', 'Vestido estampado floral, comprimento médio', 179.99, 2),
('Jaqueta de Couro', 'Jaqueta de couro sintético, preta', 299.99, 2),
('Blusa de Tricô', 'Blusa de tricô feminina, gola alta', 119.99, 2),
('Shorts de Esporte', 'Shorts de corrida masculino', 69.99, 2),
('Camisa Social', 'Camisa social masculina, manga longa', 129.99, 2),
('Saia Plissada', 'Saia plissada feminina, comprimento curto', 89.99, 2),
('Meia-Calça', 'Meia-calça de nylon, preta', 29.99, 2),
('Camiseta Estampada', 'Camiseta unissex com estampa divertida', 49.99, 2);

-- Livros
INSERT INTO products (name, description, price, category_id)
VALUES
('O Senhor dos Anéis', 'Livro de fantasia escrito por J.R.R. Tolkien', 79.99, 3),
('1984', 'Romance distópico de George Orwell', 59.99, 3),
('Dom Quixote', 'Clássico da literatura espanhola por Miguel de Cervantes', 69.99, 3),
('Orgulho e Preconceito', 'Romance de Jane Austen', 49.99, 3),
('A Revolução dos Bichos', 'Fábula política de George Orwell', 39.99, 3),
('Moby Dick', 'Romance sobre a caça à baleia por Herman Melville', 89.99, 3),
('A Divina Comédia', 'Poema épico de Dante Alighieri', 99.99, 3),
('Hamlet', 'Tragédia escrita por William Shakespeare', 29.99, 3),
('O Apanhador no Campo de Centeio', 'Romance de J.D. Salinger', 54.99, 3),
('A Metamorfose', 'Novela de Franz Kafka', 39.99, 3);

-- Brinquedos
INSERT INTO products (name, description, price, category_id)
VALUES
('Boneca Barbie', 'Boneca Barbie com vestido rosa', 99.99, 4),
('Carrinho de Controle Remoto', 'Carrinho elétrico com controle remoto', 149.99, 4),
('Blocos de Montar', 'Conjunto de blocos de montar coloridos', 89.99, 4),
('Quebra-Cabeça 1000 Peças', 'Quebra-cabeça com imagem de paisagem', 59.99, 4),
('Jogo de Tabuleiro', 'Jogo de tabuleiro clássico para família', 129.99, 4),
('Boneco de Ação', 'Boneco de ação articulado', 79.99, 4),
('Bola de Futebol', 'Bola de futebol tamanho oficial', 49.99, 4),
('Pista de Carrinhos', 'Pista de carrinhos com loopings', 199.99, 4),
('Ursinho de Pelúcia', 'Ursinho de pelúcia macio, marrom', 69.99, 4),
('Kit de Pintura Infantil', 'Conjunto de tintas e pincéis para crianças', 39.99, 4);

-- Móveis
INSERT INTO products (name, description, price, category_id)
VALUES
('Sofá 3 Lugares', 'Sofá confortável de tecido, 3 lugares', 1999.99, 5),
('Mesa de Jantar', 'Mesa de jantar em madeira, 6 lugares', 2499.99, 5),
('Cadeira de Escritório', 'Cadeira de escritório ergonômica', 899.99, 5),
('Estante de Livros', 'Estante de madeira com 5 prateleiras', 799.99, 5),
('Guarda-Roupa 4 Portas', 'Guarda-roupa em MDF com espelho', 2999.99, 5),
('Cômoda', 'Cômoda com 6 gavetas, branca', 1199.99, 5),
('Mesa de Centro', 'Mesa de centro em vidro temperado', 499.99, 5),
('Poltrona Reclinável', 'Poltrona reclinável em couro sintético', 1599.99, 5),
('Cama Box Casal', 'Cama box casal com colchão ortopédico', 2799.99, 5),
('Escrivaninha', 'Escrivaninha com gavetas, MDF', 699.99, 5);

-- Esportes
INSERT INTO products (name, description, price, category_id)
VALUES
('Bicicleta Mountain Bike', 'Bicicleta de montanha com 21 marchas', 1599.99, 6),
('Tênis de Corrida', 'Tênis de corrida masculino, amortecimento', 299.99, 6),
('Bola de Basquete', 'Bola de basquete tamanho oficial', 149.99, 6),
('Luvas de Boxe', 'Par de luvas de boxe em couro sintético', 199.99, 6),
('Rolo de Yoga', 'Rolo de espuma para exercícios de yoga', 99.99, 6),
('Kit de Musculação', 'Conjunto de halteres ajustáveis', 399.99, 6),
('Raquete de Tênis', 'Raquete de tênis de alta performance', 499.99, 6),
('Corda de Pular', 'Corda de pular em PVC, ajustável', 49.99, 6),
('Capacete de Ciclismo', 'Capacete de ciclismo com ventilação', 249.99, 6),
('Prancha de Surf', 'Prancha de surf para iniciantes', 899.99, 6);

INSERT INTO stocks (product_id, stock)
VALUES
(1, FLOOR(1 + (RAND() * 500))),
(2, FLOOR(1 + (RAND() * 500))),
(3, FLOOR(1 + (RAND() * 500))),
(4, FLOOR(1 + (RAND() * 500))),
(5, FLOOR(1 + (RAND() * 500))),
(6, FLOOR(1 + (RAND() * 500))),
(7, FLOOR(1 + (RAND() * 500))),
(8, FLOOR(1 + (RAND() * 500))),
(9, FLOOR(1 + (RAND() * 500))),
(10, FLOOR(1 + (RAND() * 500))),
(11, FLOOR(1 + (RAND() * 500))),
(12, FLOOR(1 + (RAND() * 500))),
(13, FLOOR(1 + (RAND() * 500))),
(14, FLOOR(1 + (RAND() * 500))),
(15, FLOOR(1 + (RAND() * 500))),
(16, FLOOR(1 + (RAND() * 500))),
(17, FLOOR(1 + (RAND() * 500))),
(18, FLOOR(1 + (RAND() * 500))),
(19, FLOOR(1 + (RAND() * 500))),
(20, FLOOR(1 + (RAND() * 500))),
(21, FLOOR(1 + (RAND() * 500))),
(22, FLOOR(1 + (RAND() * 500))),
(23, FLOOR(1 + (RAND() * 500))),
(24, FLOOR(1 + (RAND() * 500))),
(25, FLOOR(1 + (RAND() * 500))),
(26, FLOOR(1 + (RAND() * 500))),
(27, FLOOR(1 + (RAND() * 500))),
(28, FLOOR(1 + (RAND() * 500))),
(29, FLOOR(1 + (RAND() * 500))),
(30, FLOOR(1 + (RAND() * 500))),
(31, FLOOR(1 + (RAND() * 500))),
(32, FLOOR(1 + (RAND() * 500))),
(33, FLOOR(1 + (RAND() * 500))),
(34, FLOOR(1 + (RAND() * 500))),
(35, FLOOR(1 + (RAND() * 500))),
(36, FLOOR(1 + (RAND() * 500))),
(37, FLOOR(1 + (RAND() * 500))),
(38, FLOOR(1 + (RAND() * 500))),
(39, FLOOR(1 + (RAND() * 500))),
(40, FLOOR(1 + (RAND() * 500))),
(41, FLOOR(1 + (RAND() * 500))),
(42, FLOOR(1 + (RAND() * 500))),
(43, FLOOR(1 + (RAND() * 500))),
(44, FLOOR(1 + (RAND() * 500))),
(45, FLOOR(1 + (RAND() * 500))),
(46, FLOOR(1 + (RAND() * 500))),
(47, FLOOR(1 + (RAND() * 500))),
(48, FLOOR(1 + (RAND() * 500))),
(49, FLOOR(1 + (RAND() * 500))),
(50, FLOOR(1 + (RAND() * 500))),
(51, FLOOR(1 + (RAND() * 500))),
(52, FLOOR(1 + (RAND() * 500))),
(53, FLOOR(1 + (RAND() * 500))),
(54, FLOOR(1 + (RAND() * 500))),
(55, FLOOR(1 + (RAND() * 500))),
(56, FLOOR(1 + (RAND() * 500))),
(57, FLOOR(1 + (RAND() * 500))),
(58, FLOOR(1 + (RAND() * 500))),
(59, FLOOR(1 + (RAND() * 500))),
(60, FLOOR(1 + (RAND() * 500)));
