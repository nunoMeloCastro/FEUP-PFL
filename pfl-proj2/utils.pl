:- use_module(library(between)).
:- use_module(library(random)).
:- use_module(library(lists)).

%% create_board(+Dimension, ?Board)
create_board(N, B):-
    create_board(N, N, B).

%% create_board(+Rows, +Columns, ?Board)
create_board(0, _, []):- !.
create_board(N, M, [B|Bs]):-
    N1 is N - 1,
    create_row(M, B),
    create_board(N1, M, Bs).

%% create_row(+Size, ?Row)
create_row(0, []):- !.
create_row(M, [0|R]):-
    M1 is M - 1,
    create_row(M1, R).

%% read_number(+Low, +High, -Number)
read_number(L, H, N):-
    format('| Choose the board size (~d-~d) - ', [L, H]),
    read(N),
    check_number(L, H, N).

%% check_number(+Low, +High, -Number)
check_number(L, H, N):-
    (   (N =< H, N >= L) ->    
        create_board(N, _Board)  ; 
        write('| Enter a valid number!'), 
        nl,
        read_number(L, H, _)
    ).

% replace_by_index(+List, +Index, +Value, -NewList)
replace_by_index([_|T], 0, Value, [Value|T]).
replace_by_index([H|T], Index, Value, [H|R]):- 
    Index > -1, 
    NewIndex is Index-1, 
    replace_by_index(T, NewIndex, Value, R), !.
replace_by_index(L, _, _, L).

delete_by_index([G|H],0,H):-!.
delete_by_index([G|H],N,[G|L]):- 
    N >= 1, 
    Nn is N - 1,
    !,
    delete_by_index(H, Nn, L).

append_head(List, Item, [Item|List]).



