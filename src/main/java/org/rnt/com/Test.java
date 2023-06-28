package org.rnt.com;

public class Test {

	public static void main(String[] args) {
		Double tot = 38D;
		Double boxPer = 10D;
		int boxCnt = (int)Math.ceil(tot/boxPer);
		
		System.out.println("boxCnt:"+boxCnt);

	}

}
