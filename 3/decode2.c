//decode2.c

//x = rdi, y = rsi, z = rdx, return = rax
long decode2(long x, long y, long z){
	y -= z;
	x *= y;
	long temp = y;
	temp = temp << 63;
	temp = temp >> 63;
	temp = temp ^ x;
	return temp;
}
