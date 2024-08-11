DROP DATABASE IF EXISTS dbgames;
CREATE DATABASE dbgames;
USE dbgames;

CREATE TABLE users(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  money FLOAT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

CREATE TABLE cards(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(6) NOT NULL,
  suit ENUM('hearts', 'diamonds', 'spades', 'clubs') NOT NULL,
  value ENUM('2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A') NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

CREATE TABLE decks(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  decks_id BIGINT UNSIGNED NOT NULL,
  card_id BIGINT UNSIGNED NOT NULL,
  `order` INT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE (card_id, decks_id),
  FOREIGN KEY (card_id) REFERENCES cards(id)
);

CREATE TABLE games(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  description VARCHAR(255) NOT NULL,
  deck_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
#   FOREIGN KEY (deck_id) REFERENCES decks(decks_id)
);

CREATE TABLE parties(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  game_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE (user_id, game_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (game_id) REFERENCES games(id)
);

CREATE TABLE members(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  party_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE (party_id, user_id),
  FOREIGN KEY (party_id) REFERENCES parties(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);