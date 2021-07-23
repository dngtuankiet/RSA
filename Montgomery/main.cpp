#include <iostream>
#include <math.h>

#define HIGH_MASK 0xFFFFFFFF00000000
#define LOW_MASK  0x00000000FFFFFFFF
uint32_t len = 32; //32-bit length

//#define DEBUG

uint32_t MonMult(uint32_t A, uint32_t B, uint32_t N) {
    uint32_t R;
    uint64_t C; //64-bit length
    uint32_t C0; //lower n bit of C
    uint32_t C1; //higher n bit of C
    uint32_t P[len];
    //uint32_t q;
    bool q;

    //Procedure P1:
    C = (unsigned long)A * (unsigned long)B;
    C0 = C & LOW_MASK;  //lower n bit of C
    C1 = (C & HIGH_MASK) >> (len);   //higher n bit of C 
    P[0] = 0;

    #ifdef DEBUG
    std::cout<<"C: "<<C<<std::endl;
    std::cout<<"C0: "<<C0<<std::endl;
    std::cout<<"C1: "<<C1<<std::endl;
    std::cout<<"Recreate C: "<<(unsigned long)(C1*pow(2,len) + C0)<<std::endl;
    #endif //DEBUG

    //Procedure P2:
    for (int i = 0; i < len; i++) {
        //even or odd?
        if((P[i] + (C0 & ((uint32_t)1 << i) >> i)) % 2)
            q = true; //odd
        else
            q = false; //even
        //std::cout<<"C0 &: "<<(C0 & ((uint32_t)1 << i))<<std::endl;
        //std::cout<<i<<"-q: "<<q<<std::endl;

        uint32_t temp;
        if(q)
            temp = N;
        else
            temp = 0;
        P[i+1] = (P[i] + temp + (C0 & ((uint32_t)1 << i) >> i)) >> 1;
        //right shift 1-bit
    }
    //std::cout<< "P[len]: " << P[len]<<std::endl;
    //std::cout<<"C1: "<<C1<<std::endl;

    R = P[len] + C1;
    return R;
}

uint32_t ModExp(uint32_t M, uint32_t E, uint32_t N, uint32_t C){
    int k = 32;
    uint32_t M_prime = MonMult(M, C, N); //pre-processing
    uint32_t R[k];
    R[0] = M_prime;
    for(int i = 0; i < k-1; i++) {
        R[i+1] = MonMult(R[i], R[i], N);
        if( (E & ((uint32_t)1 << (k-i-2))>>(k-i-2)) == 1 )
            R[i+1] = MonMult(R[i+1], M_prime, N);
        else
            R[i+1] = R[i+1];
    }
    R[k-1] = MonMult(R[k-1], 1, N); //post-processing
    return R[k-1];
}

int main() {

    std::cout<<"Montgomery Algorithm\n";
    uint32_t A;
    uint32_t B;
    uint32_t N;
    uint32_t R;

    std::cout<<"\nTest MonMult\n";
    A = (1<<31) + (1<<15) + (1<<1);
    B = (1<<30) + (1<<14);
    N = 1234;
    //A = 3;
    //B = 16;
    //N = 7;
    std::cout<<"A: "<<A<<std::endl;
    std::cout<<"B: "<<B<<std::endl;
    std::cout<<"N: "<<N<<std::endl;
    R = MonMult(A, B, N);
    std::cout << "R: " << R << std::endl;
    std::cout<<"Done MonMult\n\n";


    uint32_t M;
    uint32_t E;
    uint32_t C;
    std::cout<<"\nTest ModExp\n";
    M = (1<<31) + (1<<30) + (1<<15) + (1<<14);
    E = (1<<31) + (1<<23) + (1<<16);
    N = 7432;
    //M = 2; 
    //E = 8;
    //N = 7;
    //C = 3276; // Constant: C = 2^(2*(len+2)) mod N
    C = 4072;
    //C = (uint32_t)(pow(2,2*(len+2))) % N; 
    std::cout<<"M: "<<M<<std::endl;
    std::cout<<"E: "<<E<<std::endl;
    std::cout<<"N: "<<N<<std::endl;
    std::cout<<"C: "<<C<<std::endl;
    R = ModExp(M, E, N, C); //expect 5380
    std::cout << "R: " << R << std::endl;
    std::cout<<"Done ModExp\n\n";









    // //A = (1<<23) + (1<<14) + (1<<6);
    // //B = (1<<28) + (1<<16) + (1<<9);
    // A = pow(2,23) + pow(2,14) + pow(2,6);
    // B = pow(2,28) + pow(2,16) + pow(2,9);
    // N = 11;
    // // std::cout<<"A: "<<A<<std::endl;
    // // std::cout<<"B: "<<B<<std::endl;
    // // std::cout<<"N: "<<N<<std::endl;
    // R = MonMult(A, B, N); //expect 7


    // uint32_t A = pow(2,31) + pow(2,15);
    // uint32_t Ah = (A & HIGH_MASK) >> (len/2);
    // uint32_t Al = A & LOW_MASK;
    // unsigned long Atest = Ah * pow(2,16) + Al;
    // std::cout << "A: " << A << std::endl;
    // std::cout << "Ah: " << Ah << std::endl;
    // std::cout << "Al: " << Al << std::endl;
    // std::cout << "Atest: " << Atest << std::endl;


    return 0;
}
