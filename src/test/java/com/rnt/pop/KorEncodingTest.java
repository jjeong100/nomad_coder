package com.rnt.pop;

public class KorEncodingTest {
	
	public static void main(String[] args) {
		
		String string = "PP Band (15mm) 수출용";
		
		for (int i = 0; i < string.length(); i++) {
		    System.out.print(String.format("U+%04X ", string.codePointAt(i)));
		}
		System.out.println();
		
		String strZpl = "";
		for (int i = 0; i < string.length(); i++) {
			String word = String.valueOf(string.charAt(i));
			System.out.print(word);
			
			if (word.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
				// 글자가 한글인 경우
				byte[] bytes = word.getBytes();
				for (byte b : bytes) {
					strZpl += String.format("_%02X", b);
				}
			} else {
				// 글자가 한글이 아닌 경우
				strZpl += word;
			}
		}
		System.out.println();
		System.out.println(strZpl);
		System.out.println();
		
/* 
 * output
 * U+0050 U+0050 U+0020 U+0042 U+0061 U+006E U+0064 U+0020 U+0028 U+0031 U+0035 U+006D U+006D U+0029 U+0020 U+C218 U+CD9C U+C6A9
 * PP Band (15mm) 수출용
 * PP Band (15mm) _EC_88_98_EC_B6_9C_EC_9A_A9
 */
		
	}
	
	
}
