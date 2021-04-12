import random

the_board = [[".",".","."],[".",".","."],[".",".","."]]

def display_round_number(round_number):
    
    print("\n")
    print("##############")
    print(f"## Round #{round_number} ##")
    print("##############")
    print("\n")
    
def display_board(the_board): 
    
    print("Current Board: ")
    print("~~~~~~~~~~~~")
    print("   " + " 0 " + " 1 " + " 2 ")
    print(" 0 " + " " + the_board[0][0] + " " + " " + the_board[0][1] + " " + " "+ the_board[0][2] + " ")
    print(" 1 " + " " + the_board[1][0] + " " + " " + the_board[1][1] + " " + " "+ the_board[1][2] + " ")
    print(" 2 " + " " + the_board[2][0] + " " + " " + the_board[2][1] + " " + " "+ the_board[2][2] + " ")
    print("~~~~~~~~~~~~")

def player_input():
    
    marker = input("X or O? ").upper()

    while not (marker == 'X' or marker == 'O'):
        print("Invalid response. Choose X or O.")
        marker = input("X or O? ").upper()
    
    if marker == 'X':
        return ('X', 'O')
    else:
        return ('O', 'X')

def place_marker(board, marker, position):
    
    board[position[0]][position[1]] = marker

def win_check(board, mark):
    
    is_win = (the_board[0][0] == the_board[0][1] == the_board[0][2] == mark) or (the_board[1][0] == the_board[1][1] == the_board[1][2] == mark) or (the_board[2][0] == the_board[2][1] == the_board[2][2] == mark) or (the_board[0][0] == the_board[1][0] == the_board[2][0] == mark) or (the_board[0][1] == the_board[1][1] == the_board[2][1] == mark) or (the_board[0][2] == the_board[1][2] == the_board[2][2] == mark) or (the_board[0][0] == the_board[1][1] == the_board[2][2] == mark) or (the_board[0][2] == the_board[1][1] == the_board[2][0] == mark)
    
    return is_win

def space_check(board, position):
    
    return board[position[0]][position[1]] == "."
    

def full_board_check(board):
    
    for row_num in range(0, 2):
        for column_num in range(0, 2):
            if board[row_num][column_num] == '.':
                return False
    
    return True

def player_position(marker, board):

    repeat_again = True
    
    while repeat_again == True:
        row_number = input("What row? ")
        column_number = input("What column? ")
        
        try: 
            row_number = int(row_number)
            column_number = int(column_number)
        except ValueError:
            print('Invalid input. Choose 0, 1, or 2 for row and column.')
        else:
            position = [row_number, column_number]
            if (row_number not in range(3)) or (column_number not in range(3)) or (space_check(board, position) == False):
                print('Invalid location. Choose 0, 1, or 2 for row and column.')
            else:
                check_pos = input(f"Move '{marker}' at row {row_number} and column {column_number}. y/n? ").lower()
                if check_pos == 'y':
                    print("Move placed!")
                    print("\n")
                    repeat_again = False
                elif check_pos == 'n':
                    print("Move not placed.")
                else:
                    print("Invalid input. Try again.")
      
    return position

def computer_position(board):
    
    repeat_again = True
    
    while repeat_again == True:
        row_number = random.randint(0,2)
        column_number = random.randint(0,2)
        position = [row_number, column_number]
        if space_check(board, position) == True: 
            repeat_again = False
            print('Computer move placed.')
            print('\n')
    
    return position

def game():

    game_over = False
    
    round_number = 1
    marker_choice = player_input()
    player = marker_choice[0]
    computer = marker_choice[1]
    rotation = 2
    
    if player == 'X' and computer == 'O':
        player_turn = True
    elif player == 'O' and computer == 'X':
        player_turn = False
    
    
    while not game_over: 
        
        if rotation % 2 == 0: 
            display_round_number(round_number)
            display_board(the_board)
            round_number += 1
     
        if player_turn == True:
            print("\n")
            print(f"Player {player} turn.")
            player_pos = player_position(player, the_board)
            place_marker(the_board, player, player_pos)
            display_board(the_board)
            player_win = win_check(the_board, player)
            full_board = full_board_check(the_board)
            if player_win == True: 
                print("You win!")
                game_over = True
            else:
                if full_board == True:
                    print("It's a draw.")
                    game_over = True
                else:
                    player_turn = False
            rotation += 1
        else:
            print("\n")
            print(f"Player {computer} turn.")
            computer_pos = computer_position(the_board)
            place_marker(the_board, computer, computer_pos)
            display_board(the_board)
            computer_win = win_check(the_board, computer)
            full_board = full_board_check(the_board)
            if computer_win == True: 
                print("You lose!")
                game_over = True
            else:
                if full_board == True:
                    print("It's a draw.")
                    game_over = True
                else:
                    player_turn = True
            rotation += 1

game()
               
    
