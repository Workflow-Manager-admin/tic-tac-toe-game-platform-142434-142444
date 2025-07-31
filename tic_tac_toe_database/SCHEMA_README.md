# Tic Tac Toe Database Schema

This schema initializes the PostgreSQL database for the Tic Tac Toe game platform.

## Tables

- **users**: Stores user authentication and profile details. Compatible with Django's custom user model.
    - Columns: id, username, email, password_hash, is_active, first_name, last_name, date_joined, last_login

- **games**: Tracks each Tic Tac Toe match, current turn, status, and winner.
    - Columns: id, created_at, updated_at, player_x_id, player_o_id, current_turn, status, winner

- **moves**: Stores every move in a game (player, move order, position, symbol, timestamp).
    - Columns: id, game_id, player_id, move_number, x, y, symbol, played_at

## Relationships

- `games.player_x_id` and `games.player_o_id` reference `users.id`
- `moves.game_id` references `games.id`
- `moves.player_id` references `users.id`

## Indexes

- Games by status
- Moves by game and player

## Integration notes

- Fields and names are designed for Django compatibility; either use as-is or map to your Django models.
- Add or adjust constraints as needed for business logic.
- Use `init_schema.sql` to set up the schema via `psql`.

## Initialization

To initialize the database, run:

```sh
psql -h localhost -U <user> -d <database> -p <port> -f init_schema.sql
```

Update credentials as needed.
