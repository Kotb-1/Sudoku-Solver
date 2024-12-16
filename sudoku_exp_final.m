function grf = sudoku_exp_final(gr)
    each_cell_chk = cell(9);
    [each_cell_chk{:}] = deal(true([1 9]));
    s = ones(9);
    coun = 0;
    coun_max = 20;
    
    while sum(sum(s)) ~= 0 && coun < coun_max
        coun = coun+1;
        [gr,each_cell_chk,s] = sudoku_initial(gr,each_cell_chk);
        each_cell_chk = box_guess(each_cell_chk);
        each_cell_chk = row_guess(each_cell_chk);
        each_cell_chk = col_guess(each_cell_chk);
        each_cell_chk = sudoku_link(each_cell_chk);
    end
    grf = gr;
end