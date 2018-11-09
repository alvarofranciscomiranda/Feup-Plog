%:- use_module(library(lists)).

%----------------------------------
%Inicial board
%----------------------------------
initialBoard([
  [4,7,5,3,1,2,2],
  [8,2,2,2,2,2,2],
  [4,2,2,7,2,2,2],
  [2,2,2,2,2,2,2]
]).
%----------------------------------
%Inicial board end
%----------------------------------

%----------------------------------
%Unicode translation
%----------------------------------
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
%----------------------------------
%Unicode translation end
%----------------------------------

%----------------------------------
%Board display
%----------------------------------
drawAll([H | T], Index):-
    drawBoard([H | T], Index).

drawTopBorder:-
    write('                                 '), nl,
    write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6  '), nl,
    write(' ---+--------------------------- '), nl.

drawBoard([], _).
drawBoard([H | T], Index) :-
    write('  '), write(Index), write(' |'),
    drawLine(H), 
    nl,
    write(' -------------------------------'), 
    nl,
    NewIndex is Index+1,
    drawBoard(T, NewIndex).

drawLine([]).
drawLine([H | T]) :-
    write(' '), 
    print_cell(H), 
    write(' |'), 
    drawLine(T).
%----------------------------------
%Board display end
%----------------------------------


%----------------------------------
%Matrix functions
%----------------------------------

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

%----------------------------------
%Matrix functions
%----------------------------------

%----------------------------------
%Game logic
%----------------------------------
incrementOne(Line, Column, Board, NewBoard):-
    getMatrixSeedAt(Line, Column, Board, Seed),
    NewSeed is Seed + 1,
    setMatrixSeedAtWith(Line, Column, NewSeed, Board, NewBoard).


takeAllSeedsAt(Line, Column, Board, NewBoard, Seeds):-
    getMatrixSeedAt(Line, Column, Board, Seeds),
    setMatrixSeedAtWith(Line, Column, 0, Board, NewBoard).


checkMostSeedsLine(0, [HeaderLines|_], MostSeeds):-
	max_list(HeaderLines, MostSeeds).

checkMostSeedsLine(Line, [_|TailLines], MostSeeds):-
	Line > 0,
	NewLine is Line-1,
	checkMostSeedsLine(NewLine, TailLines, MostSeeds).
    
checkMostSeedsPlayer1(Board, MostSeeds):-
    checkMostSeedsLine(0, Board, MostSeeds1),
    checkMostSeedsLine(1, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2).

checkMostSeedsPlayer2(Board, MostSeeds):-
    checkMostSeedsLine(2, Board, MostSeeds1),
    checkMostSeedsLine(3, Board, MostSeeds2),
    MostSeeds is max(MostSeeds1, MostSeeds2).


updateCoordsTop(Line, Column, NewLine, NewColumn):-
    (Line =:= 0; Line =:= 2),
    Column =:= 0,
    NewLine is Line + 1,
    NewColumn is Column.

updateCoordsTop(Line, Column, NewLine, NewColumn):-
    (Line =:= 0; Line =:= 2),
    NewLine is Line,
    NewColumn is Column - 1.

updateCoordsBot(Line,Column, NewLine, NewColumn):-
    (Line =:= 1; Line =:= 3),
    Column =:= 6,
    NewLine is Line - 1,
    NewColumn is Column.

updateCoordsBot(Line,Column, NewLine, NewColumn):-
    (Line =:= 1; Line =:= 3),
    NewLine is Line,
    NewColumn is Column + 1.

updateCoords(Line,Column, NewLine, NewColumn):-
    (Line =:= 0; Line =:= 2),
    updateCoordsTop(Line,Column, NewLine, NewColumn).

updateCoords(Line,Column, NewLine, NewColumn):-
    (Line =:= 1; Line =:= 3),
    updateCoordsBot(Line,Column, NewLine, NewColumn).


%make a move 
move(_, _, 0, Board , Board).
move(Line, Column, Seeds, Board, NewBoard):-
    Seeds > 0,
    updateCoords(Line,Column,NewLine,NewColumn),
    incrementOne(NewLine,NewColumn,Board, BoardInc),

    NewSeeds is Seeds - 1,
    move(NewLine, NewColumn, NewSeeds, BoardInc, NewBoard).
        
%----------------------------------
%Game logic end
%----------------------------------

%----------------------------------
%Game
%----------------------------------
init:-
    initialBoard(Tab),
    cycle(Tab).

cycle(Board):-
    drawTopBorder,
    drawAll(Board, 0),
    
    nl,nl,nl,nl,nl,nl,
    takeAllSeedsAt(0,0,Board, Board1, Seeds),
    move(0,0,Seeds,Board1, NewBoard),

    drawTopBorder,
    drawAll(NewBoard, 0),
    nl.

%----------------------------------
%Game end
%----------------------------------
