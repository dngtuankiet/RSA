% require input: 0<A0<N and 0<B0<N
% output: R=(A0*B0)%N
function R = MulMod(A0,B0,N)
% swap for the B is always the smallest
if A0 > B0
    A = A0;
    B = B0;
else
    A = B0;
    B = A0;
end
% get some binary info
b = dec2bin(B);
b = fliplr(b);
k = length(b);
% init values
Rtmp = A;
R = 0;
% loop
for i=1:k
    if b(i)=='1'
        R = ModSpecial(R+Rtmp,N);
    end
    Rtmp = ModSpecial(Rtmp*2,N);
end
end