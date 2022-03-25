import java.util.ArrayList;

/*
 * ALU_rand_tester.java
 * 
 */


public class ALU_rand_tester {
	
	static final int NUM_TEST = 10000;
	
	static int last_rand = 11;
	
	public static int random_(int cap){
		
		//LCG numbers from ZX81
		//m = 2^8 + 1 = 257
		//a = 75
		//c = 74
		
		last_rand  = ((75*last_rand)+74) % (256*256);
		
		return last_rand % cap;
	}
	
	
	//xorshift
	public static int random(int cap) {
		last_rand++;
		int x = last_rand;
		
		x ^= (x << 13) & (0xFFFF);
		x ^= (x >> 17)  & (0xFFFF);
		x ^= (x << 5)  & (0xFFFF);
		
		last_rand = x  & (0xFFFF);
		
		return Math.abs(last_rand % cap) & (0xFFFF);
	}
	
	
	public static void main (String[] args) {
		
		ArrayList<Integer> arl = new ArrayList<Integer>();
		
		
		int sum = 0;
		
		for(int i=0;i<NUM_TEST;i++) {
			int num = random(256*256);
			arl.add(num);
			sum += num;
			//System.out.println(num);
		}
		
		System.out.println("Average is " + (double)(sum)/(NUM_TEST*1.0) + " expected ~" + (256*256)/2);
		
		double dsum = 0;
		
		for(int i=0;i<NUM_TEST;i++) {
			
			int cap = i+1;
			
			int num = random(cap);
			arl.add(num);
			dsum += (double)num / (double)(cap);
			//System.out.println(num + ", " + num / (double) cap);
		}
		
		System.out.println("Average is " + (double)(dsum)/(NUM_TEST));
		
	}
}

