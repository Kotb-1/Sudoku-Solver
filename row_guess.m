function each_cell_chk_new = row_guess(each_cell_chk)
each_cell_chk_new = cell(9);
    for i = 1:9
        bo_each_row = each_cell_chk(i,:);
        N_row = arrayfun(@(k) sum(arrayfun(@(j) isequal(bo_each_row{k}, bo_each_row{j}), 1:numel(bo_each_row))), 1:numel(bo_each_row));
        not_one = N_row;
        not_one(N_row==1) = [];
        %code to eleminate identicals
        for ii = min(not_one):max(N_row)
            ch_coor = find(N_row==ii);
            if ~isempty(ch_coor)
                ch_logic = N_row==ii;
                nums = cell2mat(bo_each_row(ch_coor(1)));
                if sum(nums) == ii
                    dup_row = bo_each_row(~ch_logic);
                    for z = 1:length(dup_row)
                        dup_row{z}(nums) = false;
                    end
                    bo_each_row(~ch_logic) = dup_row;
                end
            end
        end

        % Return Row
        each_cell_chk_new(i,:) = bo_each_row;
    end
end