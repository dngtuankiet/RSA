% require input: 0<=M<N and E>0
% output: R=(M^E)%N
function R = ModExp(M,E,N)
% check legal input
if M<0 || M>=N || E<=0
    R = 0; fprintf('Illegal inputs'); return;
end
% get some binary info
e = dec2bin(E);
e = fliplr(e);
k = length(e);
% init values
Rtmp = M;
R = 1;
% loop
for i=1:k
    if e(i)=='1'
        R = MulMod(R,Rtmp,N);
    end
    Rtmp = MulMod(Rtmp,Rtmp,N);
end
%fprintf('Correct answer: %d\n',powermod(M,E,N));