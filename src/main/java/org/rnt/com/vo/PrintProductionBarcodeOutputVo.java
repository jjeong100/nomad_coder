package org.rnt.com.vo;


public class PrintProductionBarcodeOutputVo {
	
	//생산 바코드 프린트 출력 Vo 생성
	
	private String ipAddress; 			// 바코드 프린터 IP Address
	private int port; 					// 바코드 프린터 Port
	
	private String productName; 		// 모델명
	private String productLot;			// 제품코드
	private String plannedquantity;		// 생산예정수량
	private String externaLean;			// 원자재Lot

	private String lotNumber;			//원자재 바코드
	private String BarCode;				//바코드
	private String line;				//생산라인
		
	private int count;					// 출력 장수
	
	
	private String UDIbarcode;			//UDI바코드 추가
	
	
	
	public PrintProductionBarcodeOutputVo() {}




	public PrintProductionBarcodeOutputVo(String ipAddress, int port, String productName, String productLot,
			String plannedquantity, String externaLean, String lotNumber, String barCode, String line, int count,
			String uDIbarcode) {
		super();
		this.ipAddress = ipAddress;
		this.port = port;
		this.productName = productName;
		this.productLot = productLot;
		this.plannedquantity = plannedquantity;
		this.externaLean = externaLean;
		this.lotNumber = lotNumber;
		BarCode = barCode;
		this.line = line;
		this.count = count;
		UDIbarcode = uDIbarcode;
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


	public String getProductLot() {
		return productLot;
	}


	public void setProductLot(String productLot) {
		this.productLot = productLot;
	}



	public String getExternaLean() {
		return externaLean;
	}


	public void setExternaLean(String externaLean) {
		this.externaLean = externaLean;
	}



	public String getPlannedquantity() {
		return plannedquantity;
	}


	public void setPlannedquantity(String plannedquantity) {
		this.plannedquantity = plannedquantity;
	}

	
	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
	}

	public String getBarCode() {
		return BarCode;
	}

	public void setBarCode(String barCode) {
		BarCode = barCode;
	}


	public String getLine() {
		return line;
	}


	public void setLine(String line) {
		this.line = line;
	}


	
	public String getLotNumber() {
		return lotNumber;
	}


	public void setLotNumber(String lotNumber) {
		this.lotNumber = lotNumber;
	}

	
	
	public String getUDIbarcode() {
		return UDIbarcode;
	}



	public void setUDIbarcode(String uDIbarcode) {
		UDIbarcode = uDIbarcode;
	}




	@Override
	public String toString() {
		return "PrintProductionBarcodeOutputVo [ipAddress=" + ipAddress + ", port=" + port + ", productName="
				+ productName + ", productLot=" + productLot + ", plannedquantity=" + plannedquantity + ", externaLean="
				+ externaLean + ", lotNumber=" + lotNumber + ", BarCode=" + BarCode + ", line=" + line + ", count="
				+ count + ", UDIbarcode=" + UDIbarcode + "]";
	}



	
	
}
