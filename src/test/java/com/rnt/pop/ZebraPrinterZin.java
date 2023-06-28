package com.rnt.pop;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ZebraPrinterZin {
	
	/** 바코드 프린터 IP Address */
	private String ipAddress;
	/** 바코드 프린터 Port */
	private int port;

	/** 바코드 (제품코드-Lot) */
	private String barCode;
	/** 고객용 바코드 (제품코드-Lot): 자체 규격(입력) */
	private String customCode;

	/** 제품 이름 */
	private String productName;
	/** 규격 */
	private String productDescription;
	/** 거래처명 */
	private String vendor;
	/** 길이(수량) */
	private String qty;
	/** 출력일자: 16.11.14 */
	private String date;

	/** 생산라인 표시 */
	private int line;
	/** 출력 장수 */
	private int count;	
	
	// 메인 함수. (main)
	public static void main(String[] args) {
		new ZebraPrinterZin().print();
	}
	
	
	// 생성자.
	public ZebraPrinterZin() {
		this.ipAddress = "192.168.10.16";
		this.port = 6101;
		
		this.barCode = "P1500005-17327151";
		this.customCode = "P1500005-17327151";
		
		this.productName = "PP15MM*10KG(황색)";
		this.productDescription = "15MM, 10킬로, 황색, 랩 포장.";
		this.vendor = "(주)전주삼신산업";
		this.qty = "롤당 1500m 내외";
		
		this.date = new SimpleDateFormat("yy.MM.dd").format(new Date());
		
		this.line = 3;
		this.count = 1;
	}
	
	// 출력 함수
	public void print() {
		System.out.println(this.toString()); // 변수 저장 상태 출력
		
		String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO40,40"  // 10
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + barCode + "^FS"  // 12345678-16B1201
				+ "^FO730,180^GB100,100,8^FS"   //"^FO730,40^GB100,100,8^FS"
				+ "^FO710,200"               //^FO710,60
				+ "^CFG^FR^FD " + line + " ^FS"
				+"^SEE:UHANGUL.DAT^FS"
				+"^CW1,E:KFONT3.FNT^CI28^FS"
				+ "^FO30,200^A1N,30,30^FH^FD Part NO: " + cnvrtKorToZbUnicd(barCode) + "^FS"
				+ "^FO30,240^A1N,30,30^FH^FD ITEM   : " + cnvrtKorToZbUnicd(productName) + "^FS"
				+ "^FO30,280^A1N,30,30^FH^FD Spec   : " + cnvrtKorToZbUnicd(productDescription) + "^FS"
				+ "^FO30,320^A1N,30,30^FH^FD Vendor : " + cnvrtKorToZbUnicd(vendor) + "^FS"
				+ "^FO30,360^A1N,30,30^FH^FD QTY    : " + cnvrtKorToZbUnicd(qty) + "^FS"
				+ "^FO480,360^A1N,30,30^FH^FD Date: " + cnvrtKorToZbUnicd(date) + "^FS"
				+ "^FO200,420"
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"   // COde 128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + customCode + "^FS"  // 12345678-16B1201
				+ "^XZ";
		
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(ipAddress, port);
			dos = new DataOutputStream(socket.getOutputStream());
			
			for (int i = 0 ; i < count ; i++) {
				dos.writeBytes(zplFormat);
			}
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (socket != null) {  try { socket.close(); } catch (IOException e) { e.printStackTrace(); }  }
			if (dos != null) {  try { dos.close(); } catch (IOException e) { e.printStackTrace(); }  }
		}
		
	}
	
	// 문자열의 한글만 ZebraUnicode 형태로 바꿔주는 함수.
	private String cnvrtKorToZbUnicd(String strToConvert) {
		String strZpl = "";
		// 한 글자씩 빼서 한글인지 검사.
		for (int i = 0; i < strToConvert.length(); i++) {
			String word = String.valueOf(strToConvert.charAt(i));
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
		return strZpl;
	}
	
	@Override
	public String toString() {
		return "ZebraPrinterZin [ipAddress=" + ipAddress + ", port=" + port + ", barCode=" + barCode + ", customCode="
				+ customCode + ", productName=" + productName + ", productDescription=" + productDescription
				+ ", vendor=" + vendor + ", qty=" + qty + ", date=" + date + ", line=" + line + ", count=" + count
				+ "]";
	}
	
}
