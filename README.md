# Superhero Battles

Superhero Battles is a ruby CLI application to view details of superheros, and play a card game featuring them versus the computer.

It makes ruby Card class instances containing superhero data retrieved from the [superhero-api](https://akabab.github.io/superhero-api/api/) using the net/http and open-uri libraries and the [json](https://rubygems.org/gems/json/versions/1.8.3) gem.

Game classes are then created when the user wants to play a game, and these are kept track of in the results.

Other helper classes such as Deck are used, that have been added with the thoughts of future expansions where there could be a custom deck builder option from the main menu.

## Installation

To play Superhero Battles, you must have [ruby](https://www.ruby-lang.org/en/) installed on your computer.

Then you must use bundler to install the required gems in the superhero-battles folder.

```bash
bundle install
```

Finally, you must give permission to the superhero-battles file to be executable.

```bash
chmod +x bin/superhero_battles
```

## Usage

To use the application enter:

```bash
bin/superhero-battles
```

From here all menus can be navigated by entering the numbers listed.

## Contributing
Pull requests are welcome on [GitHub](https://github.com/Shilcof/superhero_battles). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).