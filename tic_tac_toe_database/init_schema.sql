-- Tic Tac Toe Database Schema
-- Users, Games, Moves tables
-- Designed for Django ORM compatibility

-- User Table: authentication & profile info
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_joined TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP WITH TIME ZONE
);

-- Games Table: tracks each game session
CREATE TABLE IF NOT EXISTS games (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    player_x_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    player_o_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    current_turn CHAR(1) CHECK (current_turn IN ('X', 'O')),
    status VARCHAR(32) NOT NULL DEFAULT 'active', -- active, finished, draw, etc.
    winner CHAR(1) CHECK (winner IN ('X', 'O'))     -- null if draw or not finished
);

-- Moves Table: move by move history for every game
CREATE TABLE IF NOT EXISTS moves (
    id SERIAL PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    player_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    move_number INTEGER NOT NULL, -- 1-based index of the move in the game
    x INTEGER NOT NULL CHECK (x BETWEEN 0 AND 2),
    y INTEGER NOT NULL CHECK (y BETWEEN 0 AND 2),
    symbol CHAR(1) NOT NULL CHECK (symbol IN ('X', 'O')),
    played_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (game_id, move_number),
    UNIQUE (game_id, x, y)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_games_status ON games(status);
CREATE INDEX IF NOT EXISTS idx_moves_game_id ON moves(game_id);
CREATE INDEX IF NOT EXISTS idx_moves_player_id ON moves(player_id);

-- Populate example (for test/demo, remove in prod)
-- INSERT INTO users (username, email, password_hash) VALUES ('testuser', 'test@example.com', 'dummyhash');
