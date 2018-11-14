%:- use_module(library(lists)).

%--------------------------------------------------------------------------------
%Inicial board
%--------------------------------------------------------------------------------
initialBoard([
  [2,2,2,2,2,2,2],
  [2,2,2,2,2,2,2],
  [2,2,2,2,2,2,2],
  [2,2,2,2,2,2,2]
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
%---------------------------------------------------------------------------------
%Unicode translation end
%---------------------------------------------------------------------------------

%---------------------------------------------------------------------------------
%Board display
%---------------------------------------------------------------------------------
drawAll([H | T], Index):-
    drawBoard([H | T], Index).

drawTopBorder:-
    write('                                 '), nl,
    write('    | 0   1   2   3   4   5   6  '), nl,
    write(' ---+--------------------------- '), nl.

drawBoard([], _).
drawBoard([H | T], Index) :-
    write('  '), write(Index), write(' |'),
    drawLine(H), 
    nl,
    write('     ---------------------------'), 
    nl,
    NewIndex is Index+1,
    drawBoard(T, NewIndex).

drawLine([]).
drawLine([H | T]) :-
    write(' '), 
    print_cell(H), 
    write(' |'), 
    drawLine(T).

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

%---------------------------------------------------------------------------------
%Board display end
%---------------------------------------------------------------------------------


%---------------------------------------------------------------------------------
%Matrix functions
%---------------------------------------------------------------------------------

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
checkMostSeedsPlayer1(Board, MostSeeds):-
    checkMostSeedsLine(0, Board, MostSeeds1),
    checkMostSeedsLine(1, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2).

checkMostSeedsPlayer2(Board, MostSeeds):-
    checkMostSeedsLine(2, Board, MostSeeds1),
    checkMostSeedsLine(3, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2).

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
    checkMostSeedsPlayer1(Board, MostSeeds),
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
    checkMostSeedsPlayer2(Board, MostSeeds),
    MostSeeds =:= 1,
    updateCoords(Line, Column, NewLine, NewColumn),
    getMatrixSeedAt(NewLine, NewColumn, Board, SeedsAt2),
    SeedsAt2 \= 1,
    Boolean is 1.

checkMovePossiblePlayer2(Line, Column, Board, Boolean):-
    getMatrixSeedAt(Line, Column, Board, Seeds),
    Seeds > 0,
    checkMostSeedsPlayer2(Board, MostSeeds),
    MostSeeds > 1,
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
    setMatrixSeedAtWith(Line1, Column, 0, Board, BoardIntermediate),
    setMatrixSeedAtWith(Line2, Column, 0, BoardIntermediate, NewBoard).

eatSeedsPlayer1(_, _, Board, Board).

eatSeedsPlayer2(Line, Column, Board, NewBoard):-
    canEatPlayer2(Line, Column, Board, Boolean),
    Boolean =:= 1,
    Line1 is Line - 1,
    Line2 is Line - 2,
    setMatrixSeedAtWith(Line1, Column, 0, Board, BoardIntermediate),
    setMatrixSeedAtWith(Line2, Column, 0, BoardIntermediate, NewBoard).

eatSeedsPlayer2(_, _, Board, Board).

/**
*checks if either one of the players has won
*/
checkWinPlayer1(Board):-
    checkMostSeedsLine(2, Board, MostSeeds1),
    checkMostSeedsLine(3, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2),
    MostSeeds =:= 0,
    write('Player 1 has Won'),
    init.

checkWinPlayer1(_).
    
checkWinPlayer2(Board):-
    checkMostSeedsLine(0, Board, MostSeeds1),
    checkMostSeedsLine(1, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2),
    MostSeeds =:= 0,
    write('Player 2 has Won'),
    init.    

checkWinPlayer2(_).


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
    drawTopBorder,
    drawAll(Board, 0),
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
    drawTopBorder,
    drawAll(Board, 0),
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
* moveOneHouse takes all the seeds of one house and distribute them clockwise
*/
moveOneHouse(Line, Column, 0, Line, Column, Board , Board).
moveOneHouse(Line, Column, Seeds, FinalLine, FinalColumn, Board, NewBoard):-
    Seeds > 0,
    updateCoords(Line,Column,NewLine,NewColumn),
    incrementOne(NewLine,NewColumn,Board, BoardInc),

    NewSeeds is Seeds - 1,
    moveOneHouse(NewLine, NewColumn, NewSeeds, FinalLine, FinalColumn, BoardInc, NewBoard).
        
%---------------------------------------------------------------------------------
%Game logic end
%---------------------------------------------------------------------------------


%---------------------------------------------------------------------------------
%Game
%---------------------------------------------------------------------------------
init:-
    initialBoard(Tab),
    playerVsPlayer(Tab).


playerVsPlayer(Board):-
    clearSreen,
    drawTopBorder,
    drawAll(Board, 0),
    
    move(Board, 1, NewBoard),
    checkWinPlayer1(NewBoard),

    clearSreen,
    drawTopBorder,
    drawAll(NewBoard, 0),

    move(NewBoard, 2, NewBoard2),
    checkWinPlayer2(NewBoard2),

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
