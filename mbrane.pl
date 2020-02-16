:- use_module(library(lists)).
:- use_module(library(random)).

%-------------------------------------------------------------------------------------------------------------
%    BOARDS
%-------------------------------------------------------------------------------------------------------------

/*
* Empty Board 
*/
initialBoard([
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0]
]).

/*
* Empty Points Board 
*/
initialPoints([
  [0.0,0.0,0.0],
  [0.0,0.0,0.0],
  [0.0,0.0,0.0]
]).

%-------------------------------------------------------------------------------------------------------------
%    PRINTING
%-------------------------------------------------------------------------------------------------------------

/*
* drawBoard(+Matrix, +Index)
* prints all numbers of Board 
*/
drawBoard([], _).
drawBoard([H | T], Index) :-
    write('  '), write(Index), write(' |'),
    drawLine(H), nl,
    write('    |___|___|___|___|___|___|___|___|___|'), nl,
    NewIndex is Index+1,
    drawBoard(T, NewIndex).

/*
* drawTopSeparator
* prints the top border of Board 
*/
drawTopSeparator:-
  write('      1   2   3   4   5   6   7   8   9  '), nl,
  write('     ___ ___ ___ ___ ___ ___ ___ ___ ___ '), nl.

  
/*
* drawCompleteBoard(+Board)
* prints the complete Board
*/
drawCompleteBoard(Board):-
  drawTopSeparator,
  drawBoard(Board, 1).


/*
* drawPoints(+Matrix, +Index)
* prints all numbers of Points Board 
*/
drawPoints([], _).
drawPoints([H | T], Index) :-
    write('  '), write(Index), write(' |'),
    drawLine(H), nl,
    write('     ----------------- '), nl,
    NewIndex is Index+1,
    drawPoints(T, NewIndex).

/*
* drawTopSeparator
* prints the top border of Points board 
*/
drawPointsSeparator:-
  write('       1     2     3  '), nl,
  write('     ----------------- '), nl.

/*
* drawPointsBoard(+Board)
* prints the complete Board of Points
*/
drawPointsBoard(Board1):-
  nl,nl,
  drawPointsSeparator,
  drawPoints(Board1, 1).


/*
* drawLine(+Line)
* prints a line of numbers
*/
drawLine([]).
drawLine([H | T]) :-
    H >= 0,
    H < 10,
    write(' '), 
    write(H), 
    write(' |'), 
    drawLine(T).
drawLine([H | T]) :-
    H < -9, 
    write(H), 
    write('|'), 
    drawLine(T).
drawLine([H | T]) :-
    write(' '), 
    write(H), 
    write('|'), 
    drawLine(T).  


/*
* clearSreen(+NumberOfNewLines)
* print newlines
*/
clearSreen(0).
clearSreen(N):-
    N1 is N - 1,
    nl,
    clearSreen(N1).
%-------------------------------------------------------------------------------------------------------------
% INPUTS
%-------------------------------------------------------------------------------------------------------------

/*
* readImput(-Imput)
* read the first caracter and devolves it as a number
*/
readImput(Imput):-
  get_code(Code),
  read_line(_),
  convertCode(Code, Imput).
readImput(Imput):-
  readImput(Imput),
  read_line(_)  .

/*
* pressLetter continues the program when a key is pressed
* insert a random key to continue
*/
pressLetter:-
    get_char(_).

/*
* convertCode(+Code, -Inte)
* transform the code into a integer
*/
convertCode(Code, Inte):- 
  Aux is Code - 48,
  Inte is Aux.

%-------------------------------------------------------------------------------------------------------------
%  FUNCTIONS 
%-------------------------------------------------------------------------------------------------------------

/*
* getMatrixAt(+Line, +Column, +Matrix, -Number)
* get the element at line and column of the board
*/
getMatrixAt(1, Column, [HeaderLines|_], Number):-
	getLineAt(Column, HeaderLines, Number).

getMatrixAt(Line, Column, [_|TailLines], Number):-
	Line > 0,
	NewLine is Line-1,
	getMatrixAt(NewLine, Column, TailLines, Number).

getLineAt(1, [HeaderNumbers|_], HeaderNumbers).

getLineAt(Index, [_|TailNumbers], Number):-
	Index > 0,
	NewIndex is Index-1,
	getLineAt(NewIndex, TailNumbers, Number).

/*
* getMatrixAt(+Line, +Column, +NewNumber, +Matrix, -NewBoard)
* set the element at line and column of the board to the newNumber returning the NewBoard
*/
setMatrixNumberAt(1, Column, NewNumber, [HeaderLines|TailLines], [NewHeaderLines|TailLines]):-
	setListNumberAt(Column, NewNumber, HeaderLines, NewHeaderLines).

setMatrixNumberAt(Line, Column, NewNumber, [HeaderLines|TailLines], [HeaderLines|NewTailLines]):-
	Line > 0,
	NewLine is Line-1,
	setMatrixNumberAt(NewLine, Column, NewNumber, TailLines, NewTailLines).

setListNumberAt(1, NewNumber, [_|TailNumbers], [NewNumber|TailNumbers]).

setListNumberAt(Index, NewNumber, [HeaderNumbers|TailNumbers], [HeaderNumbers|NewTailNumbers]):-
	Index > 0,
	NewIndex is Index-1,
	setListNumberAt(NewIndex, NewNumber, TailNumbers, NewTailNumbers).

/*
* max_list(+List, -Max)
* return the the max of a list
*/
max_list([H|T], Max) :-
    max_list(T, H, Max).

max_list([], Max, Max).
max_list([H|T], Max0, Max) :-
    Max1 is max(H, Max0),
    max_list(T, Max1, Max).

/*
* abs2(+X1, ?X2)
* absolute number of X1 in X2
*/
abs2(X1, X2):-
  X1 >= 0, 
  X2 is X1.
abs2(X1, X2):-
  X1 < 0,
  X2 is -X1.

/*
* roundUp(+Number, -Rounded)
* ceiling of division by 3 of Number
*/
roundUp(Number, Rounded):-
  NewNumber is Number / 3,
  Rounded is ceiling(NewNumber).

/*
* matrixSum(+Matrix, -Sum)
* Sum is the sum of all elements in Matrix
*/
matrixSum([], 0).
matrixSum([H|T], TotalSum) :-
  matrixSum(T, Rest),
  listSum(H, Sum1),
  TotalSum is Sum1 + Rest.

/*
* listSum(+List, -Sum)
* Sum is the sum of all elements in List
*/    
listSum([], 0).
listSum([H|T], TotalSum) :-
  listSum(T, Rest),
  TotalSum is H + Rest.

/*
* flatten2(+Matrix, -FlatenedList)
* transforms a Matrix in a List
*/
flatten2([], []) :- !.
flatten2([L|Ls], FlatL) :-
    !,
    flatten2(L, NewL),
    flatten2(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten2(L, [L]).

/*
* createPositions(+Lines, +Columns, -Final)
* creates all the positions of Points Board
*/
createPositions(Lines, Columns, Final):-
  createPositions(Lines, Columns, [], Final).
/*
* createPositions(+Lines, +Columns, +List, -Final)
*/
createPositions(0, _, Final, Final).

createPositions(Lines, 0, List, Final):-
  LinesNew is Lines - 1,
  createPositions(LinesNew, 3, List, Final).

createPositions(Lines, Columns, List, Final):-
  append([Lines], [Columns], Coordinates),
  append([Coordinates], List, ListAux),
  ColumnsNew is Columns - 1,
  createPositions(Lines, ColumnsNew, ListAux, Final).


%-------------------------------------------------------------------------------------------------------------
%  LOGIC
%-------------------------------------------------------------------------------------------------------------

/**
* checkMovePossible(+Line, +Column, +Number, +Board, -Boolean)
* See if the move of puting the Number in Line and Column of Boart is possible, Boolean is 1 if yes and 0 if no
*/
checkMovePossible(Line, Column, Number, Board, Boolean):-
  Line > 0,
  Line < 10,
  Column > 0,
  Column < 10,
  Number > 0,
  Number < 10,
  getMatrixAt(Line,Column, Board, Numb),
  Numb =:= 0,
  checkColumns(Column, Number, Board),
  checkLine(Line, Number, Board),
  checkLitleSquares(Line, Column, Number, Board),
  Boolean is 1.
checkMovePossible(_, _, _, _, Boolean):-
  Boolean is 0.

/**
* checkColumns(+Column, +Number, +Board)
* check if the there is no number equals of Number in the Column of Board
*/
checkColumns(_, _, []).
checkColumns(Column, Number, [H|T]):-
  checkColumns(Column, Number, T),
  checkColumn(Column, Number, H).

/**
* checkColumn(+Column, +Number, +List)
*/
checkColumn(1, Number, [H|_]):-
  abs2(H, Abs2),
  Number \= Abs2.
checkColumn(Column, Number, [_|T]):-
  NewColumn is Column - 1,
  checkColumn(NewColumn, Number, T).

/**
* checkLine(+Line, +Number, +Board)
* check if the there is no number equals of Number in the Line of Board
*/
checkLine(1, Number, [H|_]):-
  checkLine(Number, H).
checkLine(Line, Number, [_|T]):-
  NewLine is Line - 1,
  checkLine(NewLine, Number, T).

/**
* checkLine(+Number, +List)
*/
checkLine(_,[]).
checkLine(Number, [H|T]):-
  abs2(H, Abs2),
  Number \= Abs2,
  checkLine(Number,T).

/**
* checkLitleSquares(+Line, +Column, +Number, +Board)
* check if the there is no number equals of Number in the LitleSquare of Board
*/
checkLitleSquares(Line, Column, Number, Board):-
  roundUp(Line, Aux1),
  NewLine is Aux1 * 3,
  roundUp(Column, Aux2),
  NewColumn is Aux2 * 3,
  checkSquare(NewLine, NewColumn, Number, Board, 3).

/**
* checkSquares(+Line, +Column, +Number, +Board, +Counter)
*/
checkSquare(_, _, _, _, 0).
checkSquare(Line, Column, Number, Board, Aux):-
  C2 is Column - 1,
  C3 is Column - 2,
  getMatrixAt(Line, Column, Board, Num1),
  getMatrixAt(Line, C2, Board, Num2),
  getMatrixAt(Line, C3, Board, Num3),
  abs2(Num1, Abs1), abs2(Num2, Abs2), abs2(Num3, Abs3),
  Number \= Abs1, Number \= Abs2, Number \= Abs3,
  Aux1 is Aux - 1,
  NewLine is Line - 1,
  checkSquare(NewLine, Column, Number, Board, Aux1).

/*
* updateAllPoints(+Board, +Points, -FinalPoints)
* update all point and influence of Board in FinalPoints
*/
updateAllPoints(Board, Points, FinalPoints):-
  updatePoints(Board, Points, PointsIntermediate),
  updateInfluencePoints(Board, PointsIntermediate, FinalPoints).

/*
* updatePoints(+Board, +Points, -NewPoints)
* updates only the points of Board to NewPoints
*/
updatePoints(Board, Points, NewPoints):-
  updatePoints(Board, Points, 9, 9, NewPoints).
/*
* updatePoints(+Board, +Points, +AuxLine, +AuxColumn, -NewPoints)
*/
updatePoints(_, Points, 0, _ , Points).

updatePoints(Board, Points, AuxL, 0, NewPoints):-
  NewAuxL is AuxL - 1,
  updatePoints(Board, Points, NewAuxL, 9, NewPoints).

updatePoints(Board, Points, AuxL, AuxC, NewPoints):-
  getMatrixAt(AuxL, AuxC, Board, Number),
  roundUp(AuxL, Line),
  roundUp(AuxC, Column),
  getMatrixAt(Line, Column, Points, Pnt),
  Pnt2 is (Pnt + Number),
  setMatrixNumberAt(Line, Column, Pnt2, Points, NewPnt),  
  NewAuxC is AuxC - 1,
  updatePoints(Board, NewPnt, AuxL, NewAuxC, NewPoints).


/*
* updateInfluencePoints(+Board, +Points, -NewPoints)
* updates only the influence points of Board to NewPoints
*/
updateInfluencePoints(Board, Points, NewPoints):-
  updateInfluencePoints(Board, Points, 9, 9, NewPoints).

/*
* updateInfluencePoints(+Board, +Points, +AuxLine, +AuxColumn,-NewPoints)
* see if it influence horizontally, diagonally or vertically and updates the influence in the squares
*/
updateInfluencePoints(_, Points, 0, _ , Points).
updateInfluencePoints(Board, Points, AuxL, 0, NewPoints):-
  NewAuxL is AuxL - 1,
  updateInfluencePoints(Board, Points, NewAuxL, 9, NewPoints).

updateInfluencePoints(Board, Points, AuxL, AuxC, NewPoints):-
    ((AuxL =:= 3; AuxL =:= 4; AuxL =:= 6; AuxL =:= 7), (AuxC =:= 3; AuxC =:= 4; AuxC =:= 6; AuxC =:= 7)),
    roundUp(AuxL, Line),
    roundUp(AuxC, Column),
    getMatrixAt(AuxL, AuxC, Board, Number),
    cornerPoints(AuxL, AuxC, Number, Line, Column, Points, NewP),
    NewAuxC is AuxC - 1,
    updateInfluencePoints(Board, NewP, AuxL, NewAuxC, NewPoints).

updateInfluencePoints(Board, Points, AuxL, AuxC, NewPoints):-
    (AuxC =:= 3; AuxC =:= 4; AuxC =:= 6; AuxC =:= 7),
    roundUp(AuxL, Line),
    roundUp(AuxC, Column),
    getMatrixAt(AuxL, AuxC, Board, Number),
    columnPoints(AuxL, AuxC, Number, Line, Column, Points, NewP),
    NewAuxC is AuxC - 1,
    updateInfluencePoints(Board, NewP, AuxL, NewAuxC, NewPoints).

updateInfluencePoints(Board, Points, AuxL, AuxC, NewPoints):-
    (AuxL =:= 3; AuxL =:= 4; AuxL =:= 6; AuxL =:= 7),
    roundUp(AuxL, Line),
    roundUp(AuxC, Column),
    getMatrixAt(AuxL, AuxC, Board, Number),
    linePoints(AuxL, AuxC, Number, Line, Column, Points, NewP),    
    NewAuxC is AuxC - 1,
    updateInfluencePoints(Board, NewP, AuxL, NewAuxC, NewPoints).

updateInfluencePoints(Board, Points, AuxL, AuxC, NewPoints):-
    NewAuxC is AuxC - 1,
    updateInfluencePoints(Board, Points, AuxL, NewAuxC, NewPoints).

/*
* cornerPoints(+AuxLine, +AuxColumn, +Number, +Line, +Column, +Points, -NewPoints):-
* all the possible case of corners, and updates their influence in other squares
*/
cornerPoints(AuxL, AuxC, Number, Line, Column, Points, NewPoints):-
  0 is mod(AuxL,3),
  0 is mod(AuxC,3),
  L2 is Line + 1,
  C2 is Column + 1,
  getMatrixAt(Line, C2, Points, N1),
  getMatrixAt(L2, Column, Points, N2),
  getMatrixAt(L2, C2, Points, N3),
  Sum1 is N1 + (Number/2),
  Sum2 is N2 + (Number/2),
  Sum3 is N3 + (Number/2),
  setMatrixNumberAt(Line, C2, Sum1, Points, P1),
  setMatrixNumberAt(L2, Column, Sum2, P1, P2),
  setMatrixNumberAt(L2, C2, Sum3, P2, NewPoints).

cornerPoints(AuxL, AuxC, Number, Line, Column, Points, NewPoints):-
  0 is mod(AuxL,3),
  1 is mod(AuxC,3),
  L2 is Line + 1,
  C2 is Column - 1,
  getMatrixAt(Line, C2, Points, N1),
  getMatrixAt(L2, Column, Points, N2),
  getMatrixAt(L2, C2, Points, N3),
  Sum1 is N1 + (Number/2),
  Sum2 is N2 + (Number/2),
  Sum3 is N3 + (Number/2),
  setMatrixNumberAt(Line, C2, Sum1, Points, P1),
  setMatrixNumberAt(L2, Column, Sum2, P1, P2),
  setMatrixNumberAt(L2, C2, Sum3, P2, NewPoints).

cornerPoints(AuxL, AuxC, Number, Line, Column, Points, NewPoints):-
  1 is mod(AuxL,3),
  0 is mod(AuxC,3),
  L2 is Line - 1,
  C2 is Column + 1,
  getMatrixAt(Line, C2, Points, N1),
  getMatrixAt(L2, Column, Points, N2),
  getMatrixAt(L2, C2, Points, N3),
  Sum1 is N1 + (Number/2),
  Sum2 is N2 + (Number/2),
  Sum3 is N3 + (Number/2),
  setMatrixNumberAt(Line, C2, Sum1, Points, P1),
  setMatrixNumberAt(L2, Column, Sum2, P1, P2),
  setMatrixNumberAt(L2, C2, Sum3, P2, NewPoints).

cornerPoints(AuxL, AuxC, Number, Line, Column, Points, NewPoints):-
  1 is mod(AuxL,3),
  1 is mod(AuxC,3),
  L2 is Line - 1,
  C2 is Column - 1,
  getMatrixAt(Line, C2, Points, N1),
  getMatrixAt(L2, Column, Points, N2),
  getMatrixAt(L2, C2, Points, N3),
  Sum1 is N1 + (Number/2),
  Sum2 is N2 + (Number/2),
  Sum3 is N3 + (Number/2),
  setMatrixNumberAt(Line, C2, Sum1, Points, P1),
  setMatrixNumberAt(L2, Column, Sum2, P1, P2),
  setMatrixNumberAt(L2, C2, Sum3, P2, NewPoints).

/*
* columnPoints(+AuxLine, +AuxColumn, +Number, +Line, +Column, +Points, -NewPoints)
* updates all the influence done horizontally
*/
columnPoints(_, AuxC, Number, Line, Column, Points, NewPoints):-
  0 is mod(AuxC,3),
  C2 is Column + 1,
  getMatrixAt(Line, C2, Points, N1),
  Sum1 is N1 + (Number/2),
  setMatrixNumberAt(Line, C2, Sum1, Points, NewPoints).

columnPoints(_, AuxC, Number, Line, Column, Points, NewPoints):-
  1 is mod(AuxC,3),
  C2 is Column - 1,
  getMatrixAt(Line, C2, Points, N1),
  Sum1 is N1 + (Number/2),
  setMatrixNumberAt(Line, C2, Sum1, Points, NewPoints).

/*
* linePoints(+AuxLine, +AuxColumn, +Number, +Line, +Column, +Points, -NewPoints)
* * updates all the influence done verticalally
*/
linePoints(AuxL, _, Number, Line, Column, Points, NewPoints):-
  0 is mod(AuxL,3),
  L2 is Line + 1,
  getMatrixAt(L2, Column, Points, N1),
  Sum1 is N1 + (Number/2),
  setMatrixNumberAt(L2, Column, Sum1, Points, NewPoints).

linePoints(AuxL, _, Number, Line, Column, Points, NewPoints):-
  1 is mod(AuxL,3),
  L2 is Line - 1,
  getMatrixAt(L2, Column, Points, N1),
  Sum1 is N1 + (Number/2),
  setMatrixNumberAt(L2, Column, Sum1, Points, NewPoints).

/*
* nextPlayer(+Player, -NextPlayer)
* updates the current player
*/
nextPlayer(1, NextPlayer):-
  NextPlayer is 2.
nextPlayer(2, NextPlayer):-
  NextPlayer is 1.

/*
* putNumber(+Line, +Column, +Player, +Number, +Board, -NewBoard)
* put the right number in the board acording to the player
*/
putNumber(Line, Column, 1, Number, Board, NewBoard):-
  setMatrixNumberAt(Line,Column,Number, Board, NewBoard).
putNumber(Line, Column, 2, Number, Board, NewBoard):-
  NegNumber is 0 - Number,
  setMatrixNumberAt(Line,Column,NegNumber, Board, NewBoard).

/*
* playerTurn(+Player, +Board, -NewBoard)
* request input from the player till it is a possible move and do the move
*/
playerTurn(Player, Board, Points, NewBoard):-
  repeat,
  clearSreen(30),
  drawCompleteBoard(Board),
  drawPointsBoard(Points),
  nl,write('Player '), write(Player),  write(' Turn'),
  nl,write('Insert Line:'), 
  readImput(Line), nl,
  write('Insert Column:'),
  readImput(Column),nl,
  write('Insert Number:'),
  readImput(Number),nl,!,
  checkMovePossible(Line,Column, Number, Board, Boolean),
  Boolean =:= 1,
  putNumber(Line, Column, Player, Number, Board, NewBoard).

/*
* pcTurn(+Player, +Difficulty, +Board, +Points, +PreviousPoints, -NewBoard)
* see possible moves and choose a random in easy mode or the best move if in hard mode
*/
pcTurn(Player, Dificulty, Board, Points, PreviousPoints, NewBoard):-
  clearSreen(30),
  drawCompleteBoard(Board),
  drawPointsBoard(PreviousPoints),
  nl,write('PC '), write(Player),  write(' Turn'), nl,
  write('Press Key To Let Pc Play'),
  pressLetter,

  choose_move(Board, Points, Dificulty, Player, Move),
  split(Move, Line, Column, Number),
  putNumber(Line, Column, Player, Number, Board, NewBoard).

/*
* validMoveNumber(+Line, +Column, +Number, +Board, +MovesIntermediate, -MovesFinal)
* see all possible moves only to Number and puts all in Moves Final
*/
validMoveNumber(0, _, _, _, MovesIntermediate, MovesIntermediate).

validMoveNumber(Line, 0, Number, Board, MovesIntermediate, MovesFinal):-
  Line1 is Line - 1,
  validMoveNumber(Line1, 9, Number, Board, MovesIntermediate, MovesFinal).

validMoveNumber(Line, Column, Number, Board, MovesIntermediate, MovesFinal):-
  checkMovePossible(Line, Column, Number, Board, Boolean),    
  Boolean =:= 1,
  append([Line], [Column], Coordinates),
  append(Coordinates, [Number], Moves),
  append(MovesIntermediate, [Moves], UpdatedList),
  Column1 is Column - 1,
  validMoveNumber(Line, Column1, Number, Board, UpdatedList, MovesFinal).
    
validMoveNumber(Line, Column, Number, Board, MovesIntermediate, MovesFinal):-
  Column1 is Column - 1,
  validMoveNumber(Line, Column1, Number, Board, MovesIntermediate, MovesFinal).


/*
* valid_moves(+Board, +Number, +IntermidiateMoves, -ListOfMoves)
* see all possible moves
*/
valid_moves(_, 0, CompleteMoves ,CompleteMoves).

valid_moves(Board, Number, IntermidiateMoves, ListOfMoves):-
  validMoveNumber(9, 9, Number, Board, [], MovesFinal),
  NewNumber is Number - 1,
  append(MovesFinal, IntermidiateMoves, UpdatedList),
  valid_moves(Board, NewNumber, UpdatedList, ListOfMoves).

/*
* value(+Points, +Player, -Value)
* the value is the amount of points a player has 
*/
value(Points, 1, Value):-
  matrixSum(Points, Sum),
  Value is Sum.

value(Points, 2, Value):-
  matrixSum(Points, Sum),
  Value is 0 - Sum.


/*
* split(+Move, -Line, -Column, -Number)
* split a list of a move in Line, Column and Number
*/    
split([H1|[H2|[H3|_]]], Line, Column, Number):-
  Line is H1,
  Column is H2, 
  Number is H3.


/*
* choose_move(+Board, +Points, +Dificulty, +Player, -Move)
* choose a Move acording to the board and the dificulty 
*/  
choose_move(Board, _, 1, _, Move):-
  valid_moves(Board , 9 , [], ListOfMoves),
  length(ListOfMoves, Length),
  random(0, Length, Random),
  nth0(Random, ListOfMoves, Move).

choose_move(Board, Points, 2, Player, Move):-
  valid_moves(Board , 9 , [], ListOfMoves),
  chooseBestMoves(Board, Points, Player, ListOfMoves, [], -9999, BestMoves),
  write(BestMoves),nl,
  length(BestMoves, Length),
  random(0, Length, Random),
  nth0(Random, BestMoves, Move).

/*
* chooseBestMoves(+Board, +Points, +Player, +AllMoves, +IntermidiateMoves, +IntermidiateValue, -BestMoves)
* choose the best move acording to the Board
*/
chooseBestMoves(_, _, _, [], BestMoves, _, BestMoves).

chooseBestMoves(Board, Points, Player, [Move|T], IntermidiateMoves, IntermidiateValue, BestMoves):-
  split(Move, Line, Column, Number),
  putNumber(Line, Column, Player, Number, Board, NewBoard),
  updateAllPoints(NewBoard, Points, Points2),
  value(Points2, Player, Value),!,
  (
    (Value > IntermidiateValue, 
    append([Move], [], NewBestMoves), 
    chooseBestMoves(Board, Points, Player, T, NewBestMoves, Value, BestMoves));
    
    (Value =:= IntermidiateValue,   
    append(IntermidiateMoves, [Move], NewBestMoves),   
    chooseBestMoves(Board, Points, Player, T, NewBestMoves, Value, BestMoves));
    
    chooseBestMoves(Board, Points, Player, T, IntermidiateMoves, IntermidiateValue, BestMoves)
  ).

/*
* playingOver(+Board)
* when there is no possible moves
*/
playingOver(Board):-
  valid_moves(Board , 9 , [], Final),!,
  length(Final, 0).


/*
* regionsOnwed(+Points, +Score1, +Score2, -FinalScore1, -FinalScore2)
* FinalScore1 is the regions the player1 owns and FinalScore2 is the regions the player2 owns
*/
regionsOnwed([], F1, F2, F1, F2):- !.
regionsOnwed([H|T], Player1, Player2, F1, F2):-
  H > 0,
  P1 is Player1 + 1,
  regionsOnwed(T, P1, Player2, F1, F2).
regionsOnwed([H|T], Player1, Player2, F1, F2):-
  H < 0,
  P2 is Player2 + 1,
  regionsOnwed(T, Player1, P2,  F1, F2).
regionsOnwed([_|T], Player1, Player2, F1, F2):-
  regionsOnwed(T, Player1, Player2, F1, F2).

/*
* game_over(+Points, -Winner)
* Winner is the player that has more regions controled
*/
game_over(Points, Winner):-
  flatten2(Points, FinalList),

  regionsOnwed(FinalList, 0, 0, F1, F2),

  write('Score'), nl,
  write('Player1: '), write(F1), nl,
  write('Player2: '), write(F2), nl,
  (F1 > F2, Winner is 1);
  (F2 > F1, Winner is 2);
  Winner is 0.


/*
* humanVsPc(+Player, +Dificulty, +Board, +Points, +PreviousPoints)
* game loop of a Human vs a Pc
*/
humanVsPc(_, _, Board, _, PreviousPoints):-
  playingOver(Board),
  write('Playing Game Over. Cascade Now To Decide Winner'), nl,
  %cascade(Board, Points, PreviousPoint),
  game_over(PreviousPoints, Winner),
  write('The winner is player '),
  write(Winner).  

humanVsPc(Player, Dificulty, Board, Points, PreviousPoints):-
  Player =:= 1,
  playerTurn(Player, Board, PreviousPoints, BoardIntermidiate),
  nextPlayer(Player, NewPlayer),
  updateAllPoints(BoardIntermidiate, Points, PointsIntermediate),
  humanVsPc(NewPlayer, Dificulty, BoardIntermidiate, Points, PointsIntermediate).

humanVsPc(Player, Dificulty, Board, Points, PreviousPoints):-
  Player =:= 2,
  pcTurn(Player, Dificulty, Board, Points, PreviousPoints, BoardIntermidiate),
  nextPlayer(Player, NewPlayer),
  updateAllPoints(BoardIntermidiate, Points, PointsIntermediate),    
  humanVsPc(NewPlayer, Dificulty, BoardIntermidiate, Points, PointsIntermediate).

/*
* pcVsPc(+Player, +Dificulty1, +Dificulty2, +Board, +Points, +PreviousPoints)
* game loop of a Pc vs another Pc
*/
pcVsPc(_, _, _, Board, _, PreviousPoints):-
  playingOver(Board),
  write('Playing Game Over. Cascade Now To Decide Winner'), nl,
  %cascade(Board, Points, PreviousPoint),
  game_over(PreviousPoints, Winner),
  write('The winner is player '),
  write(Winner).

pcVsPc(Player, Dificulty1, Dificulty2, Board, Points, PreviousPoints):-
  Player =:= 1,
  pcTurn(Player, Dificulty1, Board, Points, PreviousPoints, BoardIntermidiate),
  nextPlayer(Player, NewPlayer),
  updateAllPoints(BoardIntermidiate, Points, PointsIntermediate), 
  pcVsPc(NewPlayer, Dificulty1, Dificulty2, BoardIntermidiate, Points, PointsIntermediate).

pcVsPc(Player, Dificulty1, Dificulty2, Board, Points, PreviousPoints):-
  Player =:= 2,
  pcTurn(Player, Dificulty2, Board, Points, PreviousPoints, BoardIntermidiate),
  nextPlayer(Player, NewPlayer),
  updateAllPoints(BoardIntermidiate, Points, PointsIntermediate),    
  pcVsPc(NewPlayer, Dificulty1, Dificulty2, BoardIntermidiate, Points, PointsIntermediate).

/*
* humanVsHuman(+Player, +Board, +Points, +PreviousPoints)
* game loop of a human vs another human
*/
humanVsHuman(_, Board, _, PreviousPoints):-
  playingOver(Board),
  write('Playing Game Over. Cascade Now'), nl,
  %cascade(Board, Points, PreviousPoint),
  game_over(PreviousPoints, Winner),
  write('The winner is player '),
  write(Winner).

humanVsHuman(Player, Board, Points, PreviousPoints):-
  playerTurn(Player, Board, PreviousPoints, BoardIntermidiate),
  nextPlayer(Player, NewPlayer),
  updateAllPoints(BoardIntermidiate, Points, PointsIntermediate),
  humanVsHuman(NewPlayer, BoardIntermidiate, Points, PointsIntermediate).


%-------------------------------------------------------------------------------------------------------------
% Unfinished part - only the cascade part was not implemented
%-------------------------------------------------------------------------------------------------------------
/*
cascade(Board, Points, FinalPoints):-
  decideWinner(Board, Points, Points, FinalPoints),
  write(Board), nl,
  write(Points), nl,
  write(FinalPoints), nl.


decideWinner(Board, Points, PointsVisited, FinalPoints):-
  listMatrix(FinalPoints, ListPoints),
  listMatrix(PointsVisited, ListPoints),
  createPositions(3, 3, Final).

  %update Board 
  %update Influence Points

  %decideWinner().
*/



%-------------------------------------------------------------------------------------------------------------
% MENUS
%-------------------------------------------------------------------------------------------------------------

  drawMenu1:-
    repeat,
    write('  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. '), nl,
    write(' | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |'), nl,
    write(' | | ____    ____ | || |   ______     | || |  _______     | || |      __      | || | ____  _____  | || |  _________   | |'), nl,
    write(' | ||_   \\  /   _|| || |  |_   _ \\    | || | |_   __ \\    | || |     /  \\     | || ||_   \\|_   _| | || | |_   ___  |  | |'), nl,
    write(' | |  |   \\/   |  | || |    | |_) |   | || |   | |__) |   | || |    / /\\ \\    | || |  |   \\ | |   | || |   | |_  \\_|  | |'), nl,
    write(' | |  | |\\  /| |  | || |    |  __\\\'.  | || |   |  __ /    | || |   / ____ \\   | || |  | |\\ \\| |   | || |   |  _|  _   | |'), nl,
    write(' | | _| |_\\/_| |_ | || |   _| |__) |  | || |  _| |  \\ \\_  | || | _/ /    \\ \\_ | || | _| |_\\   |_  | || |  _| |___/ |  | |'), nl,
    write(' | ||_____||_____|| || |  |_______/   | || | |____| |___| | || ||____|  |____|| || ||_____|\\____| | || | |_________|  | |'), nl,
    write(' | |              | || |              | || |              | || |              | || |              | || |              | |'), nl,
    write(' | \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' || \'--------------\' |'), nl,
    write('  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\'  \'----------------\' '), nl,
    write('                                                                                                                                                 '), nl,
    write('........................................................................................................................'), nl,
    write('                                          __    __      ________      ___     _     __     __                                               '), nl,
    write('                                         |  \\  /  |    |  ______|    |   \\   | |   |  |   |  |                                              '), nl,
    write('                                         |   \\/   |    | |______     | |\\ \\  | |   |  |   |  |                                              '), nl,
    write('                                         |   __   |    | |______|    | | \\ \\ | |   |  |   |  |                                              '), nl,
    write('                                         |  |  |  |    | |______     | |  \\ \\| |   |  |___|  |                                              '), nl,
    write('                                         |__|  |__|    |________|    |_|   \\___|   |_________|                                              '), nl,nl,
    write('    /|    __      __        '),nl,
    write('     |   |__||   |__| \\ /   '),nl,
    write('     |:: |   |__ |  |  /  ' ),nl,nl,                       
    write('  ___     _____       __ _____  __        ___ _____ ___   ___        __  '),nl,
    write('  ___|      |   |\\ | |__   |   |__| |  | |      |    |   |   | |\\ | |__  '),nl,
    write(' |___ ::  __|__ | \\|  __|  |   |  \\ |__| |___   |   _|_  |___| | \\|  __|  '),nl,nl,
    write('  ___     ___        _____  _____      '),nl,
    write('  ___|   |   | |   |   |      |   '),nl,
    write('  ___|:: |___\\ |___| __|__    |  '),nl,nl,nl,
    write('...........................................................................................................................................................'), nl,

    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(OpctionM),
    OpctionM > 0, 
    OpctionM =< 3,
    menu1(OpctionM).

    /**
* drawSubMenu with the diferent modes to play
*/
drawMenu2:-
    repeat,
    write('.......................'), nl,
    write('     Type Of Game      '), nl,
    write('.......................'), nl,nl,
    write('1 PLAYER VS PLAYER'), nl, 
    write('2 PLAYER VS COMPUTER '), nl,
    write('3 COMPUTER VS COMPUTER '), nl,nl,
    write('4 BACK '), nl,
    write('5 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(OpctionSm), nl, 
    OpctionSm > 0, 
    OpctionSm =< 5,
    menu2(OpctionSm).

/**
* drawPvsPCMenu with the options of a Human player vs Pc game 
*/
drawHumanVsPCMenu:-
    repeat,
    write('.......................'), nl,
    write('     Dificulty      '), nl,
    write('.......................'), nl,nl,
    write('1 Easy'), nl, 
    write('2 Hard '), nl,nl,
    write('3 Back '), nl,
    write('4 Quit '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(OpctionS1m), nl, 
    OpctionS1m > 0, 
    OpctionS1m =< 4,
    menuHumanVsPc(OpctionS1m).


drawHumanVsPcOrderMenu(Dificulty):-
  repeat,
    write('.......................'), nl,
    write('     First Play      '), nl,
    write('.......................'), nl,nl,
    write('1 Human'), nl, 
    write('2 Pc '), nl,
    write('3 Back '), nl,
    write('4 Quit '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(OpctionS2m), nl, 
    OpctionS2m > 0, 
    OpctionS2m =< 4,
    menuHumanVsPcOrder(OpctionS2m, Dificulty).

/**
* drawPcvsPCMenu with the options of a Pc vs Pc game 
*/
drawPcvsPCMenu:-
    repeat,
    write('.......................'), nl,
    write('     Dificulty      '), nl,
    write('.......................'), nl,nl,
    write('1 Easy vs Easy'), nl, 
    write('2 Easy vs Hard '), nl,
    write('3 Hard vs Hard '), nl, nl,
    write('4 Back '), nl,
    write('5 Quit '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(OpctionS3m), nl,
    OpctionS3m > 0, 
    OpctionS3m =< 5,
    menuPcVsPc(OpctionS3m).



menu1(1):-
 drawMenu2.

menu1(2):-
  clearSreen(30),
  write('-----------------------------------------------------------------------INSTRUCTIONS-----------------------------------------------------------------------'), nl,
  write('1.The board consists in 9 rows of 9 columns empty in the beginning.'), nl, nl,
  write('2.Each Player can play in any empty house if it obeys the normal Sudoku rules'), nl, nl,
  write('3.There can only be the same number in a row, in a line and in one of the 9 smaller squares'), nl, nl,
  write('4.Each player put one number in his turn, then the next player plays after'),nl,nl,
  write('5.To distinguish each players pieces, the ones positive are player\'s 1 and those negative are player\'s 2 '),nl,nl,
  write('6.When put a number in a position that player get that amount of points in the respective small square'),nl,nl,
  write('7.If that position is a neighbor of another square, he get in that square half the amount of that number as influence'),nl,nl,
  write('8.The neighbors squares can be vertically, horizontally or diagonally.'),nl,nl,
  write('9.If one player has more points in the square than his oponent he controls that position.'),nl,nl,
  write('10.The objective of the game is to control the most squares in the end.'),nl,nl,
  write('-----------------------------------------------------------------------------------------------------------------------------------------------------------'), nl, nl,nl,
  write('Press any key to return to menu'),
  pressLetter,nl,
  clearSreen(30),
  drawMenu1.

menu1(3):- !.


menu2(1):-
  initialBoard(Board),
  initialPoints(Points),
  humanVsHuman(1, Board, Points, Points).

menu2(2):-
  drawHumanVsPCMenu.

menu2(3):-
  drawPcvsPCMenu.

menu2(4):- drawMenu1.

menu2(5):- !.


menuHumanVsPc(1):-
  drawHumanVsPcOrderMenu(1).
  

menuHumanVsPc(2):-
  drawHumanVsPcOrderMenu(2).


menuHumanVsPc(3):-
  drawMenu2.

menuHumanVsPc(4):- !.


menuHumanVsPcOrder(1, 1):-
  initialBoard(Board),
  initialPoints(Points),
  humanVsPc(1, 1, Board, Points, Points).

menuHumanVsPcOrder(1, 2):-
  initialBoard(Board),
  initialPoints(Points),
  humanVsPc(1, 2, Board, Points, Points).

menuHumanVsPcOrder(2, 1):-
  initialBoard(Board),
  initialPoints(Points),
  humanVsPc(2, 1, Board, Points, Points).

menuHumanVsPcOrder(2, 2):-
  initialBoard(Board),
  initialPoints(Points),
  humanVsPc(2, 2, Board, Points, Points).

menuHumanVsPcOrder(3, _):- 
  drawHumanVsPCMenu.

menuHumanVsPcOrder(4, _):- !.


menuPcVsPc(1):-
  initialBoard(Board),
  initialPoints(Points),
  pcVsPc(1, 1, 1, Board, Points, Points).

menuPcVsPc(2):-
  initialBoard(Board),
  initialPoints(Points),
  pcVsPc(1, 1, 2, Board, Points, Points).

menuPcVsPc(3):-
  initialBoard(Board),
  initialPoints(Points),
  pcVsPc(1, 2, 2, Board, Points, Points).

menuPcVsPc(4):-
  drawMenu2.

menuPcVsPc(5):- !.


play:-
  clearSreen(50),
  drawMenu1.