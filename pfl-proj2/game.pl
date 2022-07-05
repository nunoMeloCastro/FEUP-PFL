:- include('utils.pl').

% GameSate will save the CurrentPlayer and Board
initial_state(Size, NewSize, [Board|CurrentPlayer]):-
    create_board(Size, Board),
    NewSize is Size - 1,
    display_game([Board, CurrentPlayer], NewSize).

move([Board|CurrentPlayer], [RowID|ColID], NewGameSate, Size):-
    nth0(RowID, Board, Row),
    (
        (CurrentPlayer =:= 1) ->
        replace_by_index(Row, ColID, 'X', NewRow),
        NewCurrentPlayer is 2 ;
        replace_by_index(Row, ColID, 'O', NewRow),
        NewCurrentPlayer is 1
    ),
    replace_by_index(Board, RowID, NewRow, NewBoard),
    clear,
    display_game([NewBoard, NewCurrentPlayer], Size).

game_over(GameSate, Winner):-
    write('game over').

value(GameSate, Player, Value):-
    write('value').

display_board(_, _, []).
display_board(RowID, NewRowID, [H|T]):-
    format('~d | ', [RowID]),
    NewRowID is RowID + 1,
    display_row(H),
    nl,
    display_board(NewRowID, _, T).

display_row([]).
display_row([H|T]):-
    write(H),
    display_row(T).

display_game([Board|CurrentPlayer], Size):-
    display_board(0, _, Board),
    format('| Player ~d, choose a column - ', [CurrentPlayer]),
    check_Col([Board|CurrentPlayer], 0, Size).

%% check_Col([Board|CurrentPlayer], +Low, +High)
check_Col([Board|CurrentPlayer], L, H):-
    read(Col),
    (   (Col == L) ->    
        format('| Player ~d, now choose any row - ', [CurrentPlayer]),
        check_any_Row([Board|CurrentPlayer], 0, H, Col);  
        (Col =:= H) ->    
        format('| Player ~d, now choose any row - ', [CurrentPlayer]),
        check_any_Row([Board|CurrentPlayer], 0, H, Col);
        (Col < H, Col > L) ->    
        format('| Player ~d, now choose between row 0 or ~d - ', [CurrentPlayer, H]),
        check_Row([Board|CurrentPlayer], 0, H, Col); 
        write('| Enter a valid column!'), 
        nl,
        check_Col([Board|CurrentPlayer], L, H)
    ).

%% check_any_Row([Board|CurrentPlayer], +Low, +High, -Number)
check_any_Row([Board|CurrentPlayer], L, H, Col):-
    read(Row),
    (   (Row =< H, Row >= L) ->
        check_Directions([Board|CurrentPlayer], L, H, Col, Row);    
        write('| Enter a valid row!'), 
        nl,
        check_any_Row([Board|CurrentPlayer], L, H, Col)
    ).

%% check_any_Row([Board|CurrentPlayer], +Low, +High, -Number)
check_Row([Board|CurrentPlayer], L, H, Col):-
    read(Row),
    (   (Row == H) ->  
        check_Directions([Board|CurrentPlayer], L, H, Col, Row);   
        (Row == L) ->    
        check_Directions([Board|CurrentPlayer], L, H, Col, Row);
        write('| Enter a valid row!'), 
        nl,
        check_any_Row([Board|CurrentPlayer], L, H, Col)
    ).

%% check_Directions([Board|CurrentPlayer], +Low, +High, +Col, +Row)
check_Directions([Board|CurrentPlayer], L, H, Col, Row):-
    display_header('Choose push direction.'),
    (   (Col == L, Row == L) ->
        display_col_header('Option', 'Direction'),
        display_option(1, 'Up'),
        display_option(2, 'Left'),
        nl,
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_up([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_left([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );
        
        (Col == L, Row == H) ->    
        display_col_header('Option', 'Direction'),
        display_option(1, 'Up'),
        display_option(2, 'Right'),
        nl,
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_up([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_right([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );

        (Col == H, Row == L) ->    
        display_col_header('Option', 'Direction'),
        display_option(1, 'Down'),
        display_option(2, 'Left'),
        nl,
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_down([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_left([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );

        (Col == H, Row == H) ->    
        display_col_header('Option', 'Direction'),
        display_option(1, 'Down'),
        display_option(2, 'Right'),
        nl,
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_down([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_right([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );

        (Col == L) ->    
        display_col_header('Option', 'Direction'),
        display_option(1, 'Up'),
        display_option(2, 'Left'),
        display_option(3, 'Down'),
        nl,
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_up([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_left([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 3) ->
            move_down([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );

        (Col == H) ->    
        display_col_header('Option', 'Direction'),
        display_option(1, 'Up'),
        display_option(2, 'Right'),
        display_option(3, 'Down'),
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_up([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_right([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 3) ->
            move_down([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );

        (Row == L) ->    
        display_col_header('Option', 'Direction'),
        display_option(1, 'Up'),
        display_option(2, 'Left'),
        display_option(3, 'Right'),
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_up([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_left([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 3) ->
            move_right([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        );
   
        display_col_header('Option', 'Direction'),
        display_option(1, 'Left'),
        display_option(2, 'Right'),
        display_option(3, 'Down'),
        write('Select direction -'),
        read(D),
        (   (D == 1) ->
            move_left([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 2) ->
            move_rigth([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            (D == 3) ->
            move_down([Board|CurrentPlayer], Row, Col, H, NewGameSate);
            nl,
            write('Invalid option -'),
            check_Directions([Board|CurrentPlayer], L, H, Col, Row)
        )
    ).

move_left([Board|CurrentPlayer], RowID, ColID, Size, NewGameSate):-
    nth0(RowID, Board, Row),
    delete_by_index(Row, ColID, AuxRow),
    (
        (CurrentPlayer =:= 1) ->
        append(AuxRow, ['X'], NewRow), 
        NewCurrentPlayer is 2 ;
        append(AuxRow, ['O'], NewRow),
        NewCurrentPlayer is 1
    ),
    replace_by_index(Board, RowID, NewRow, NewBoard),
    clear,
    display_game([NewBoard,NewCurrentPlayer], Size).

move_right([Board|CurrentPlayer], RowID, ColID, Size, NewGameSate):-
    nth0(RowID, Board, Row),
    delete_by_index(Row, ColID, AuxRow),
    (
        (CurrentPlayer =:= 1) ->
        append_head(AuxRow, 'X', NewRow), 
        NewCurrentPlayer is 2 ;
        append_head(AuxRow, 'O', NewRow),
        NewCurrentPlayer is 1
    ),
    replace_by_index(Board, RowID, NewRow, NewBoard),
    clear,
    display_game([NewBoard,NewCurrentPlayer], Size).


move_up([Board|CurrentPlayer], RowID, ColID, Size, NewGameSate):-
    NextRowID is RowID + 1,
    (
        NextRowID =:= Size + 1 ->
        nth0(RowID, Board, RowToChange),
        (
            (CurrentPlayer =:= 1) ->
            replace_by_index(RowToChange, ColID, 'X', NewRow),
            NewCurrentPlayer is 2 ;
            replace_by_index(RowToChange, ColID, 'O', NewRow),
            NewCurrentPlayer is 1
        ),
        replace_by_index(Board, RowID, NewRow, NewBoard),
        clear,
        display_game([NewBoard,NewCurrentPlayer], Size)
        ; 
        nth0(NextRowID, Board, NextRow),    
        nth0(ColID, NextRow, Element),% Get element from next Row
        %Get current row
        nth0(RowID, Board, CurrentRow),
        % Replace element from currentRow from the nextrow
        replace_by_index(CurrentRow, ColID, Element, NewRow),
        replace_by_index(Board, RowID, NewRow, NewBoard),
        move_up([NewBoard|CurrentPlayer], NextRowID, ColID , Size, NewGameSate)
    ).

move_down([Board|CurrentPlayer], RowID, ColID, Size, NewGameSate):-
    PreviousRowID is RowID - 1,
    (
        PreviousRowID == -1 ->
        nth0(RowID, Board, RowToChange),
        (
            (CurrentPlayer =:= 1) ->
            replace_by_index(RowToChange, ColID, 'X', NewRow),
            NewCurrentPlayer is 2 ;
            replace_by_index(RowToChange, ColID, 'O', NewRow),
            NewCurrentPlayer is 1
        ),
        replace_by_index(Board, NewRowID, NewRow, NewBoard),
        clear,
        display_game([NewBoard,NewCurrentPlayer], Size)
        ; 
        % Get previous row
        nth0(PreviousRowID, Board, PreviousRow),   

        % Get element from previous row
        nth0(ColID, PreviousRow, Element),

        % Get current row
        nth0(RowID, Board, CurrentRow),

        % Replace element from CurrentRow from the PreviousRow
        replace_by_index(CurrentRow, ColID, Element, NewRow),
        replace_by_index(Board, RowID, NewRow, NewBoard),

        move_down([NewBoard|CurrentPlayer], PreviousRowID, ColID , Size, NewGameSate)
    ).

linesWin([RowID|ColID], Index, NewIndex, Player, Size, Win):-
    (   (Index < Size) -> 
            nth0(Index, [RowID|ColID], Row),
            checkLineWin(Row, 0, _, Player, Size, Win),
            (   (Win == 0) ->
                NewIndex is Index + 1,
                linesWin([RowID|ColID], NewIndex, _, Player, Size, _Win);
                Win is 1
            );
        Win is 0
    ).

checkLineWin([RowID|ColID], Col, NewCol, Player, Size, Win):-
    (   (Col < Size) -> 
            nth0(Col, [RowID|ColID], Elem),
            (   (Elem == Player) ->
                NewCol is Col + 1,
                checkLineWin([RowID|ColID], NewCol, _, Player, Size, _Win);
                Win is 0
            );
        Win is 1
    ).

colWin([RowID|ColID], Index, NewIndex, Player, Size, Win):-
    (   (Index < Size) -> 
            checkColWin([RowID|ColID], 0, Index, _, Player, Size, Win),
            (   (Win == 0)->
                NewIndex is Index + 1,
                colWin([RowID|ColID], NewIndex, _, Player, Size, _Win);
                Win is 1     
            );
        Win is 0
    ).

checkColWin([RowID|ColID], Row, Col, NewRow, Player, Size, Win):-
    (   (Row < Size) ->
            nth0(Row, [RowID|ColID], List),
            nth0(Col, List, Elem),
            (   (Elem == Player) ->
                NewRow is Row + 1,
                checkColWin([RowID|ColID], NewRow, Col, _, Player, Size, _Win);
                Win is 0
            );
        Win is 1
    ).

diagonalWin([RowID|ColID], Row, Col, NewRow, NewCol, Player, Size, Win):-
    (   (Row < Size) ->
            nth0(Row, [RowID|ColID], List),
            nth0(Col, List, Elem),
            (   (Elem == Player) ->
                NewRow is Row + 1,
                NewCol is Col + 1,
                diagonalWin([RowID|ColID], NewRow, NewCol, _, _, Player, Size, _Win);
                Win is 0
            );
        Win is 1
    ).

diagonal2Win([RowID|ColID], Row, Col, NewRow, NewCol, Player, Size, Win):-
    (   (Row < Size) ->
            nth0(Row, [RowID|ColID], List),
            nth0(Col, List, Elem),
            (   (Elem == Player) ->
                NewRow is Row + 1,
                NewCol is Col - 1, 
                diagonal2Win([RowID|ColID], NewRow, NewCol, _, _, Player, Size, _Win);
                Win is 0
            );
        Win is 1
    ).

