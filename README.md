# Judgement — Card Game Scorer

A sleek score tracker for the classic **Judgement** (aka Oh Hell) card game. Single HTML file, no build step, works in any browser.

## Screenshots

### Player Setup
![Setup Screen](screenshots/setup.png)

### Gameplay
![Gameplay Screen](screenshots/gameplay.png)

## Features

- **4-player scoring** with live standings and leaderboard
- **Two game modes** — Normal (13 rounds) and Extended (26 rounds)
- **No Trump option** — every 5th round has no trump suit
- **Trump suit rotation** with visual playing card display (♠ → ♦ → ♣ → ♥)
- **Bid tracking** — match your bid exactly for `bid + 10` points, miss and score zero
- **Persistent player stats** — win/loss records saved to `stats.txt` across games
- **Round history** table with per-round breakdowns
- **Undo** last round if you make a mistake
- **In-game rules** — collapsible "How to Play" guide on the setup screen

## Quick Start

```bash
git clone https://github.com/shtarun/judgement-game.git
cd judgement-game
./run.sh          # starts local server + opens browser
./run.sh --fresh  # clears all player history first
```

## How to Play

1. Enter player names and choose your game mode
2. Optionally enable **No Trump rounds**
3. Hit **Start Game**
4. Each round: enter bids → mark each player ✓ made or ✗ missed → Submit
5. Winner is announced after all rounds are complete

Full rules are also available in-game — click **"How to Play"** on the setup screen.

## Game Modes

| Mode | Rounds | Cards per round |
|------|--------|-----------------|
| **Normal** | 13 | 13 → 1 (descending) |
| **Extended** | 26 | 13 → 1 → 13 (descend then ascend) |

### No Trump Option

When enabled, every **5th round** (rounds 5, 10, 15, 20, 25) is played with no trump suit. The trump rotation pauses during No Trump rounds and resumes where it left off:

```
Round 1: ♠ Spades
Round 2: ♦ Diamonds
Round 3: ♣ Clubs
Round 4: ♥ Hearts
Round 5: ⊘ No Trump     ← rotation pauses
Round 6: ♠ Spades       ← rotation resumes
```

## Scoring

- Match your bid exactly → **bid + 10** points
- Miss your bid → **0** points
- Highest total score after all rounds wins

## Player Stats

Win/loss records are saved to `stats.txt` and persist across games. Stats are shown per player on the setup screen, broken down by game mode (Normal / Extended / Total).

## License

MIT
