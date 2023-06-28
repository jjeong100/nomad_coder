package org.rnt.com.util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.rnt.com.vo.PrintMaterialBarcodeOutputVo;
import org.rnt.com.vo.PrintProductionBarcodeOutputVo;

public class ZebraPrinterOrg {
	 
	
	PrintMaterialBarcodeOutputVo printMaterialBarcodeOutputVo;			//입고 바코드 프린터 정보	
	PrintProductionBarcodeOutputVo printProductionBarcodeOutputVo;		//생산 바코드 프린터 정보
		
	
	public ZebraPrinterOrg(PrintMaterialBarcodeOutputVo printMaterialBarcodeOutputVo) {
		this.printMaterialBarcodeOutputVo = printMaterialBarcodeOutputVo;
	}
	public ZebraPrinterOrg(PrintProductionBarcodeOutputVo printProductionBarcodeOutputVo) {
		this.printProductionBarcodeOutputVo = printProductionBarcodeOutputVo;
	}


	//입고 프린트 출력
	public int print() {
		System.out.println("ZebraPrinter.print - " + printMaterialBarcodeOutputVo);		
		int result = 0;		
		String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO40,40"  // 10
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + printMaterialBarcodeOutputVo.getBarCode() + "^FS"  // 12345678-16B1201
				+ "^FO730,180^GB100,100,8^FS"   //"^FO730,40^GB100,100,8^FS"
				+ "^FO710,200"               //^FO710,60
				//+ "^CFG^FR^FD " + barcodePrintVo.getLine() + " ^FS"
				+"^SEE:UHANGUL.DAT^FS"
				+"^CW1,E:KFONT3.FNT^CI28^FS"
				+ "^FO30,240^A1N,30,30^FH^FD 원자재명	   	: "	+ cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getProductName()) + "^FS"			//원자재명
				+ "^FO30,240^A1N,30,30^FH^FD 입고일자 		: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getDeliveryDate()) + "^FS"			//입고일자
				+ "^FO30,280^A1N,30,30^FH^FD 재질(규격)	: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getProductDescription()) + "^FS"	//재질(규격)
				+ "^FO30,280^A1N,30,30^FH^FD 길이/수량 		: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getDeliveredquantity()) + "^FS"	//길이/수량
				+ "^FO30,280^A1N,30,30^FH^FD 원자재LotNo 	: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getExternaLean()) + "^FS"			//원자재LotNo
				+ "^FO30,280^A1N,30,30^FH^FD 검사결과	   	: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getInspectionCompleted()) + "^FS"	//검사결과
				+ "^FO30,320^A1N,30,30^FH^FD 특이사항 		: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getDescription()) + "^FS"			//특이사항
				+ "^FO30,360^A1N,30,30^FH^FD 담당자 	   	: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getCeo()) + "^FS"					//담당자
				+ "^FO30,360^A1N,30,30^FH^FD 입고승인자 	: " + cnvrtKorToZbUnicd(printMaterialBarcodeOutputVo.getApprover()) + "^FS"				//입고승인자
				+ "^FO30,200^A1N,30,30^FH^FD 바코드		: " + printMaterialBarcodeOutputVo.getBarCode() + "^FS"									//바코드
				+ "^FO480,360^A1N,30,30^FH^FD Date		: " + new SimpleDateFormat("yyyy-mm-dd").format(new Date()) + "^FS"						//Date
				+ "^FO200,420"
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"   // COde 128, 100=>바코드높이, 바코드밑에 번호
				//+ "^FD" + printMaterialBarcodeOutputVo.getCustomCode() + "^FS"  // 12345678-16B1201
				+ "^XZ";	
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(printMaterialBarcodeOutputVo.getIpAddress(), printMaterialBarcodeOutputVo.getPort());
			dos = new DataOutputStream(socket.getOutputStream());
			for (int i = 0 ; i < printMaterialBarcodeOutputVo.getCount() ; i++) {
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
	
	

	
	//생산프린트 출력
	public int print2() {
		System.out.println("ZebraPrinter.print2 - " + printProductionBarcodeOutputVo);		
		int result = 0;		
		String zplFormat = "^XA"  // Start
				+ "^MD4"  // Darkness
				+ "^FO40,40"  // 10
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"  // Code128, 100=>바코드높이, 바코드밑에 번호
				+ "^FD" + printProductionBarcodeOutputVo.getBarCode() + "^FS"  // 12345678-16B1201
				+ "^FO730,180^GB100,100,8^FS"   //"^FO730,40^GB100,100,8^FS"
				+ "^FO710,200"               //^FO710,60
				+ "^CFG^FR^FD " + printProductionBarcodeOutputVo.getLine() + " ^FS"																//생산중인라인
				+"^SEE:UHANGUL.DAT^FS"
				+"^CW1,E:KFONT3.FNT^CI28^FS"
				+ "^FO30,240^A1N,30,30^FH^FD ITEM  		: "	+ cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getProductName()) + "^FS"		//모델명,제품명
				+ "^FO30,240^A1N,30,30^FH^FD 제품Lot 		: " + cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getProductLot()) + "^FS"			//제품lot
				+ "^FO30,280^A1N,30,30^FH^FD 생산예정수량   	: " + cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getPlannedquantity()) + "^FS"	//생산예정수량
				+ "^FO30,280^A1N,30,30^FH^FD 원자재Lot	: " + cnvrtKorToZbUnicd(printProductionBarcodeOutputVo.getExternaLean()) + "^FS"		//원자재lot
				+ "^FO30,200^A1N,30,30^FH^FD #1바코드		: " + printProductionBarcodeOutputVo.getLotNumber() + "^FS"								//#1바코드
				+ "^FO30,200^A1N,30,30^FH^FD #2바코드		: " + printProductionBarcodeOutputVo.getBarCode() + "^FS"								//#2바코드
				+ "^FO480,360^A1N,30,30^FH^FD Date		: " + new SimpleDateFormat("yyyy-mm-dd").format(new Date()) + "^FS"						//현재날짜
				+ "^FO200,420"
				+ "^BY3"  // 바코드 크기 조정
				+ "^BCN,100,Y,N,Y"   // COde 128, 100=>바코드높이, 바코드밑에 번호
				//+ "^FD" + printMaterialBarcodeOutputVo.getCustomCode() + "^FS"  // 12345678-16B1201
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
