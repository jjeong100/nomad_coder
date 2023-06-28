package org.rnt.com.util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import org.rnt.com.vo.PrintCompletionBarcodeOutputVo;
import org.rnt.com.vo.PrintMaterialBarcodeOutputVo;
import org.rnt.com.vo.PrintProductionBarcodeOutputVo;

public class ZebraPrinter {
	
	
	PrintMaterialBarcodeOutputVo printMaterialBarcodeOutputVo;			//입고 바코드 프린터 정보	
	PrintProductionBarcodeOutputVo printProductionBarcodeOutputVo;		//생산 바코드 프린터 정보
	
	PrintCompletionBarcodeOutputVo printCompletionBarcodeOutputVo;		//완료바코드정보
	private String zplFormat;
	private String IpAdress;
	private int Port;
	private int Count;
	
	public ZebraPrinter(String zplFormat, String IpAdress, int Port, int Count) {
		this.zplFormat = zplFormat;
		this.IpAdress = IpAdress;
		this.Port = Port;
		this.Count = Count;
	}
	public ZebraPrinter(PrintMaterialBarcodeOutputVo printMaterialBarcodeOutputVo) {
		this.printMaterialBarcodeOutputVo = printMaterialBarcodeOutputVo;
	}
	public ZebraPrinter(PrintProductionBarcodeOutputVo printProductionBarcodeOutputVo) {
		this.printProductionBarcodeOutputVo = printProductionBarcodeOutputVo;
	}

	public ZebraPrinter(PrintCompletionBarcodeOutputVo printCompletionBarcodeOutputVo) {
		this.printCompletionBarcodeOutputVo = printCompletionBarcodeOutputVo;
	}
	
	
	//입고 프린트 출력
	public int print() {
		System.out.println("zebraImageCode -->" + zplFormat);		
		int result = 0;		
		/*String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO100,30"  // x축 100, y축 30, 추가로 정렬상태(0: 왼쪽, 1: 오른쪽, 2: 자동)
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + printMaterialBarcodeOutputVo.getBarCode() + "^FS"  // 12345678-16B1201
				+"^SEE:UHANGUL.DAT^FS"  
				+"^CW1,E:KFONT3.FNT^CI28^FS"				
				+ "^FO100,200^A1N,20,20 ^FH ^FD "+cnvrtKorToZbUnicd("원자재명")	+" 	: "	+ cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getProductName()) + "^FS"			//원자재명
				+ "^FO100,280^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("재질(규격)")+" : " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getProductDescription()) + "^FS"	//재질(규격)
				+ "^FO100,360^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("납품처")+" : " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getCompanyName()) + "^FS"	//공급처
				+ "^FO100,440^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("입고일자")+" : " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getDeliveryDate()) + "^FS"			//입고일자
				+ "^XZ";*/
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(IpAdress, Port);
			dos = new DataOutputStream(socket.getOutputStream());
			for (int i = 0 ; i < Count ; i++) {
				dos.writeBytes(zplFormat);
				++result;
			}
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (socket != null) {  try { socket.close(); } catch (IOException e) { e.printStackTrace(); }  }
			if (dos != null) {  try { dos.close(); } catch (IOException e) { e.printStackTrace(); }  }
		}
		
		return result;
	}
	
	
	//생산바코드 프린트 출력
	public int print2() {
		System.out.println("ZebraPrinter.print2 - " + printProductionBarcodeOutputVo);		
		int result = 0;		
		
		String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO100,40"  // 10
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + printProductionBarcodeOutputVo.getBarCode() + "^FS"  // 바코드
				+ "^FO700,240^GB120,120,8^FS"   //"^FO730,40^GB100,100,8^FS"  //박스 위치
				+ "^FO670,280"               	//^FO710,60 라인번호 위치
				+ "^CFG^FR^FD " + printProductionBarcodeOutputVo.getLine() + " ^FS"																//생산중인라인
				+"^SEE:UHANGUL.DAT^FS"
				+"^CW1,E:KFONT3.FNT^CI28^FS"
				+ "^FO50,200^A1N,30,30^FH^FD" + cnvrtKorToZbUnicd("모    델    명")+"	: "	+ cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getProductName()) + "^FS"		//모델명,제품명
				+ "^FO50,250^A1N,30,30^FH^FD" + cnvrtKorToZbUnicd("제   품    Lot  ")+": " + cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getProductLot()) + "^FS"			//제품lot
				+ "^FO50,300^A1N,30,30^FH^FD" + cnvrtKorToZbUnicd("생산예정수량")+"	: " + cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getPlannedquantity()) + "^FS"	//생산예정수량
				+ "^FO50,350^A1N,30,30^FH^FD" + cnvrtKorToZbUnicd("원자재  Lot")+"	: " + cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getExternaLean()) + "^FS"		//원자재lot
				+ "^FO50,400^A1N,30,30^FH^FD" + cnvrtKorToZbUnicd("바    코   드")+"	: " + printProductionBarcodeOutputVo.getBarCode()+ "^FS"								//#1바코드
				+ "^FO50,450^A1N,30,30^FH^FD" + cnvrtKorToZbUnicd("U D I  바코드")+"	: " + printProductionBarcodeOutputVo.getUDIbarcode() + "^FS"							//UDI바코드
				+ "^XZ";
			
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(printProductionBarcodeOutputVo.getIpAddress(), printProductionBarcodeOutputVo.getPort());
			dos = new DataOutputStream(socket.getOutputStream());
			for (int i = 0 ; i < printProductionBarcodeOutputVo.getCount() ; i++) {
				dos.writeBytes(zplFormat);
				++result;
			}
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (socket != null) {  try { socket.close(); } catch (IOException e) { e.printStackTrace(); }  }
			if (dos != null) {  try { dos.close(); } catch (IOException e) { e.printStackTrace(); }  }
		}
		
		return result;
	}
	
		
	//완료(덴탈) 프린트 출력
	public int print3() {
		System.out.println("ZebraPrinter.print - " + printCompletionBarcodeOutputVo);
		int result = 0;
		String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO100,40"  // 10
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + printCompletionBarcodeOutputVo.getBarCode() + "^FS"  // 12345678-16B1201
				+"^SEE:UHANGUL.DAT^FS"
				+"^CW1,E:KFONT3.FNT^CI28^FS"	
				+ "^FO100,200^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("공급처")+" : " + cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getCompanyName()) + "^FS"	//공급처
				+ "^FO100,280^A1N,20,20 ^FH ^FD "+cnvrtKorToZbUnicd("제품명")+" : "	+ cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getProductName()) + "^FS"			//원자재명
				+ "^FO100,360^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("규격")+" : " + cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getProductDescription()) + "^FS"	//재질(규격)
				+ "^FO100,440^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("생산제조일")+" : " + cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getTodaydate()) + "^FS"	
				+ "^XZ";	
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(printCompletionBarcodeOutputVo.getIpAddress(), printCompletionBarcodeOutputVo.getPort());
			dos = new DataOutputStream(socket.getOutputStream());
			for (int i = 0 ; i < printCompletionBarcodeOutputVo.getCount() ; i++) {
				dos.writeBytes(zplFormat);
				++result;
			}
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (socket != null) {  try { socket.close(); } catch (IOException e) { e.printStackTrace(); }  }
			if (dos != null) {  try { dos.close(); } catch (IOException e) { e.printStackTrace(); }  }
		}
		return result;
	}
		

	
	//완료(일성용) 프린트 출력
	public int print31() {
		System.out.println("ZebraPrinter.print - " + printCompletionBarcodeOutputVo);		
		int result = 0;		
		String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO130,30"  // 10
				+ "^BY1"  // 바코드 크기 조정
				+ "^BCN,70,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + printCompletionBarcodeOutputVo.getBarCode() + "^FS"  // 12345678-16B1201
				+"^SEE:UHANGUL.DAT^FS"
				+"^CW1,E:KFONT3.FNT^CI28^FS"	
				+ "^FO30,150^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("공급처")+" : " + cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getCompanyName()) + "^FS"	//공급처
				+ "^FO30,190^A1N,20,20 ^FH ^FD "+cnvrtKorToZbUnicd("제품명")+" : "	+ cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getProductName()) + "^FS"			//원자재명
				+ "^FO30,230^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("규격")+" : " + cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getProductDescription()) + "^FS"	//재질(규격)
				+ "^FO30,280^A1N,20,20^FH^FD "+ cnvrtKorToZbUnicd("생산제조일")+" : " + cnvrtKorToZbUnicd(printCompletionBarcodeOutputVo.getTodaydate()) + "^FS"					
				+ "^XZ";	
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(printCompletionBarcodeOutputVo.getIpAddress(), printCompletionBarcodeOutputVo.getPort());
			dos = new DataOutputStream(socket.getOutputStream());
			for (int i = 0 ; i < printCompletionBarcodeOutputVo.getCount() ; i++) {
				dos.writeBytes(zplFormat);
				++result;
			}
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (socket != null) {  try { socket.close(); } catch (IOException e) { e.printStackTrace(); }  }
			if (dos != null) {  try { dos.close(); } catch (IOException e) { e.printStackTrace(); }  }
		}
		
		return result;
	}
		
	
	private String cnvrtKorToZbUnicd(String strToConvert) {
		if (strToConvert == null) {
			return "";
		}
		
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
	
}
