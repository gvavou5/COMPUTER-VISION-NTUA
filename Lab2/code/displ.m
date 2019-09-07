function [displ_x,displ_y] = displ(d_x,d_y)
    d = d_x.^2 + d_y.^2;
    d = d/max(max(d));
    thres=0.4;
    bin = (d >= thres);
    d_x = d_x.*bin;				% Diathrhsh twn dx me energeia panw apo to katwfli
    d_y = d_y.*bin;				% Diathrhsh twn dy me energeia panw apo to katwfli
    sum_x = sum(sum(d_x));		
    sum_y = sum(sum(d_y));
    total = sum(sum(bin));
    displ_x = sum_x/total;		% ypologismos mesou dx
    displ_y = sum_y/total;		% ypologismos mesou dy
end

