:- include('game.pl').

/* 
    clear/0 
    Clears the screen.
*/
clear:- 
    write('\33\[2J').

/* 
    display_logo/0 
    displays the game logo.
*/
display_logo:-
    write('                                                  \n'),
    write('      #####    ##     ##  ##  ##    ##    #####   \n'),
    write('     ##   ##   ##     ##  ##   ##  ##    ##   ##  \n'),
    write('    ##     ##  ##     ##  ##    ####    ##     ## \n'),
    write('    ##     ##  ##     ##  ##     ##     ##     ## \n'),
    write('    ##  ## ##  ##     ##  ##    ####    ##     ## \n'),
    write('     ##   ##    ##   ##   ##   ##  ##    ##   ##  \n'),
    write('      ##### ##   #####    ##  ##    ##    #####   \n'),
    write('                                                  \n').

/* 
    display_main_menu_logo/0 
    displays the main menu logo.
*/
display_main_menu_logo:-
    write('                                                  \n'),
    write('    #   #   #   # #   #    #   # #### #   # #   # \n'), 
    write('    ## ##  # #    ##  #    ## ## #    ##  # #   # \n'), 
    write('    # # # ##### # # # #    # # # ###  # # # #   # \n'), 
    write('    #   # #   # # #  ##    #   # #    #  ## #   # \n'), 
    write('    #   # #   # # #   #    #   # #### #   #  ###  \n'),
    write('                                                  \n'). 

/* 
    display_pvp_logo/0 
    displays the PvP logo.
*/
display_pvp_logo:-
    write('                                                  \n'),
    write('              ####              ####              \n'), 
    write('              #   #   #     #   #   #             \n'), 
    write('              ####     #   #    ####              \n'), 
    write('              #         # #     #                 \n'), 
    write('              #          #      #                 \n'),
    write('                                                  \n'). 

/* 
    display_pvc_logo/0 
    displays the PvC logo
*/
display_pvc_logo:-
    write('                                                  \n'),
    write('              ####               ###              \n'), 
    write('              #   #   #     #   #   #             \n'), 
    write('              ####     #   #    #                 \n'), 
    write('              #         # #     #   #             \n'), 
    write('              #          #       ###              \n'),
    write('                                                  \n'). 

/* 
    display_cvc_logo/0 
    displays the PvC logo.
*/
display_cvc_logo:-
    write('                                                  \n'),
    write('               ###               ###              \n'), 
    write('              #   #   #     #   #   #             \n'), 
    write('              #        #   #    #                 \n'), 
    write('              #   #     # #     #   #             \n'), 
    write('               ###       #       ###              \n'),
    write('                                                  \n'). 

/* 
    display_instructions_logo/0 
    displays the instructions logo.
*/
display_instructions_logo:-
    write('                                                  \n'),
    write(' # #  #  ## ### ###  #  #  ## ### #  ##  #  #  ## \n'), 
    write(' # ## # #    #  #  # #  # #    #  # #  # ## # #   \n'), 
    write(' # # ##  #   #  ###  #  # #    #  # #  # # ##  #  \n'), 
    write(' # #  #   #  #  # #  #  # #    #  # #  # #  #   # \n'), 
    write(' # #  # ##   #  #  #  ##   ##  #  #  ##  #  # ##  \n'),
    write('                                                  \n'). 

/*
    header(+Header)
    displays a formatted header.
*/
display_header(Header):-
  format('~n~`*t ~p ~`*t~57|~n', [Header]).

/*
    display_col_header(+Label1, +Label2)
    displays the header of 2 columns.
*/
display_col_header(Label1, Label2):-
  format('~t~a~t~20+~t~a~t~50|~n',
          [Label1, Label2]).

/*
    display_option(+Option, +Description)
    displays the option number and associated description.
*/
display_option(Option, Description):-
  format('~t~d~t~20|~t~a~t~30+~t~48|~n',
        [Option, Description]).

/*
------------------MAIN MENU------------------
*/

/*
    main_menu_read_option(+Low, +High, -Number)
    Reads option chosen in Main Menu.
*/
main_menu_read_option(L, H, N):-
    format('| Choose an option (~d-~d) - ', [L, H]),
    read(N),
    main_menu_check_option(L, H, N).

/*
    main_menu_check_option(+Low, +High, -Number)
    Checks option chosen in Main Menu and redirects to page.
*/
main_menu_check_option(L, H, N):-
    (   (N =< H, N >= L) ->    
        main_menu_option(N); 
        write('| Enter a valid number!'), 
        nl,
        main_menu_read_option(L, H, _)
    ).

main_menu_option(1):-
    clear,
    display_pvp_logo,
    display_pvp_menu.

main_menu_option(2):-
    clear,
    display_pvc_logo,
    display_pvp_menu.

main_menu_option(3):-
    clear,
    display_cvc_logo,
    display_pvp_menu.

main_menu_option(4):-
    clear,
    display_instructions_logo,
    nl,
    nl,
    
    display_header('Goal of the Game:'),
    nl,
    write('To make a horizontal, vertical or diagonal line'),
    write('from 5 cubes bearing your symbol.'),
    nl,

    display_header('Choosing and taking a cube:'),
    nl,
    write('The player chooses and takes a blank cube, '),
    write('or one with his/her symbol on it, from the board`s borders. '),
    nl,

    display_header('Replacing a cube:'),
    nl,
    write('The player can choose at which end of the incomplete rows '),
    write('made when a cube is taken, the cube is to be replaced. '),
    write('The player pushes this end to replace the cube. '),
    write('You can never replace the cube just played '),
    write('back in the position from which it was taken.'),
    nl,

    display_header('End of the Game:'),
    nl,
    write('The winner is the player to make a horizontal, vertical'),
    write('or diagonal line with 5 cubes bearing his/her symbol. '),
    write('The player to make a line with his/her opponent`s symbol '),
    write('loses the game, even if he/she makes a line '),
    write('with his/her own symbol at the same time.'),
    nl,

    instructions_read_option(0, 0, Number).

main_menu_option(5):-
    clear,
    write('| Thank you for playing! |').

/*
    mainMenu/0
    Main Menu display function.
*/
display_main_menu:-
    
    display_col_header('Option', 'Description'),
    nl,
    display_option(1, 'Player vs Player'),
    display_option(2, 'Player vs Computer'),
    display_option(3, 'Computer vs Computer'),
    display_option(4, 'Game Intructions'),
    display_option(5, 'Exit'),
    nl,
    main_menu_read_option(1, 5, _Number).

/*
------------------MODE MENU------------------
*/

/* 
    mode_menu_read_option(+Low, +High, -Number)
    Reads option chosen in Modes Menu.
*/
mode_menu_read_option(L, H, N):-
    format('| Choose an option (~d-~d) - ', [L, H]),
    read(N),
    mode_menu_check_option(L, H, N).

/*
    mode_menu_check_option(+Low, +High, -Number)
    Checks option chosen in Modes Menu and redirects to page.
*/
mode_menu_check_option(L, H, N):-
    (   (N =< H, N >= L) ->    
        mode_menu_option(N)  ; 
        write('| Enter a valid number!'), 
        nl,
        mode_menu_read_option(L, H, _)
    ).

mode_menu_option(1):-
    clear,
    write('  | 012'),nl,
    write('--------'),nl,
    initial_state(3, _, [Board, 1]).

mode_menu_option(2):-
    clear,
    write('  | 0123'),nl,
    write('---------'),nl,
    initial_state(4, _, [Board, 1]).

mode_menu_option(3):-
    clear,
    write('  | 01234'),nl,
    write('----------'),nl,
    initial_state(5, _, [Board, 1]).

mode_menu_option(4):-
    play.


/*
    display_pvp_menu/0
    PvP Menu display function.
*/
display_pvp_menu:-
    nl,
    display_header('Choose board size.'),
    nl,
    display_col_header('Option', 'Description'),
    nl,
    display_option(1, '3x3'),
    display_option(2, '4x4'),
    display_option(3, '5x5'),
    nl,
    display_option(4, 'Return'),
    nl,
    mode_menu_read_option(1, 4, _Number).

/*
    display_pvc_menu/0
    PvC Menu display function.
*/
display_pvc_menu:-
    nl,
    display_header('Choose board size.'),
    nl,
    display_col_header('Option', 'Description'),
    nl,
    display_option(1, '3x3'),
    display_option(2, '4x4'),
    display_option(3, '5x5'),
    nl,
    display_option(4, 'Return'),
    nl,
    mode_menu_read_option(1, 4, _Number).

/*
    display_cvc_menu/0
    CvC Menu display function.
    */
display_cvc_menu:-
    nl,
    display_header('Choose board size.'),
    nl,
    display_col_header('Option', 'Description'),
    nl,
    display_option(1, '3x3'),
    display_option(2, '4x4'),
    display_option(3, '5x5'),
    nl,
    display_option(4, 'Return'),
    nl,
    mode_menu_read_option(1, 4, _Number).

/*
------------------INSTRUCTIONS PAGE------------------
*/

/*
    instructions_read_option(+Low, +High, -Number)
    Reads option chosen in Instructions Page.
*/
instructions_read_option(L, H, N):-
    write('| Insert 0 to return to Main Menu.'),
    read(N),
    instructions_check_option(L, H, N).

/*
    instructions_check_option(+Low, +High, -Number)
    Checks option chosen in Instructions Page and redirects to page.
*/
instructions_check_option(L, H, N):-
    (   (N =< H, N >= L) ->    
        instructions_option(N); 
        write('| Enter a valid number!'), 
        nl,
        instructions_read_option(L, H, _)
    ).

instructions_option(0):-
    play.