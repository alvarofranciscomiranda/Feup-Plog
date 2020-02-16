:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(random)).

%--------------------------------------------------------------------------------------
%----------------------------------BOARDS---------------------------------------------
%--------------------------------------------------------------------------------------

/*
* puzzle(+Id, -MatrixOfBoard)
* to acess all boards
*/
puzzle(1,[
            [0,0,0,2],
		    [0,9,0,0],
		    [7,0,0,0],
		    [0,0,3,0]
	]).

puzzle(2,[
            [3,0,0,0,0],
		    [0,0,0,0,3],
		    [0,0,5,0,0],
		    [0,0,0,1,0],
            [0,6,0,0,0]
	]).

puzzle(3,[
            [0,3,0,0,0,0],
		    [1,0,0,0,0,0],
		    [0,0,0,0,0,3],
		    [0,0,0,2,0,0],
            [0,0,0,0,8,0],
            [0,0,8,0,0,0]
	]).

puzzle(4,[
            [0,0,0,0,0,2,0],
		    [0,0,0,9,0,0,0],
		    [5,0,0,0,0,0,0],
		    [0,0,4,0,0,0,0],
            [0,0,0,0,0,0,8],
            [0,4,0,0,0,0,0],
            [0,0,0,0,4,0,0]
	]).

puzzle(5,[
            [0,7,0,0,0,0,0,0],
		    [0,0,0,0,0,4,0,0],
		    [0,0,0,0,0,0,5,0],
		    [0,0,0,0,8,0,0,0],
            [0,0,0,0,0,0,0,3],
            [0,0,0,2,0,0,0,0],
            [0,0,3,0,0,0,0,0],
            [2,0,0,0,0,0,0,0]
	]).

puzzle(6,[
            [0,0,0,0,0,0,0,0,5],
		    [0,0,0,0,6,0,0,0,0],
		    [0,9,0,0,0,0,0,0,0],
		    [0,0,0,0,0,3,0,0,0],
            [0,0,0,0,0,0,8,0,0],
            [5,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,8,0],
            [0,0,4,0,0,0,0,0,0],
            [0,0,0,1,0,0,0,0,0]
	]).

puzzle(7,[
            [0,0,0,0,0,0,0,0,0,1],
		    [0,0,0,0,0,0,4,0,0,0],
		    [0,1,0,0,0,0,0,0,0,0],
		    [0,0,0,0,0,0,0,2,0,0],
            [0,0,0,5,0,0,0,0,0,0],
            [0,0,0,0,1,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,1,0],
            [0,0,6,0,0,0,0,0,0,0],
            [0,0,0,0,0,4,0,0,0,0],
            [6,0,0,0,0,0,0,0,0,0]
	]).

%--------------------------------------------------------------------------------------
%----------------------------------DISPLAY---------------------------------------------
%--------------------------------------------------------------------------------------

/*
* displayB(+Board)
* display complete Board independtly of the step
*/
displayB(Board):-
    length(Board, Size),    
    displayBoard(Board, Size, 1).

/*
* displayBoard(+Board, +Size, +Step)
* display complete Board depending on step
*/
displayBoard([], _, _).
displayBoard(Board, Size, 1):-
    displaySeparator(Size), nl,
    displayBoard(Board, Size, 2).
displayBoard([H|T], Size, 2):-
    write('| '),
    displayLine(H), nl,
    displaySeparator(Size), nl,
    displayBoard(T,Size, 2).

/*
* displayLine(+List)
* display complete List
*/
displayLine([]).
displayLine([H | T]) :-
    write(H), write(' | '),
    displayLine(T).

/*
* displaySeparator(+Size)
* display line separator depending on Size
*/
displaySeparator(0).
displaySeparator(Size):-
    NewSize is Size - 1,
    write(' ---'),
    displaySeparator(NewSize).

%--------------------------------------------------------------------------------------
%----------------------------------AUXILIAR--------------------------------------------
%--------------------------------------------------------------------------------------

/*
* flatten(+Matrix, -FlatenedList)
* transforms a Matrix in a List
*/
flatten([], []).
flatten([H|T], List):-
    flatten(T, List1),
    append(H, List1, List), !.

/*
* list2Matrix(+List, +Columns, -Matrix)
* transforms a Matrix in a List
*/
list2Matrix([], _, []).
list2Matrix(List, Size, [Row|Matrix]):-
  list_to_matrix_row(List, Size, Row, Tail),
  list2Matrix(Tail, Size, Matrix).

list_to_matrix_row(Tail, 0, [], Tail).
list_to_matrix_row([Item|List], Size, [Item|Row], Tail):-
  NSize is Size-1,
  list_to_matrix_row(List, NSize, Row, Tail).


/*
* setMatrixAt(+Line, +Column, +NewNumber, +Matrix, -NewBoard)
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

%--------------------------------------------------------------------------------------
%----------------------------------EMPTY BOARD CREATOR---------------------------------------------
%--------------------------------------------------------------------------------------

/*
* emptyBoard(+Size, -Board)
* creates a square matrix of undefined variables
*/
emptyBoard(Size, Board):-
    emptyBoard(Size, Size, Board).

/*
* emptyBoard(+Lines, +Columns, -Board)
* creates a Lines X Columns matrix of undefined variables
*/
emptyBoard(0, _, []).								
emptyBoard(Lines, Columns, [H|T]):- 
    length(H, Columns),
	NewLines is Lines - 1,
	emptyBoard(NewLines, Columns, T).

/*
* createBoard(+Board, -NewB)
* create empty board and then puts numbers in respective position seen in a Board received as argument
* leaving the rest as undefined variables
*/
createBoard(Board, NewB):-
    length(Board, Size),
    emptyBoard(Size, NewB),
    fillBoard(Board, NewB).

/*
* fillBoard(+Board, -NewBoard)
* if the position in the Board is a number puts it in NewBoard at the same position
*/
fillBoard([],[]).
fillBoard([H|T], [H1|T2]):-
    fillBoard(T, T2),
    element(I, H, V),
    V #> 0,
    element(I, H1, V).

%--------------------------------------------------------------------------------------
%----------------------------------RESTRICTIONS---------------------------------------------
%--------------------------------------------------------------------------------------
 
/*
* restrictLine(+List)
* constraints of middle Sum applied to a list
*/
restrictLine(List):-
    length(List, L),
	domain(List, 0, 9),
	L1 #= L-3,
	count(0,List,#=,L1),
	A #\= 0,
	B #\= 0,
	C #\= 0,
	element(I, List, A),
	I1 #>I,
	I2 #<I,
	element(I1, List, B),
	element(I2, List, C),
	A #= B+C.

/*
* restrictMatrix(+Matrix)
* constraints of middle Sum applied to a matrix
*/
restrictMatrix([]).
restrictMatrix([H|T]):-
    restrictLine(H),
    restrictMatrix(T).

%--------------------------------------------------------------------------------------
%----------------------------------SOLVER---------------------------------------------
%--------------------------------------------------------------------------------------
 
/*
* midleSum(+Board, -MatrixFinal)
* applies the constraints and find the solution of Board putting it in MatrixFinal
*/
midleSum(Board, MatrixFinal):-
    length(Board, Size),
    createBoard(Board, NewBoard),
    !,
    restrictMatrix(NewBoard),
    transpose(NewBoard, TransposedBoard),
    !,
    restrictMatrix(TransposedBoard),
    transpose(TransposedBoard, NBoard),
    
    flatten(NBoard, FinalBoard),
    !,
    labeling([], FinalBoard),
    displayTime,
    list2Matrix(FinalBoard, Size, MatrixFinal).

/*
* midleSum2(+Board)
* used for the random generator, also displays the boards first and solution
*/
midleSum2(Board):-
    reset_timer,
    fillZeros(Board, First),
    length(Board, Size),    
    !,    
    restrictMatrix(Board),
    transpose(Board, TransposedBoard),
    !,
    restrictMatrix(TransposedBoard),
    transpose(TransposedBoard, NBoard),
   
    flatten(NBoard, FinalBoard),
    !,
    labeling([bisect], FinalBoard),
    list2Matrix(FinalBoard, Size, MatrixFinal),

    displayB(First),
    displayB(MatrixFinal).


/*
* solvePuzzle(+Number)
* display and solve one of the existing boards
*/
solvePuzzle(Number):-
    reset_timer,
    puzzle(Number, Board),
    displayB(Board),nl,
    midleSum(Board, Final),nl,
    displayB(Final).

/*
* generateTry(+Size)
* tries to create and solve a board of Size 
*/
generateTry(Size):-
    reset_timer, 
    generateBoard(Size, G),
    write('Seeking board'),nl,
    (
        (midleSum2(G), nl, displayTime,nl);
        generateTry(Size)
    ).


%--------------------------------------------------------------------------------------
%----------------------------------GENERATOR---------------------------------------------
%--------------------------------------------------------------------------------------

/*
* generateBoard(+Size, -Board)
* generate a board ready to be resolved(with only ine number in each row or column)
*/
generateBoard(Size, Board):-
    emptyBoard(Size, Bd),
    generateIndex(Size, Lines),
    generateIndex(Size, Columns),

    generateNumbers(Bd, Lines, Columns, Board).

/*
* generateNumbers(+Board, +Lines, +Columns, -Final)
* return a Final board with only one number in each column or row
*/
generateNumbers(Final, [], [], Final).
generateNumbers(Board, Lines, Columns, Final):-
    length(Lines, Size),
    random(0, Size, LineIndex),
    random(0, Size, ColumnIndex),
    random(1, 10, Number),

    getCoords(Lines, LineIndex, Line, RestLines),
    getCoords(Columns, ColumnIndex, Column, RestColumns),

    setMatrixNumberAt(Line, Column, Number, Board, NewBoard),

    generateNumbers(NewBoard, RestLines, RestColumns, Final).

/*
* generateIndex(+X, -Index)
* create a list from index to later add a number in hat coordinate
*/
generateIndex(0, []).
generateIndex(X, Index):-
    NewX is X - 1,
    generateIndex(NewX, Append),
    append(Append, [X], Index).

/*
* getCoords(+List, +Index, -Numb, -Final)
* gets one coorinate for row or line and deletes it from list
*/
getCoords(List, Index, Numb, Final):-
    nth0(Index, List, Numb),
    delete(List, Numb, Final).

/*
* fillZeros(+Matrix, -ZeroedMatrix)
* puts zeros on undefined variables ina a matrix
*/
fillZeros([], []).
fillZeros([H|T], [H1|T1]):-
    fillZeros(T, T1),
    zeros(H, H1).

/*
* zeros(+List, -ZeroedList)
* puts zeros on undefined variables ina a list
*/
zeros([], []).
zeros([H|T], [0|T1]):-
    \+number(H),
    zeros(T, T1).
zeros([H|T], [H|T1]):-
    zeros(T, T1).

%--------------------------------------------------------------------------------------
%----------------------------------TIME---------------------------------------------
%--------------------------------------------------------------------------------------


reset_timer :- statistics(walltime,_).													

/*
* displayTime
* display miliseconds
*/
displayTime:-
  statistics(walltime, [_,T]),
  TS is ((T//10)*10)/1000,
  write('Solving time: '),
  write(TS), 
  write('seconds'),nl.


%--------------------------------------------------------------------------------------
%----------------------------------MENUS---------------------------------------------
%--------------------------------------------------------------------------------------


drawMenu1:-
    repeat,
    write('.......................'), nl,
    write('     MIDLE SUM      '), nl,
    write('.......................'), nl,nl,
    write('1 CHOOSE A PUZZLE'), nl, 
    write('2 RANDOM PUZZLE '), nl,
    write('3 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(Opction1), nl, 
    Opction1 > 0, 
    Opction1 =< 3,
    menu(Opction1).



menu(1):-
    clearSreen(40),
    drawMenu2.

menu(2):- 
    clearSreen(40),
    drawMenu3.

menu(3):- !.



drawMenu2:-
    repeat,
    write('.......................'), nl,
    write('     DIFFICULTY      '), nl,
    write('.......................'), nl,nl,
    write('1 4x4'), nl, 
    write('2 5x5'), nl,
    write('3 6x6 '), nl,
    write('4 7x7 '), nl,
    write('5 8x8 '), nl,
    write('6 9x9 '), nl,
    write('7 10x10 '), nl,
    write('8 BACK '), nl,
    write('9 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(Opction2), nl, 
    Opction2 > 0, 
    Opction2 =< 9,
    menu2(Opction2).



menu2(1):-
    reset_timer,
    solvePuzzle(1),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(2):-
    solvePuzzle(2),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(3):-
    solvePuzzle(3),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(4):- 
    solvePuzzle(4),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(5):-
    solvePuzzle(5),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(6):- 
    solvePuzzle(6),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(7):- 
    solvePuzzle(7),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu2(8):- 
    drawMenu1.

menu2(9):- !.


drawMenu3:-
    repeat,
    write('.......................'), nl,
    write('     DIFFICULTY      '), nl,
    write('.......................'), nl,nl,
    write('1 4x4'), nl, 
    write('2 5x5'), nl,
    write('3 6x6 '), nl,
    write('4 7x7 '), nl,
    write('5 8x8 '), nl,
    write('6 9x9 '), nl,
    write('7 10x10 '), nl,
    write('8 BACK '), nl,
    write('9 QUIT '), nl,
    write('.......................'), nl,nl, 
    write('CHOOSE YOUR OPCTION: '), nl,
    readImput(Opction3), nl, 
    Opction3 > 0, 
    Opction3 =< 9,
    menu3(Opction3).


menu3(1):-
    generateTry(4),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(2):-
    generateTry(5),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(3):-
    generateTry(6),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(4):- 
    generateTry(7),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(5):-
    generateTry(8),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(6):- 
    generateTry(9),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(7):- 
    generateTry(10),
    write('Press enter to continue'),nl,
    pressLetter,
    clearSreen(40),
    drawMenu1.

menu3(8):- 
    drawMenu1.

menu3(9):- !.


play:-
    drawMenu1.


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