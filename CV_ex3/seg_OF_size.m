function I = seg_OF_size(M,th)
th = (max(M)-min(M))*th+min(M);
M = M>th;
L = bwlabel(M);
I = L;