function each_cell_chk_new = col_guess(each_cell_chk)
each_cell_chk_new = cell(9);
    for yn = 1:2
        for i = 1:9
            bo_each_col = each_cell_chk(:,i);
            N_col = arrayfun(@(k) sum(arrayfun(@(j) isequal(bo_each_col{k}, bo_each_col{j}), 1:numel(bo_each_col))), 1:numel(bo_each_col));
            not_one = N_col;
            not_one(N_col==1) = [];
            %code to eleminate identicals
            for ii = min(not_one):max(N_col)
                ch_coor = find(N_col==ii);
                if ~isempty(ch_coor)
                    ch_logic = N_col==ii;
                    nums = cell2mat(bo_each_col(ch_coor(1)));
                    if sum(nums) == ii
                        dup_col = bo_each_col(~ch_logic);
                        for z = 1:length(dup_col)
                            dup_col{z}(nums) = false;
                        end
                        bo_each_col(~ch_logic) = dup_col;
                    end
                end
            end
    
            % Return Column
            each_cell_chk_new(:,i) = bo_each_col;
        end
    end
end