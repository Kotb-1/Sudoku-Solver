function each_cell_chk_f = sudoku_link(each_cell_chk)
    each_cell_chk_f = each_cell_chk;
    for n = 1:9
        for i = 1:3
            for z = 1:3
                i_index = ((i-1)*3)+1:i*3;
                z_index = ((z-1)*3)+1:z*3;
                n_chk = false(3);
                bo_each = each_cell_chk_f(i_index,z_index);
                for p =1:9
                    n_chk(p)= bo_each{p}(n);
                end
                col_if = sum(n_chk);
                row_if = sum(n_chk,2).';
                col_n = find(col_if>0);
                row_n = find(row_if>0);
                if numel(row_n) == 1
                    row_in = i_index(row_n);
                    for r = 1:9
                        if all(z_index~=r)
                            each_cell_chk_f{row_in,r}(n) = 0;
                        end
                    end
                end
                if numel(col_n) == 1
                    col_in = z_index(col_n);
                    for r = 1:9
                        if all(i_index~=r)
                            each_cell_chk_f{r,col_in}(n) = 0;
                        end
                    end
                end
            end
        end
    end
end