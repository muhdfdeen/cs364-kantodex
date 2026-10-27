CREATE TABLE IF NOT EXISTS type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS pokemon (
    pokedex_num INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    hp INT NOT NULL CHECK (hp > 0),
    attack INT NOT NULL CHECK (attack > 0),
    defense INT NOT NULL CHECK (defense > 0),
    special INT NOT NULL CHECK (special > 0),
    speed INT NOT NULL CHECK (speed > 0),
    height_m DECIMAL(4, 2) NOT NULL,
    weight_kg DECIMAL(5, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS pokemon_types (
    pokedex_num INT NOT NULL,
    type_id INT NOT NULL,
    slot INT NOT NULL CHECK (slot IN (1, 2)),
    PRIMARY KEY (pokedex_num, type_id),
    FOREIGN KEY (pokedex_num) REFERENCES pokemon(pokedex_num) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES type(type_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS trainer_team (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    trainer_name VARCHAR(50) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS team_member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT NOT NULL,
    pokedex_num INT NOT NULL,
    nickname VARCHAR(30) NULL,
    level INT NOT NULL DEFAULT 50 CHECK (level BETWEEN 1 AND 100),
    roster_slot INT NOT NULL CHECK (roster_slot BETWEEN 1 AND 6),
    FOREIGN KEY (team_id) REFERENCES trainer_team(team_id) ON DELETE CASCADE,
    FOREIGN KEY (pokedex_num) REFERENCES pokemon(pokedex_num),
    UNIQUE (team_id, roster_slot)
);