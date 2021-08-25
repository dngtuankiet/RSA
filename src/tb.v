`timescale 1ns/1ps
module tb ();

reg				iClk, iRstn;
reg				iStart;
reg				iWrM, iWrE, iWrN;
wire		[63:0]	iM, iE, iN;
reg				iRdR;
wire	[63:0]	oR;
wire			oDone;

integer			i;
reg	[1023:0]	M, E, N, R;

RSA_ModExp U0 (
	.iClk	(iClk),
	.iRstn	(iRstn),
	.iStart	(iStart),
	.iWrM	(iWrM),
	.iWrE	(iWrE),
	.iWrN	(iWrN),
	.iM		(iM),
	.iE		(iE),
	.iN		(iN),
	.iRdR	(iRdR),
	.oR		(oR),
	.oDone	(oDone)	);

always #5 iClk = ~iClk;

assign iM = M[63:0];
assign iE = E[63:0];
assign iN = N[63:0];

initial begin
iClk = 1'b0;
iRstn = 1'b0;
iStart = 1'b0;
iWrM = 1'b0;
iWrE = 1'b0;
iWrN = 1'b0;
M = 1024'b0;
E = 1024'b0;
N = 1024'b0;
iRdR = 1'b0;
#16	iRstn = 1'b1;
#20	M = 1024'd2;
	E = 1024'd4;
	N = 1024'd3;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 1");
	if(R=='d1)	$display("Value get: %d CORRECT",R);
	else		$display("Value get: %d WRONG!",R);
#10	M = 1024'd3;
	E = 1024'd6;
	N = 1024'd10;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 9");
	if(R=='d9)	$display("Value get: %d CORRECT",R);
	else		$display("Value get: %d WRONG!",R);
#10	M = 1024'd7;
	E = 1024'd5;
	N = 1024'd9;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 4");
	if(R=='d4)	$display("Value get: %d CORRECT",R);
	else		$display("Value get: %d WRONG!",R);
#10	M = 1024'd8;
	E = 1024'd6;
	N = 1024'd13;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 12");
	if(R=='d12)	$display("Value get: %d CORRECT",R);
	else		$display("Value get: %d WRONG!",R);
#10 M = 1024'd65;
	E = 1024'd17;
	N = 1024'd3233;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 2790");
	if(R=='d2790)	$display("Value get: %d CORRECT",R);
	else			$display("Value get: %d WRONG!",R);
#10	M = 1024'd2790;
	E = 1024'd413;
	N = 1024'd3233;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 65");
	if(R=='d65)	$display("Value get: %d CORRECT",R);
	else		$display("Value get: %d WRONG!",R);
#10	M = 1024'h0008df668ac99f93ab900fd3ba636a00cc747142e129d188480440eda318bc0697b0b689745d228be9ddf1cf1292ad6da790c1188845a8f20d54b11ba993e3fab7bb70c136e28d980e5548f14b4455981307cf6aa392cd259d2386788aa636216c4b39f91d715ba7ebdb674c2e1166522727ea0339834b5badc752627a7e74d2;
	E = 1024'h000016ad1c9b2a8f40a2235152d54b1662e578f2542235740325649a504f3a206d8a237500c716b1163168604c117a0967cb51b06e8a06c53d727b4144651fe243cd18c110e20bb33d66443d5ecd390166496ceb5639328372e01238237c0c7f660c37134b6b58c03a87397b08d96cba1b787a450f4c05fa285501314f0118d3;
	N = 1024'h00154424e24caec8527571745f1da82e25b3aa4dc32ded41ef068a9b5c66b5f4e7ae797b6417505e60f312c420f989726cae1ab5a20d5d413d4fcdf2b3df3fa060722812d635ad3a72aa003b957c85f63b39ae11dbee6116b36748f6866d0932017c218e7665b4cac76c5914ca477aca167c890e2cb4d4d9a8e179927d44ea71;
	iWrM = 1'b1;
	for(i=0;i<15;i=i+1) #10 M = {M[63:0],M[1023:64]};
#10 M = {M[63:0],M[1023:64]};
	iWrM = 1'b0;
	iWrE = 1'b1;
	for(i=0;i<15;i=i+1) #10 E = {E[63:0],E[1023:64]};
#10	E = {E[63:0],E[1023:64]};
	iWrE = 1'b0;
	iWrN = 1'b1;
	for(i=0;i<15;i=i+1) #10 N = {N[63:0],N[1023:64]};
#10	N = {N[63:0],N[1023:64]};
	iWrN = 1'b0;
	iStart = 1'b1;
#10	iStart = 1'b0;
	while(!oDone) #10;
#10	iRdR = 1'b1;
	for(i=0;i<15;i=i+1) #10 R = {oR,R[1023:64]};
#10	R = {oR,R[1023:64]};
	iRdR = 1'b0;
	$display("Expected : 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111ffffffff0123456798765432");
	if(R=='h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111ffffffff0123456798765432)
			$display("Value get: %h CORRECT",R);
	else	$display("Value get: %h WRONG!",R);
end

endmodule
