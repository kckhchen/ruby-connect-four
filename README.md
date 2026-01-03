# Ruby Connect Four

A command-line game of the classic Connect Four built with Ruby. This project was built using **Test Driven Development (TDD)** with RSpec.

## Features

- **2-Player Local Gameplay:** Play against a friend in the terminal.
- **Input Validation:** Detects invalid inputs.
- **Win Detection:** Algorithms to detect horizontal, vertical, and diagonal wins.
- **TDD Approach:** Built with a "Test First" mentality, resulting in robust test coverage.

## Installation & Usage

Clone the repository

```bash
git clone https://github.com/kckhchen/ruby-connect-four.git
cd ruby-connect-four
```

and run the game!

```bash
ruby main.rb
```

## Running Tests

This game was built using TDD. To verify the logic or check for regressions, you can run the full test suite with the command:

```bash
bundle exec rspec
```

## Project Structure

`lib/board.rb`: Handles the grid state, winning logic, and piece placement.

`lib/game.rb`: Controls the game loop, user input, and turn management.

`spec/`: Contains all unit and integration tests.

`main.rb`: The entry point to start the game.
