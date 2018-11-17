:- use_module(library(lists)).

%--------------------------------------------------------------------------------
%Inicial board
%--------------------------------------------------------------------------------
initialBoard([
  [1,1,1,1,2,1,2],
  [2,2,2,2,2,2,2],
  [0,0,0,0,0,0,2],
  [0,0,0,0,0,0,2]
]).
%---------------------------------------------------------------------------------
%Inicial board end
%---------------------------------------------------------------------------------

%---------------------------------------------------------------------------------
%Unicode translation
%---------------------------------------------------------------------------------
print_cell(0):- put_code(48).
print_cell(1):- put_code(49). 
print_cell(2):- put_code(50).
print_cell(3):- put_code(51).
print_cell(4):- put_code(52). 
print_cell(5):- put_code(53).
print_cell(6):- put_code(54).
print_cell(7):- put_code(55). 
print_cell(8):- put_code(56).
print_cell(9):- put_code(57).

print_cell(+):- put_code(9532).
%---------------------------------------------------------------------------------
%Unicode translation end
%---------------------------------------------------------------------------------

%---------------------------------------------------------------------------------
%Board display
%---------------------------------------------------------------------------------
/**
* display the Board passed as argument
*/
drawCompleteBoard([H | T]):-
    drawTopBorder,
    drawBoard([H | T], 0).

/**
* display the top part of the board
*/
drawTopBorder:-
    write('                                 '), nl,
    write('      0   1   2   3   4   5   6  '), nl,
    write('     --------------------------- '), nl.

/**
* display the indices of the lines starting at Index and after the Board passed as argument
*/
drawBoard([], _).
drawBoard([H | T], Index) :-
    write('  '), write(Index), write(' |'),
    drawLine(H), nl,
    write('     ---------------------------'), nl,
    NewIndex is Index+1,
    drawBoard(T, NewIndex).

/**
* draw the Line passed as argument
*/
drawLine([]).
drawLine([H | T]) :-
    write(' '), 
    print_cell(H), 
    write(' |'), 
    drawLine(T).

/**
* draw Hawalis title
*/
drawTitle:-
    write('  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. '), nl,
    write(' | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |'), nl,
    write(' | |  ____  ____  | || |      __      | || | _____  _____ | || |      __      | || |   _____      | || |     _____    | || |    _______   | |'), nl,
    write(' | | |_   ||   _| | || |     /  \\     | || ||_   _||_   _|| || |     /  \\     | || |  |_   _|     | || |    |_   _|   | || |   /  ___  |  | |'), nl,
    write(' | |   | |__| |   | || |    / /\\ \\    | || |  | | /\\ | |  | || |    / /\\ \\    | || |    | |       | || |      | |     | || |  |  (__ \\_|  | |'), nl,
    write(' | |   |  __  |   | || |   / ____ \\   | || |  | |/  \\| |  | || |   / ____ \\   | || |    | |   _   | || |      | |     | || |   \'.___`-.   | |'), nl,
    write(' | |  _| |  | |_  | || | _/ /    \\ \\_ | || |  |   /\\   |  | || | _/ /    \\ \\_ | || |   _| |__/ |  | || |     _| |_    | || |  |`\\____) |  | |'), nl,
    write(' | | |____||____| | || ||____|  |____|| || |  |__/  \\__|  | || ||____|  |____|| || |  |________|  | || |    |_____|   | || |  |_______.\'  | |'), nl,
    write(' | |              | || |              | || |              | || |              | || |              | || |              | || |              | |'), nl,
    write(' | \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' |'), nl,
    write('  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\' '), nl.
   
/**
* draw menu
*/
drawMenu:-
    repeat,
    write('                                                                                                                                                 '), nl,
    write('.................................................................................................................................................'), nl,
    write('                                               __    __      ________      ___     _     __     __                                               '), nl,
    write('                                              |  \\  /  |    |  ______|    |   \\   | |   |  |   |  |                                              '), nl,
    write('                                              |   \\/   |    | |______     | |\\ \\  | |   |  |   |  |                                              '), nl,
    write('                                              |   __   |    | |______|    | | \\ \\ | |   |  |   |  |                                              '), nl,
    write('                                              |  |  |  |    | |______     | |  \\ \\| |   |  |___|  |                                              '), nl,
    write('                                              |__|  |__|    |________|    |_|   \\___|   |_________|                                              '), nl,nl,
    write('    /|    __      __        '),nl,
    write('   / |   |__||   |__| \\ /   '),nl,
    write('     |:: |   |__ |  |  /  ' ),nl,nl,                       
    write('  ___     _____       __ _____  __        ___ _____ ___   ___        __  '),nl,
    write('  ___|      |   |\\ | |__   |   |__| |  | |      |    |   |   | |\\ | |__  '),nl,
    write(' |___ ::  __|__ | \\|  __|  |   |  \\ |__| |___   |   _|_  |___| | \\|  __|  '),nl,nl,
    write('  ___     ___        _____  _____      '),nl,
    write('  ___|   |   | |   |   |      |   '),nl,
    write('  ___|:: |___\\ |___| __|__    |  '),nl,nl,nl,
    write('.................................................................................................................................................'), nl,

    write('CHOOSE YOUR OPCTION: '), nl,
    read(OpctionM), OpctionM > 0, OpctionM =< 4,
    doit(OpctionM).

doit(1):-
    drawSubMenu.

doit(2):-
  clearSreen,
  write('-----------------------------------------------------------------------INSTRUCTIONS-----------------------------------------------------------------------'), nl,
  write('1.A player wins a game if he captures all of the opponent s seeds.'), nl,nl,
  write('2.Players take turns sowing their seeds.'),nl,nl,
  write('3.A player picks all seeds up from one of the pits on his side that contains 2 or more seeds.'), nl,nl,
  write('4.Starting from the next pit in counter-clockwise direction, the player drops one of the taken seeds in the following pits all around player s two rows.'),nl,nl,
  write('5.If the last sown seed  lands in an occupied pit then the player picks all these seeds up (including the one that just landed in the pit) and continues'),nl,
  write('sowing them in counter-clockwise direction starting from the next pit.'),nl,nl,
  write('6.If the last sown seed lands in an empty pit  then the turn ends.  If this empty pit is in the inner row and the opposite pit on the opponent s inner row is occupied then all the seeds in the opponent s pit are captured by the player and removed from the board.'),nl,
  write('In addition, if the opposite pit on the opponent s outer row also contains seeds then all those seeds are captured too and removed from the board.'),nl,nl,
  write('7.A player is allowed to pick up a seed from a pit containing only a single seed only if no pit on the player s side contains more than one seed. In this'),nl,
  write('case a player is not allowed to move a single seed to an occupied pit.'),nl,nl,
  write('8.If a player does not have any seeds on his side then the player loses the game.'),nl,
  write('-----------------------------------------------------------------------------------------------------------------------------------------------------------'), nl, nl,nl,
  drawMenu.
  
doit(3):- !.

/**
* draw sub-menu
*/
drawSubMenu:-
    repeat,
    write('.......................'), nl,
    write('     MODO DE JOGO      '), nl,
    write('.......................'), nl,nl,
    write('1.1 PLAYER VS PLAYER'), nl, 
    write('1.2 PLAYER VS COMPUTER '), nl,
    write('1.3 COMPUTER VS COMPUTER '), nl,nl,
    write('1.4 BACK '), nl,
    write('1.5 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    read(OpctionSm), nl, OpctionSm > 0, OpctionSm =< 1.6,
    doit(OpctionSm).

doit(1.1):-
    init.

doit(1.2):-
  init.

doit(1.3):-
  init.

doit(1.4):-
    drawMenu.

doit(1.5):- !.
  

%---------------------------------------------------------------------------------
%Board display end
%---------------------------------------------------------------------------------
  

%---------------------------------------------------------------------------------
%Matrix functions
%---------------------------------------------------------------------------------
/**
* Creates a Matrix with the given Lines and Columns with element in every position
*/
createMatrix(0, _, _, _).
createMatrix(Lines, Columns, Element, [H|T]):-
    Lines1 is Lines - 1,
    createLine(Columns, Element, H),
    createMatrix(Lines1, Columns, Element, T).

createLine(0, _, _).
createLine(Columns, Element, [H|T]):-
    Columns1 is Columns - 1,
    H is Element,
    createLine(Columns1, Element, T).


/**
* get the element at line and column of the board
*/
getMatrixSeedAt(0, Column, [HeaderLines|_], Seed):-
	getLineSeedAt(Column, HeaderLines, Seed).

getMatrixSeedAt(Line, Column, [_|TailLines], Seed):-
	Line > 0,
	NewLine is Line-1,
	getMatrixSeedAt(NewLine, Column, TailLines, Seed).

getLineSeedAt(0, [HeaderSeeds|_], HeaderSeeds).

getLineSeedAt(Index, [_|TailSeeds], Seed):-
	Index > 0,
	NewIndex is Index-1,
	getLineSeedAt(NewIndex, TailSeeds, Seed).

/**
* set the element at line and column of the board to the newElemnet returning the newBoard
*/
setMatrixSeedAtWith(0, Column, NewSeed, [HeaderLines|TailLines], [NewHeaderLines|TailLines]):-
	setListSeedAtWith(Column, NewSeed, HeaderLines, NewHeaderLines).

setMatrixSeedAtWith(Line, Column, NewSeed, [HeaderLines|TailLines], [HeaderLines|NewTailLines]):-
	Line > 0,
	NewLine is Line-1,
	setMatrixSeedAtWith(NewLine, Column, NewSeed, TailLines, NewTailLines).

setListSeedAtWith(0, NewSeed, [_|TailSeeds], [NewSeed|TailSeeds]).

setListSeedAtWith(Index, NewSeed, [HeaderSeeds|TailSeeds], [HeaderSeeds|NewTailSeeds]):-
	Index > 0,
	NewIndex is Index-1,
	setListSeedAtWith(NewIndex, NewSeed, TailSeeds, NewTailSeeds).

/**
* return the the max of a list
*/
max_list([H|T], Max) :-
    max_list(T, H, Max).

max_list([], Max, Max).
max_list([H|T], Max0, Max) :-
    Max1 is max(H, Max0),
    max_list(T, Max1, Max).

%---------------------------------------------------------------------------------
%Matrix functions
%---------------------------------------------------------------------------------

%---------------------------------------------------------------------------------
%Game logic
%---------------------------------------------------------------------------------
/**
*adds one seed at Board[Line,Column]
*/
incrementOne(Line, Column, Board, NewBoard):-
    getMatrixSeedAt(Line, Column, Board, Seed),
    NewSeed is Seed + 1,
    setMatrixSeedAtWith(Line, Column, NewSeed, Board, NewBoard).

/**
*retrives on Seeds all seeds at Board[Line,Column] putting the position at 0 
*/
takeAllSeedsAt(Line, Column, Board, NewBoard, Seeds):-
    getMatrixSeedAt(Line, Column, Board, Seeds),
    setMatrixSeedAtWith(Line, Column, 0, Board, NewBoard).

/**
*retrives in MostSeeds most seeds a player has in his board side
*/
value(Board, 1, Value):-
    checkMostSeedsLine(0, Board, MostSeeds1),
    checkMostSeedsLine(1, Board, MostSeeds2),
    Value is max(MostSeeds1, MostSeeds2).

value(Board, 2, Value):-
    checkMostSeedsLine(2, Board, MostSeeds1),
    checkMostSeedsLine(3, Board, MostSeeds2),
    Value is max(MostSeeds1, MostSeeds2).

checkMostSeedsLine(0, [HeaderLines|_], MostSeeds):-
	max_list(HeaderLines, MostSeeds).

checkMostSeedsLine(Line, [_|TailLines], MostSeeds):-
	Line > 0,
	NewLine is Line-1,
	checkMostSeedsLine(NewLine, TailLines, MostSeeds).
/**
*Walk a position in a counter clock way where NewLine and NewColumn are the new coordinates
*/
updateCoords(Line,Column, NewLine, NewColumn):-
    (Line =:= 0; Line =:= 2),
    updateCoordsTop(Line,Column, NewLine, NewColumn).

updateCoords(Line,Column, NewLine, NewColumn):-
    (Line =:= 1; Line =:= 3),
    updateCoordsBot(Line,Column, NewLine, NewColumn).

updateCoordsTop(Line, Column, NewLine, NewColumn):-
    Column =:= 0,
    NewLine is Line + 1,
    NewColumn is Column.

updateCoordsTop(Line, Column, NewLine, NewColumn):-
    NewLine is Line,
    NewColumn is Column - 1.

updateCoordsBot(Line,Column, NewLine, NewColumn):-
    Column =:= 6,
    NewLine is Line - 1,
    NewColumn is Column.

updateCoordsBot(Line,Column, NewLine, NewColumn):-
    NewLine is Line,
    NewColumn is Column + 1.

/**
*Checks if the move where the Board[Line, Column] is played is possible: if yes Boolean is 1; if no Boolean is 0
*/
checkPossibleMove(Line, Column, Board, Boolean):-
    (Line =:= 0; Line =:= 1),
    checkMovePossiblePlayer1(Line, Column, Board, Boolean).

checkPossibleMove(Line, Column, Board, Boolean):-
    (Line =:= 2; Line =:= 3),
    checkMovePossiblePlayer2(Line, Column, Board, Boolean).

checkMovePossiblePlayer1(Line, Column, Board, Boolean):-
    getMatrixSeedAt(Line, Column, Board, SeedsAt),
    SeedsAt > 0,
    value(Board, 1, MostSeeds),
    MostSeeds =:= 1,
    updateCoords(Line, Column, NewLine, NewColumn),
    getMatrixSeedAt(NewLine, NewColumn, Board, SeedsAt2),
    SeedsAt2 \= 1,
    Boolean is 1.

checkMovePossiblePlayer1(Line, Column, Board, Boolean):-
    getMatrixSeedAt(Line, Column, Board, Seeds),
    Seeds > 1,
    Boolean is 1.

checkMovePossiblePlayer1(_, _, _, Boolean):-
    Boolean is 0.

checkMovePossiblePlayer2(Line, Column, Board, Boolean):-
    getMatrixSeedAt(Line, Column, Board, SeedsAt),
    SeedsAt > 0,
    value(Board, 2, MostSeeds),
    MostSeeds =:= 1,
    updateCoords(Line, Column, NewLine, NewColumn),
    getMatrixSeedAt(NewLine, NewColumn, Board, SeedsAt2),
    SeedsAt2 \= 1,
    Boolean is 1.

checkMovePossiblePlayer2(Line, Column, Board, Boolean):-
    getMatrixSeedAt(Line, Column, Board, Seeds),
    Seeds > 0,
    Boolean is 1.

checkMovePossiblePlayer2(_, _, _, Boolean):-
    Boolean is 0.

/**
*checks if when a turn ends the player will eat seeds: if yes Boolean is 1; if no Boolean is 0
*/
canEat(Line, Column, Board, Boolean):-
    Line =:= 1,
    canEatPlayer1(Line, Column, Board, Boolean).

canEat(Line, Column, Board, Boolean):-
    Line =:= 2,
    canEatPlayer2(Line, Column, Board, Boolean).

canEat(_, _, _, Boolean):-
    Boolean is 0.

canEatPlayer1(Line, Column, Board, Boolean):-
    LineToEat is Line + 1,
    getMatrixSeedAt(LineToEat, Column, Board, Seed),
    Seed > 0,
    Boolean is 1.

canEatPlayer1(_, _, _, Boolean):-
    Boolean is 0.

canEatPlayer2(Line, Column, Board, Boolean):-
    LineToEat is Line - 1,
    getMatrixSeedAt(LineToEat, Column, Board, Seed),
    Seed > 0,
    Boolean is 1.

canEatPlayer2(_, _, _, Boolean):-
    Boolean is 0.

/**
*eats seeds from the other player
*/
eatSeeds(Line, Column, Board, NewBoard):-
    Line =:= 1,
    eatSeedsPlayer1(Line, Column, Board, NewBoard).

eatSeeds(Line, Column, Board, NewBoard):-
    Line =:= 2,
    eatSeedsPlayer2(Line, Column, Board, NewBoard).

eatSeeds(Line, _, Board, Board):-
    (Line =:= 0; Line =:= 3),
    !.

eatSeedsPlayer1(Line, Column, Board, NewBoard):-
    canEatPlayer1(Line, Column, Board, Boolean),
    Boolean =:= 1,
    Line1 is Line + 1,
    Line2 is Line + 2,
    setMatrixSeedAtWith(Line1, Column, 0, Board, BoardInterHelperListiate),
    setMatrixSeedAtWith(Line2, Column, 0, BoardInterHelperListiate, NewBoard).

eatSeedsPlayer1(_, _, Board, Board).

eatSeedsPlayer2(Line, Column, Board, NewBoard):-
    canEatPlayer2(Line, Column, Board, Boolean),
    Boolean =:= 1,
    Line1 is Line - 1,
    Line2 is Line - 2,
    setMatrixSeedAtWith(Line1, Column, 0, Board, BoardInterHelperListiate),
    setMatrixSeedAtWith(Line2, Column, 0, BoardInterHelperListiate, NewBoard).

eatSeedsPlayer2(_, _, Board, Board).

/**
*checks if either one of the players has won
*/
game_over(Board):-
    checkMostSeedsLine(2, Board, MostSeeds1),
    checkMostSeedsLine(3, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2),
    MostSeeds =:= 0,
    write('Player 1 has Won'),
    init.
    
game_over(Board):-
    checkMostSeedsLine(0, Board, MostSeeds1),
    checkMostSeedsLine(1, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2),
    MostSeeds =:= 0,
    write('Player 2 has Won'),
    init.    

game_over(_).


/**
* MovePlayerX first reads the line and column the player want to play, then checks 
* if the play is possible and only then calls the moveLoop function to do a move
*/
move(Board, 1, NewBoard):-
    nl, write('Player 1 turn:'), nl,nl,
    readPlay(Line, Column),
    (Line = 0; Line = 1),
    checkPossibleMove(Line, Column, Board, Boolean),
    Boolean =:= 1,
    takeAllSeedsAt(Line,Column,Board, Board1, Seeds),
    moveLoop(Line, Column, Seeds, Board1 , NewBoard, 0).

move(Board, 1, NewBoard):-
    clearSreen,
    write('Can\'t play in those coordinates'), nl,
    drawCompleteBoard(Board),
    move(Board, 1, NewBoard).

move(Board, 2, NewBoard):-
    nl, write('Player 2 turn:'), nl, nl,
    readPlay(Line, Column),
    (Line = 2; Line = 3),
    checkPossibleMove(Line, Column, Board, Boolean),
    Boolean =:= 1,
    takeAllSeedsAt(Line,Column,Board, Board1, Seeds),
    moveLoop(Line, Column, Seeds, Board1 , NewBoard, 0).

move(Board, 2, NewBoard):-
    clearSreen,
    write('Can\'t play in those coordinates'), nl,
    drawCompleteBoard(Board),
    move(Board, 2, NewBoard).
    
/**
* moveLoop moves diferent houses(moveOneHouse) until the last seed lands on a empty space 
*/    
moveLoop(Line, Column, 1, Board, FinalBoard, Iteracao):-
    Iteracao > 0,
    incrementOne(Line, Column, Board, Board1),
    eatSeeds(Line, Column, Board1, FinalBoard).

moveLoop(Line, Column, Seeds, Board , X, Iteracao):-
    Iteracao1 is Iteracao + 1,
    moveOneHouse(Line, Column, Seeds, FinalLine, FinalColumn, Board , NewBoard),
    takeAllSeedsAt(FinalLine,FinalColumn, NewBoard, FinalBoard, SeedsAtPos),
    moveLoop(FinalLine, FinalColumn, SeedsAtPos, FinalBoard, X, Iteracao1), !.

/**
* moveOneHouse takes all the seeds of one house and distribute them anti-clockwise
*/
moveOneHouse(Line, Column, 0, Line, Column, Board , Board).
moveOneHouse(Line, Column, Seeds, FinalLine, FinalColumn, Board, NewBoard):-
    Seeds > 0,
    updateCoords(Line,Column,NewLine,NewColumn),
    incrementOne(NewLine,NewColumn,Board, BoardInc),

    NewSeeds is Seeds - 1,
    moveOneHouse(NewLine, NewColumn, NewSeeds, FinalLine, FinalColumn, BoardInc, NewBoard).

/**
* valid_moves return a list of possible moves like this [Line, Column] for the player 
* given by the second argument in the Board passed as first argument 
*/
valid_moves(Board, 1, ListOfMoves):-
    valid_moves_listing(0, 0, Board, ListOfMoves1, []),
    valid_moves_listing(1, 0, Board, ListOfMoves2, []),
    append(ListOfMoves1, ListOfMoves2, ListOfMoves).

valid_moves(Board, 2, ListOfMoves):-
    valid_moves_listing(2, 0, Board, ListOfMoves1, []),
    valid_moves_listing(3, 0, Board, ListOfMoves2, []),
    append(ListOfMoves1, ListOfMoves2, ListOfMoves).  

/**
* list all possible moves in the lines given by the first argument and the columns 
* between the second argument and 7(the number of columns is 6) of the board passed  
* as thir argument returning the list ListOfMoves
*/  
valid_moves_listing(_, 7, _, HelperList, HelperList).
valid_moves_listing(Line, Column, Board, ListOfMoves, HelperList):-
    checkPossibleMove(Line, Column, Board, Boolean), 
    Boolean =:= 1, 
    append([Line], [Column], Coordinates),
    append(HelperList, [Coordinates], UpdatedList),
    Column1 is Column + 1,
    valid_moves_listing(Line, Column1, Board, ListOfMoves, UpdatedList).
    
valid_moves_listing(Line, Column, Board, ListOfMoves, HelperList):-
    Column1 is Column + 1,
    valid_moves_listing(Line, Column1, Board, ListOfMoves, HelperList).


%---------------------------------------------------------------------------------
%Game logic end
%---------------------------------------------------------------------------------


%---------------------------------------------------------------------------------
%Game
%---------------------------------------------------------------------------------
init:-
    initialBoard(Matrix),
    %createMatrix(4,7,3,Matrix),
    %valid_moves(Matrix, 1, List),
    %length(List,X),
    %write(X).

    
    %write(List), nl,
    %write([1,2,3,4,5]), nl,
    
    
    playerVsPlayer(Matrix).

playerVsPlayer(Board):-
    clearSreen,
    drawCompleteBoard(Board),
    
    valid_moves(Board, 1, ListOfMoves),
    write(ListOfMoves),
    move(Board, 1, NewBoard),
    game_over(NewBoard),

    clearSreen,
    drawCompleteBoard(NewBoard),

    valid_moves(NewBoard, 2, ListOfMoves2),
    write(ListOfMoves2),
    move(NewBoard, 2, NewBoard2),
    game_over(NewBoard2),

    playerVsPlayer(NewBoard2).

readPlay(Line, Column) :-
    write('Insert the coordinates of the cell you want to play'), nl,
	write('Line: '),
    read(Line),
	get_char(_),

    write('Column: '),
    read(Column),
	get_char(_).

clearSreen:-
    nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

%---------------------------------------------------------------------------------
%Game end
%---------------------------------------------------------------------------------