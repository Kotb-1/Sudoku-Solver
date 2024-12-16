function [grf,each_cell_chk_f,s] = sudoku_initial(gr,each_cell_chk)

s = ones(9);
coun = 0;
coun_max = 30;
verf = zeros(3);

while sum(sum(s)) ~= 0 && coun < coun_max
    coun = coun+1;
    for i = 1:9
        f = gr~=0;
        [each_cell_chk{f}] = deal(false([1 9]));
    end
    
    
    for i = 1:9
        rw = gr(i,:);
        cl = gr(:,i);
        for z = 1:9
            f2 = rw == z;
            f3 = cl == z;
            if sum(f2) == 1
                for r = 1:9
                each_cell_chk{i,r}(z) = false;
                end
            elseif sum(f2) > 1
                error("The number "+z+" exists more than once in row "+i);
            end
    
            if sum(f3) == 1
                for r = 1:9
                each_cell_chk{r,i}(z) = false;
                end
            elseif sum(f3) > 1
                error("The number "+z+" exists more than once in colomn "+i);
            end
        end
    end

    for i = 1:3
        for z = 1:3
            bo = gr(((i-1)*3)+1:i*3,((z-1)*3)+1:z*3);
            for n = 1:9
                f4 = bo == n;
                if sum(sum(f4)) == 1
                    for v = ((i-1)*3)+1:i*3
                        for r = ((z-1)*3)+1:z*3
                            each_cell_chk{v,r}(n) = false;
                        end
                    end
                elseif sum(f4) > 1
                    error("The number "+n+" exists more than once in box "+i);
                end
                o =0;
                for v = ((i-1)*3)+1:i*3
                    o = o+1;
                    oo = 0;
                    for r = ((z-1)*3)+1:z*3
                        oo = oo+1;
                        verf(o,oo) = each_cell_chk{v,r}(n) == 1;
                    end
                end

                if sum(sum(verf)) == 1
                    for v = ((i-1)*3)+1:i*3
                        for r = ((z-1)*3)+1:z*3
                            if each_cell_chk{v,r}(n) == 1
                                gr(v,r) = n;
                            end
                        end
                    end
                end
            end
        end
    end
    for g = 1:9
        for l = 1:9
            s(g,l) = sum(each_cell_chk{g,l});
        end
    end

    w = find(s == 1);

    for i = 1:numel(w)
        col_in = ceil(w(i)/9);
        if mod(w(i),9)==0
            row_in = 9;
        else
            row_in = mod(w(i),9);
        end
        u = find(each_cell_chk{row_in,col_in}==1);
        gr(w(i)) = u;
    end

    pp = isempty(w);
    r_inc = zeros(9);
    c_inc = r_inc;
    s_r_inc = r_inc;
    s_c_inc = r_inc;
    if pp
        for h = 1:9
            for hh = 1:9
                for hhh = 1:9
                    r_inc(hh,hhh) = each_cell_chk{h,hh}(hhh)==1;
                    c_inc(hh,hhh) = each_cell_chk{hh,h}(hhh)==1;
                end
            end
            s_r_inc(h,:) = sum(r_inc);
            s_c_inc(h,:) = sum(c_inc);
        end
        [x_r,y_r] = find(s_r_inc==1);
        [x_c,y_c] = find(s_c_inc==1);
        for d = 1:numel(x_r)
            for q = 1:9
                if each_cell_chk{x_r(d),q}(y_r(d))==1
                    gr(x_r(d),q) = y_r(d);
                end
            end
        end
        for dd = 1:numel(x_c)
            for qq = 1:9
                if each_cell_chk{qq,x_c(dd)}(y_c(dd))==1
                    gr(qq,x_c(dd)) = y_c(dd);
                end
            end
        end
    end
end

grf = gr;
each_cell_chk_f = each_cell_chk;

end