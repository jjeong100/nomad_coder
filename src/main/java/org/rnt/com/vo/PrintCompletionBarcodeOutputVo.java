package org.rnt.com.vo;

import java.util.Date;

public class PrintCompletionBarcodeOutputVo {
	 
	//완료 바코드 프린트 출력 Vo 생성 
	
	private String ipAddress; 			// 바코드 프린터 IP Address
	private int port; 					// 바코드 프린터 Port
	
	private String productName;			//제품명
	private String orderNumber;			//제조번호
	private String createdateNow; 		//제조일자
	private String productDescription; 	//포장단위,규격
	
	private String desc1;				//제조헙 허가번호
	private String desc2;				//제조품목허가번호
	private String desc3;				//유효기간
	private String desc4;				//일회용 및 재사용금지
	private String desc5;				//의료기기
	private String desc6;				//사용자 멸균
	private String desc7;				//라벨이름
	private String desc8;				//모델명
	
	private String companyName;			//고객사명,제조업자
	private String street;				//주소
	
	
	private String UDIbarcode; 			//UBI바코드

	private int count;					//출력장수
	
	
	private String barCode;
	
	
	private String todaydate;	//현재날짜가져오기
	
	
	public PrintCompletionBarcodeOutputVo() {}


	public PrintCompletionBarcodeOutputVo(String ipAddress, int port, String productName, String orderNumber,
			String createdateNow, String productDescription, String desc1, String desc2, String desc3, String desc4,
			String desc5, String desc6, String desc7, String desc8, String companyName, String street,
			String uDIbarcode, int count, String barCode, String todaydate) {
		super();
		this.ipAddress = ipAddress;
		this.port = port;
		this.productName = productName;
		this.orderNumber = orderNumber;
		this.createdateNow = createdateNow;
		this.productDescription = productDescription;
		this.desc1 = desc1;
		this.desc2 = desc2;
		this.desc3 = desc3;
		this.desc4 = desc4;
		this.desc5 = desc5;
		this.desc6 = desc6;
		this.desc7 = desc7;
		this.desc8 = desc8;
		this.companyName = companyName;
		this.street = street;
		this.UDIbarcode = uDIbarcode;
		this.count = count;
		this.barCode = barCode;
		this.todaydate = todaydate;
	}






	public String getIpAddress() {
		return ipAddress;
	}


	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}


	public int getPort() {
		return port;
	}


	public void setPort(int port) {
		this.port = port;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getOrderNumber() {
		return orderNumber;
	}


	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}


	public String getCreatedateNow() {
		return createdateNow;
	}


	public void setCreatedateNow(String createdateNow) {
		this.createdateNow = createdateNow;
	}


	public String getProductDescription() {
		return productDescription;
	}


	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}


	public String getDesc1() {
		return desc1;
	}


	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}


	public String getDesc2() {
		return desc2;
	}


	public void setDesc2(String desc2) {
		this.desc2 = desc2;
	}


	public String getDesc3() {
		return desc3;
	}


	public void setDesc3(String desc3) {
		this.desc3 = desc3;
	}


	public String getDesc4() {
		return desc4;
	}


	public void setDesc4(String desc4) {
		this.desc4 = desc4;
	}


	public String getDesc5() {
		return desc5;
	}


	public void setDesc5(String desc5) {
		this.desc5 = desc5;
	}


	public String getDesc6() {
		return desc6;
	}


	public void setDesc6(String desc6) {
		this.desc6 = desc6;
	}


	public String getUDIbarcode() {
		return UDIbarcode;
	}


	public void setUDIbarcode(String uDIbarcode) {
		this.UDIbarcode = uDIbarcode;
	}

	
	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
	}


	public String getCompanyName() {
		return companyName;
	}


	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}


	public String getStreet() {
		return street;
	}


	public void setStreet(String street) {
		this.street = street;
	}


	public String getDesc7() {
		return desc7;
	}

	public void setDesc7(String desc7) {
		this.desc7 = desc7;
	}

	public String getDesc8() {
		return desc8;
	}

	public void setDesc8(String desc8) {
		this.desc8 = desc8;
	}


	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}


	public String getTodaydate() {
		return todaydate;
	}


	public void setTodaydate(String todaydate) {
		this.todaydate = todaydate;
	}


	@Override
	public String toString() {
		return "PrintCompletionBarcodeOutputVo [ipAddress=" + ipAddress + ", port=" + port + ", productName="
				+ productName + ", orderNumber=" + orderNumber + ", createdateNow=" + createdateNow
				+ ", productDescription=" + productDescription + ", desc1=" + desc1 + ", desc2=" + desc2 + ", desc3="
				+ desc3 + ", desc4=" + desc4 + ", desc5=" + desc5 + ", desc6=" + desc6 + ", desc7=" + desc7 + ", desc8="
				+ desc8 + ", companyName=" + companyName + ", street=" + street + ", UDIbarcode=" + UDIbarcode
				+ ", count=" + count + ", barCode=" + barCode + ", todaydate=" + todaydate + "]";
	}


	
	
}
