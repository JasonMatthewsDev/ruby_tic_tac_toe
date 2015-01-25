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
				move = get_input - 1
				if move && @board.get_square(move) != @player1.symbol && @board.get_square(move) != @player2.symbol && @board.get_square(move)
					
					@board.set_square(move, @current_player.symbol)
					swap_players
				else
					puts "That's not a valid move try again."
				end
			end

			@board.draw_board
			winner ? (puts "Congrats #{winner.name}! You WIN!") : (puts "Cats game!")
		end

		def swap_players
			@current_player == @player1 ? @current_player = @player2 : @current_player = @player1
		end

		def winner
			wins = [[0, 1, 2], [3, 4, 5],
					[6, 7, 8], [0, 3, 6],
					[1, 4, 7], [2, 5, 8],
					[0, 4, 8], [2, 4, 6]]

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
			9.times { |x| return false if (1..9).include?(@board.get_square(x))}

			true
		end

		def get_input
			print "#{@current_player.name} enter your move (1-9): "
			input = gets.chomp
			

			begin
				input = input.to_i
			rescue
				puts 'That is not a valid input'
				return nil
			end

			input
		end
	end

	Player = Struct.new(:name, :symbol)
	
	class Board

		def initialize
			@board = (1..9).to_a
		end

		def get_square(square)
			begin	
				@board[square]
			rescue
				return nil
			end
		end

		def set_square(square, symbol)
			@board[square] = symbol
		end

		def draw_board
			3.times do |i|
				line = ''
				3.times { |x| line += " [#{@board[(3 * i) + x]}]" }
				puts line
			end
		end
	end
end
