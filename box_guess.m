function each_cell_chk_new = box_guess(each_cell_chk)
each_cell_chk_new = cell(9);
    for i = 1:3
        for z = 1:3
            
            i_index = ((i-1)*3)+1:i*3;
            z_index = ((z-1)*3)+1:z*3;
            bo_each = each_cell_chk(i_index,z_index);
            N = arrayfun(@(k) sum(arrayfun(@(j) isequal(bo_each{k}, bo_each{j}), 1:numel(bo_each))), 1:numel(bo_each));
            not_one = N;
            not_one(N==1) = [];
            
            %code to eleminate identicals
            for ii = min(not_one):max(N)
                ch_coor = find(N==ii);
                if ~isempty(ch_coor)
                    ch_logic = N==ii;
                    nums = cell2mat(bo_each(ch_coor(1)));
                    if sum(nums) == ii
                        dup = bo_each(~ch_logic);
                        for zz = 1:length(dup)
                            dup{z}(nums) = false;
                        end
                        bo_each(~ch_logic) = dup;
                    end
                end
            end
               
            for t = 1:8
                t_find = false([1,9]);
                fg = t+1:9;
                for tt = 1:9
                    t_find(tt) = bo_each{tt}(t);
                end
                if sum(t_find)==2
                    for t2 = fg
                        t2_find = false([1,9]);

                        for tt2 = 1:9
                            t2_find(tt2) = bo_each{tt2}(t2);
                        end

                        fg2 = false([1,9]);
                        if sum(t_find == t2_find)==9
                            fg2(t) = true;
                            fg2(t2) = true;
                            [bo_each{t_find}] = deal(fg2);
                        end
                    end
                end
            end

            % Retutn Box
            each_cell_chk_new(i_index,z_index) = bo_each;
        end 
    end
end