import java.util.ArrayList;

/*
 * ALU_rand_tester.java
 * 
 */


public class ALU_rand_tester {
	
	
	static int last_rand = 0;
	
	public static int random(int cap){
		
		//LCG numbers from ZX81
		//m = 2^8 + 1 = 257
		//a = 75
		//c = 74
		
		last_rand  = ((75*last_rand)+74) % (256*256);
		
		return last_rand % cap;
	}
	
	
	public static void main (String[] args) {
		
		ArrayList<Integer> arl = new ArrayList<Integer>();
		
		
		int sum = 0;
		
		for(int i=0;i<100;i++) {
			int num = random(256*256);
			arl.add(num);
			sum += num;
			System.out.println(num);
		}
		
		System.out.println("Average is " + (double)(sum)/(100.0) + " expected ~" + (256*256)/2);
		
		double dsum = 0;
		
		for(int i=0;i<100;i++) {
			
			int cap = i+1;
			
			int num = random(cap);
			arl.add(num);
			dsum += (double)num / (double)(cap);
			System.out.println(num + ", " + num / (double) cap);
		}
		
		System.out.println("Average is " + (double)(dsum)/100);
		
	}
}

