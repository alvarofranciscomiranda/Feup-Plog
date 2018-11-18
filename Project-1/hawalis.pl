:- use_module(library(lists)).
:- use_module(library(random)).

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
    write('     ___________________________ '), nl.

/**
* display the indices of the lines starting at Index and after the Board passed as argument
*/
drawBoard([], _).
drawBoard([H | T], Index) :-
    write('  '), write(Index), write(' |'),
    drawLine(H), nl,
    write('    |___|___|___|___|___|___|___|'), nl,
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

/**
* gets the sum of all elements of the line given of the board given
*/
getSumOfLine(0, [H|_], SumOfLine):-
    list_sum(H, SumOfLine).
getSumOfLine(Line, [_|T], Sum):-
    Line > 0,
	NewLine is Line-1,
	getSumOfLine(NewLine, T, Sum).

list_sum([], 0).
list_sum([Head | Tail], TotalSum) :-
    list_sum(Tail, Rest),
    TotalSum is Head + Rest.


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
*retrives in Most the amount of seeds a player has in a house in his board side
*/
checkHigherHouseSeeds(Board, 1, Most):-
    checkMostSeedsLine(0, Board, MostSeeds1),
    checkMostSeedsLine(1, Board, MostSeeds2),
    Most is max(MostSeeds1, MostSeeds2).

checkHigherHouseSeeds(Board, 2, Most):-
    checkMostSeedsLine(2, Board, MostSeeds1),
    checkMostSeedsLine(3, Board, MostSeeds2),
    Most is max(MostSeeds1, MostSeeds2).

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
    (Column = 0; Column = 1; Column = 2; Column = 3; Column = 4; Column = 5; Column = 6),
    getMatrixSeedAt(Line, Column, Board, SeedsAt),
    SeedsAt > 0,
    checkHigherHouseSeeds(Board, 1, MostSeeds),
    MostSeeds =:= 1,
    updateCoords(Line, Column, NewLine, NewColumn),
    getMatrixSeedAt(NewLine, NewColumn, Board, SeedsAt2),
    SeedsAt2 \= 1,
    Boolean is 1.

checkMovePossiblePlayer1(Line, Column, Board, Boolean):-
    (Column = 0; Column = 1; Column = 2; Column = 3; Column = 4; Column = 5; Column = 6),
    getMatrixSeedAt(Line, Column, Board, Seeds),
    Seeds > 1,
    Boolean is 1.

checkMovePossiblePlayer1(_, _, _, Boolean):-
    Boolean is 0.

checkMovePossiblePlayer2(Line, Column, Board, Boolean):-
    (Column = 0; Column = 1; Column = 2; Column = 3; Column = 4; Column = 5; Column = 6),
    getMatrixSeedAt(Line, Column, Board, SeedsAt),
    SeedsAt > 0,
    checkHigherHouseSeeds(Board, 2, MostSeeds),
    MostSeeds =:= 1,
    updateCoords(Line, Column, NewLine, NewColumn),
    getMatrixSeedAt(NewLine, NewColumn, Board, SeedsAt2),
    SeedsAt2 \= 1,
    Boolean is 1.

checkMovePossiblePlayer2(Line, Column, Board, Boolean):-
    (Column = 0; Column = 1; Column = 2; Column = 3; Column = 4; Column = 5; Column = 6),
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
game_over(Board, 1):-
    value(Board, 1, Value),
    Value = 28,
    write('Player 1 has Won'), nl,
    write('Press any key to go to Menu'),
    pressLetter,
    menu.
    
game_over(Board, 2):-
    value(Board, 2, Value),
    Value = 28,
    write('Player 2 has Won'), nl,
    write('Press any key to go to Menu'),
    pressLetter,
    menu.    

game_over(_, _).


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
    valid_moves(Board, 1, List),
    write('Possible moves you can play:'), nl,
    write(List),
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
    valid_moves(Board, 2, List),
    write('Possible moves you can play:'), nl,
    write(List),
    move(Board, 2, NewBoard).

/**
* move for Pc
*/
move(Line, Column, Board, 1, NewBoard):-
    takeAllSeedsAt(Line, Column, Board, Board1, Seeds),
    moveLoop(Line, Column, Seeds, Board1 , NewBoard, 0).

move(Line, Column, Board, 2, NewBoard):-
    takeAllSeedsAt(Line, Column, Board, Board1, Seeds),
    moveLoop(Line, Column, Seeds, Board1 , NewBoard, 0).
    
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

/**
* returns in value the total seeds he has already eaten from his opponent 
* (28 initial seeds - those he stll has), the higher the value the better
* are the chances of winning; if  
*/
value(Board, 1, Value):-
    getSumOfLine(2, Board, Sum1),
    getSumOfLine(3, Board, Sum2),
    Value is 28 - (Sum1 + Sum2).

value(Board, 2, Value):-
    getSumOfLine(0, Board, Sum1),
    getSumOfLine(1, Board, Sum2),
    Value is 28 - (Sum1 + Sum2).    


/**
* choose_move(+Board, +Dificulty, +Player, -Move)
*/
choose_move(Board, 1, Player, Move):-
    valid_moves(Board, Player, ListOfMoves),
    length(ListOfMoves, Length),
    random(0, Length, Random),
    nth0(Random, ListOfMoves, Move).

choose_move(Board, 2, Player, Move):-
    valid_moves(Board, Player, ListOfMoves),
    value(Board, Player, Value),
    choose_best_moves(Board, Player, ListOfMoves, [], Value, BestMoves, _),
    length(BestMoves, Length),
    random(0, Length, Random),
    nth0(Random, BestMoves, Move).
    
choose_best_moves(_, _, [], MovesAnnex, ValueAnnex, MovesAnnex, ValueAnnex).

choose_best_moves(Board, Player, [H|T], _, ValueAnnex, BestMoves, BestValue):- 
    nth0(0, H, Li),
    nth0(1, H, Col),
    move(Li, Col, Board, Player, NewBoard),
    value(NewBoard, Player, Value),
    Value > ValueAnnex,
    append([H], [], NewBestMoves),
    choose_best_moves(Board, Player, T, NewBestMoves, Value, BestMoves, BestValue).


choose_best_moves(Board, Player, [H|T], MovesAnnex, ValueAnnex, BestMoves, BestValue):-
    
    nth0(0, H, Li),
    nth0(1, H, Col),
    move(Li, Col, Board, Player, NewBoard),
    value(NewBoard, Player, Value),
    Value = ValueAnnex,
    append(MovesAnnex, [H], NewBestMoves),
    choose_best_moves(Board, Player, T, NewBestMoves, ValueAnnex, BestMoves, BestValue).

choose_best_moves(Board, Player, [_|T], MovesAnnex, ValueAnnex, BestMoves, BestValue):- 
    choose_best_moves(Board, Player, T, MovesAnnex, ValueAnnex, BestMoves, BestValue).


%---------------------------------------------------------------------------------
%Game logic end
%---------------------------------------------------------------------------------


%---------------------------------------------------------------------------------
%Game
%---------------------------------------------------------------------------------
/**
* draw menu
*/
menu:-
    repeat,
    write('                                                                                                                                                 '), nl,
    write('...........................................................................................................................................................'), nl,
    write('                                                    __    __      ________      ___     _     __     __                                               '), nl,
    write('                                                   |  \\  /  |    |  ______|    |   \\   | |   |  |   |  |                                              '), nl,
    write('                                                   |   \\/   |    | |______     | |\\ \\  | |   |  |   |  |                                              '), nl,
    write('                                                   |   __   |    | |______|    | | \\ \\ | |   |  |   |  |                                              '), nl,
    write('                                                   |  |  |  |    | |______     | |  \\ \\| |   |  |___|  |                                              '), nl,
    write('                                                   |__|  |__|    |________|    |_|   \\___|   |_________|                                              '), nl,nl,
    write('    /|    __      __        '),nl,
    write('   / |   |__||   |__| \\ /   '),nl,
    write('     |:: |   |__ |  |  /  ' ),nl,nl,                       
    write('  ___     _____       __ _____  __        ___ _____ ___   ___        __  '),nl,
    write('  ___|      |   |\\ | |__   |   |__| |  | |      |    |   |   | |\\ | |__  '),nl,
    write(' |___ ::  __|__ | \\|  __|  |   |  \\ |__| |___   |   _|_  |___| | \\|  __|  '),nl,nl,
    write('  ___     ___        _____  _____      '),nl,
    write('  ___|   |   | |   |   |      |   '),nl,
    write('  ___|:: |___\\ |___| __|__    |  '),nl,nl,nl,
    write('...........................................................................................................................................................'), nl,

    write('CHOOSE YOUR OPCTION: '), nl,
    read(OpctionM), OpctionM > 0, OpctionM =< 4,
    doit(OpctionM).

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

drawPvsPCMenu:-
    repeat,
    write('.......................'), nl,
    write('     Dificulty      '), nl,
    write('.......................'), nl,nl,
    write('2.1 Easy'), nl, 
    write('2.2 Hard '), nl,nl,
    write('2.3 BACK '), nl,
    write('2.4 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    read(OpctionS1m), nl, OpctionS1m > 2, OpctionS1m =< 2.5,
    doit(OpctionS1m).

drawPcvsPCMenu:-
    repeat,
    write('.......................'), nl,
    write('     Dificulty      '), nl,
    write('.......................'), nl,nl,
    write('3.1 Easy vs Easy'), nl, 
    write('3.2 Easy vs Hard '), nl,
    write('3.3 Hard vs Hard '), nl, nl,
    write('3.4 BACK '), nl,
    write('3.5 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    read(OpctionS2m), nl, OpctionS2m > 3, OpctionS2m =< 3.6,
    doit(OpctionS2m).

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
  menu.
  
doit(3):- !.


doit(1.1):-
    init(1).

doit(1.2):-
    drawPvsPCMenu.

doit(1.3):-
    drawPcvsPCMenu.

doit(1.4):-
    menu.

doit(1.5):- !.


doit(2.1):-
    init(2).

doit(2.2):-
    init(3).

doit(2.3):-
    drawSubMenu.

doit(2.4):- !.


doit(3.1):-
    init(4).

doit(3.2):-
    init(5).

doit(3.3):-
    init(6).

doit(3.4):-
    drawSubMenu.

doit(3.5):- !.



/**
* playervsPlayer(+Board) creates a hawalis game between a Human and another Human
*/
playerVsPlayer(Board):-
    clearSreen,
    drawCompleteBoard(Board),
    
    move(Board, 1, NewBoard),
    game_over(NewBoard,1),

    clearSreen,
    drawCompleteBoard(NewBoard),

    move(NewBoard, 2, NewBoard2),
    game_over(NewBoard2,2),

    playerVsPlayer(NewBoard2).

/**
* playervsPc(+Board, +Dificulty) creates a hawalis game between a Human and a Pc with difficulty 2
*/
playerVsPc(Board, Dificulty):-
    clearSreen,
    drawCompleteBoard(Board),
    
    move(Board, 1, NewBoard),
    game_over(NewBoard,1),

    clearSreen,
    drawCompleteBoard(NewBoard),

    write('Press any key to let Pc play'),
    pressLetter,

    choose_move(NewBoard, Dificulty, 2, [Li|[Col|_]]),
    move(Li, Col, NewBoard, 2, NewBoard2),
    game_over(NewBoard2,2),

    playerVsPc(NewBoard2, Dificulty).

/**
* playervsPc(+Board, +Dificulty) creates a hawalis game between a Human and a Pc 
*/
pcVsPc(Board, Dificulty1, Dificulty2):-
    clearSreen,
    drawCompleteBoard(Board),

    write('Press any key to let Pc-Player1 play'),
    pressLetter,
    
    choose_move(Board, Dificulty1, 1, [Li|[Col|_]]),
    move(Li, Col, Board, 1, NewBoard),
    game_over(NewBoard,1),

    clearSreen,
    drawCompleteBoard(NewBoard),
    
    write('Press any key to let Pc-Player 2 play'),
    pressLetter,

    choose_move(NewBoard, Dificulty2, 2, [Li2|[Col2|_]]),
    move(Li2, Col2, NewBoard, 2, NewBoard2),
    game_over(NewBoard2,2),

    pcVsPc(NewBoard2, Dificulty1, Dificulty2).


/**
* readPlay(-Line, -Column)
*/
readPlay(Line, Column) :-
    write('Insert the coordinates of the cell you want to play'), nl,
	write('Line: '),
    readImput(Line),

    write('Column: '),
    readImput(Column).

/**
* readImput(-Imput)
*/
readImput(Imput) :-
    read(Imput),
	get_char(_).

/**
* pressLetter continues the program when a key is pressed
*/
pressLetter:-
    get_char(_).

/**
* clearSreen writes many new lines to clear the sreen
*/
clearSreen:-
    nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

init(1):-
    initialBoard(Matrix),
    playerVsPlayer(Matrix).

init(2):-
    initialBoard(Matrix),
    playerVsPc(Matrix, 1).

init(3):-
    initialBoard(Matrix),
    playerVsPc(Matrix, 2).

init(4):-
    initialBoard(Matrix),
    pcVsPc(Matrix, 1, 1).

init(5):-
    initialBoard(Matrix),
    pcVsPc(Matrix, 1, 2).

init(6):-
    initialBoard(Matrix),
    pcVsPc(Matrix, 2, 2).


hawalis:-
    clearSreen,
    drawTitle,
    menu.

%---------------------------------------------------------------------------------
%Game end
%---------------------------------------------------------------------------------