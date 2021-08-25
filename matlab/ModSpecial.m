% require input: 0<A<2N
% output: R=A%N
function R = ModSpecial(A,N)
    if A<N
        R = A;
    else
        R = A-N;
    end
end