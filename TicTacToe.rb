module TicTacToe

	class Game

		def initialize(name1 = 'Player1', name2 = 'Player2')
			@player1, @player2 = Player.new(name1, 'X'), Player.new(name2, 'O')
		end

		def begin
			swap_players
			@board = Board.new

			until winner || full?
				@board.draw_board
				move = get_input
				if move && @board.get_square(move) == ' '
					@board.set_square(move, @current_player.symbol)
					swap_players
				else
					puts "That's not a valid move try again"
				end
			end

			@board.draw_board
			winner ? (puts "Congrats #{winner.name}! You WIN!") : (puts "Cats game!")
		end

		def swap_players
			@current_player == @player1 ? @current_player = @player2 : @current_player = @player1
		end

		def winner
			wins = [[{x: 0, y: 0}, {x: 1, y: 0}, {x: 2, y: 0}],
					[{x: 0, y: 1}, {x: 1, y: 1}, {x: 2, y: 1}],
					[{x: 0, y: 2}, {x: 1, y: 2}, {x: 2, y: 2}],
					[{x: 0, y: 0}, {x: 0, y: 1}, {x: 0, y: 2}],
					[{x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}],
					[{x: 2, y: 0}, {x: 2, y: 1}, {x: 2, y: 2}],
					[{x: 0, y: 0}, {x: 1, y: 1}, {x: 2, y: 2}],
					[{x: 2, y: 0}, {x: 1, y: 1}, {x: 0, y: 2}]]

			wins.each do |n|
				if n.all? { |i| @board.get_square(i) == @player1.symbol }
					return @player1
				elsif n.all? { |i| @board.get_square(i) == @player2.symbol }
					return @player2
				end
			end

			return false
		end

		def full?
			3.times do |x|
				3.times { |y| return false if @board.get_square({x: x, y: y}) == ' ' }
			end

			true
		end

		def get_input
			print "#{@current_player.name} enter your move coordinates as x, y: "
			input = gets.chomp
			if !input.index(', ')
				puts 'That is not a valid input, please use the format x, y'
				return false
			end
			input = input.split(', ')

			begin
				{x: input[1].to_i - 1, y: input[0].to_i - 1}
			rescue
				puts 'That is not a valid input'
				return nil
			end
		end
	end

	Player = Struct.new(:name, :symbol)
	
	class Board

		def initialize
			@board = [[' ', ' ', ' '],
					  [' ', ' ', ' '],
					  [' ', ' ', ' ']]
		end

		def get_square(square)
			begin	
				@board[square[:x]][square[:y]]
			rescue
				return nil
			end
		end

		def set_square(square, symbol)
			@board[square[:x]][square[:y]] = symbol
		end

		def draw_board
			puts 'Y|X 1   2   3'
			@board.each_with_index do |i, n|
				line = "#{n + 1}|"
				i.each { |s| line += " [#{s}]" }
				puts line
			end
		end
	end
end
