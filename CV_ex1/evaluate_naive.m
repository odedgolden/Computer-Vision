function [P,R,F]=evaluate_naive(E,E_GT)
e=sum(E(:)==1);
gt=sum(E_GT(:)==1);
E_CROSS=E+E_GT;
cross=sum(E_CROSS(:)==2);
P=cross/e;
R=cross/gt;
F=2*(P*R/(P+R));

