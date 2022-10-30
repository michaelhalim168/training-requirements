### GAME FUNCTIONS ###

# display_round_number() displays the round number
display_round_number <- function(round_num){
  
  cat("###############", "\n")
  cat("### Round", round_num, "###", "\n")
  cat("###############\n")
  
}

# display_board() displays the board
display_board <- function(board){
  
  cat("Current Board:", "\n\n", "~~~~~~~~~~~~~~~~~~~", "\n\n")
  print(board)
  cat("\n\n", "~~~~~~~~~~~~~~~~~~~", "\n\n")
  
}

# player_input() prompts the user to choose between X or O
player_input <- function(con) {
  
  cat("X or O? ")
  marker <- toupper(readLines(con=con, n=1))
  
  while (!marker %in% c("X", "O")) {
    cat("Invalid response. Choose X or O.")
    marker <- toupper(readLines(con=con, n=1))
  }
  
  if (marker == "X"){
    return(c("X", "O"))
  } else {
    return(c("O", "X"))
  }
}

# place_symbol() updates the board 
place_symbol <- function(board, symbol, pos){
  board[pos[1], pos[2]] <- symbol
  return(board)
}

# win_check() checks if winning combination exists
win_check <- function(board, symbol){
  
  for(i in 1:length(winning_combinations)){
    if(sum(which(board == symbol) %in% winning_combinations[[i]]) >= 3){
      return(TRUE)
    }
  }
  return(FALSE)
}

# space_check() checks if space in board is empty
space_check <- function(board, pos){
  has_space = is.na(board[pos[1], pos[2]])
  return(has_space)
}

# full_board_check() checks if board is full
full_board_check <- function(board){
  
  not_full = any(is.na(board))
  return(not_full)
}

# player_position() prompts user for location to put marker on board
player_position <- function(board, symbol, con){
  
  while (TRUE){
    
    cat("Please enter row: ")
    row <- as.integer(readLines(con=con, n=1))
    cat("Please enter column: ")
    col <- as.integer(readLines(con=con, n=1))
    pos <- c(row, col)
    
    
    if ((!row %in% seq(1:3)) | (!col %in% seq(1:3))){
      cat("Invalid input. Please choose 1, 2, or 3 for row and column.\n")
      next()
    } else {
      if(space_check(board, pos) == FALSE){
        cat("Invalid location. Please choose 1, 2, or 3 for row and column.\n")
        next()
      } else{
        cat(paste0("Move ", symbol, " at row ", row, " and columns ", col, ". y/n? "))
        check_pos <- tolower(readLines(con=con, n=1))
        if(check_pos == 'y'){
          cat("Move placed!", "\n\n")
          break()
        } else if (check_pos == 'n') {
          cat("Move not placed.", "\n\n")
          next()
        } else {
          cat("Invalid input. Try again.", "\n\n")
          next()
        }
      }
    }
  }
  return(c(row, col))
}

# computer_position() generates a random location on board for computer
computer_position <- function(board){
  
  while (TRUE){
    row <- sample.int(3, 1)
    col <- sample.int(3, 1)
    pos <- c(row, col)
    
    if (space_check(board, pos) == TRUE){
      cat("Computer move placed.", "\n\n")
      break()
    }
  }
  return (pos)
}

# game() runs tic tac toe game
game <- function() {
  
  cat("TIC-TAC TOE GAME!\n")
  Sys.sleep(1)
  
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  
  marker_choice <- player_input(con = con)
  player <- marker_choice[1]
  computer <- marker_choice[2]
  round_num <- 1
  rotation <- 2
  
  if (player == "X" && computer == "O"){
    player_turn = TRUE
  } else {
    player_turn = FALSE
  }
  
  while (TRUE){
    
    if (rotation %% 2 == 0){
      display_round_number(round_num)
      round_num <- round_num + 1
      Sys.sleep(1)
    }
    
    if (player_turn == TRUE) {
      cat("Player ", player, " turn.", "\n\n")
      player_pos = player_position(board, player, con)
      board <- place_symbol(board, player, player_pos)
      display_board(board)
      player_win <- win_check(board, player)
      not_draw <- full_board_check(board)
      
      if (player_win == TRUE){
        cat("Congratulations! You Win!\n")
        break()
      } else{
        if (not_draw == FALSE){
          cat("It's a draw.\n")
          break()
        } else{
          player_turn <- FALSE
          rotation <- rotation + 1
          Sys.sleep(1)
        }
      }
    } else {
      cat("Player ", computer, " turn.", "\n\n")
      computer_pos = computer_position(board)
      board <- place_symbol(board, computer, computer_pos)
      display_board(board)
      computer_win = win_check(board, computer)
      not_draw = full_board_check(board)
      
      if (computer_win == TRUE) {
        print("You lose.\n")
        break()
      } else {
        if (not_draw == FALSE) {
          cat("It's a draw.\n")
          break()
        } else {
          player_turn <- TRUE
          rotation <- rotation + 1
          Sys.sleep(1)
        }
      }
    }
    }
  }

#### Variables and Game ####
board <- matrix(nrow=3, ncol=3)
winning_combinations = list(c(1,2,3), c(4,5,6), c(7,8,9), c(1,4,7), c(2,5,8), c(3,6,9), c(1,5,9), c(3,5,7))
game()
