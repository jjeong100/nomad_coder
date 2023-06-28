package org.rnt.com.vo;


public class PrintMaterialBarcodeOutputVo {
	
	//입고 바코드 프린트 출력 Vo 생성
	  
	private String ipAddress; 			// 바코드 프린터 IP Address
	private int port; 					// 바코드 프린터 Port
	
	private String productName; 		// 제품 이름
	private String deliveryDate;		//입고일자
	private String deliveredquantity;	//길이,수량
	private String externaLean;			//원자재lot
	private String inspectionCompleted;	//검사결과
	private String description;			//특이사항
	private String ceo;					//담당ceo
	private String approver;			//승인자
	private String productDescription;	 // 규격 
	private String BarCode;				//승인자
	
	private int count;					 // 출력 장수
	
	private String companyName;   //추가된공급처
	
	
	
	public PrintMaterialBarcodeOutputVo() {}



	public PrintMaterialBarcodeOutputVo(String ipAddress, int port, String productName, String deliveryDate,
			String deliveredquantity, String externaLean, String inspectionCompleted, String description, String ceo,
			String approver, String productDescription, String barCode, int count, String companyName) {
		super();
		this.ipAddress = ipAddress;
		this.port = port;
		this.productName = productName;
		this.deliveryDate = deliveryDate;
		this.deliveredquantity = deliveredquantity;
		this.externaLean = externaLean;
		this.inspectionCompleted = inspectionCompleted;
		this.description = description;
		this.ceo = ceo;
		this.approver = approver;
		this.productDescription = productDescription;
		this.BarCode = barCode;
		this.count = count;
		this.companyName = companyName;
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


	public String getDeliveryDate() {
		return deliveryDate;
	}


	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}


	public String getDeliveredquantity() {
		return deliveredquantity;
	}


	public void setDeliveredquantity(String deliveredquantity) {
		this.deliveredquantity = deliveredquantity;
	}


	public String getExternaLean() {
		return externaLean;
	}


	public void setExternaLean(String externaLean) {
		this.externaLean = externaLean;
	}


	public String getInspectionCompleted() {
		return inspectionCompleted;
	}


	public void setInspectionCompleted(String inspectionCompleted) {
		this.inspectionCompleted = inspectionCompleted;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getCeo() {
		return ceo;
	}


	public void setCeo(String ceo) {
		this.ceo = ceo;
	}


	public String getApprover() {
		return approver;
	}


	public void setApprover(String approver) {
		this.approver = approver;
	}


	public String getProductDescription() {
		return productDescription;
	}


	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}



	public String getBarCode() {
		return BarCode;
	}



	public void setBarCode(String barCode) {
		BarCode = barCode;
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



	@Override
	public String toString() {
		return "PrintMaterialBarcodeOutputVo [ipAddress=" + ipAddress + ", port=" + port + ", productName="
				+ productName + ", deliveryDate=" + deliveryDate + ", deliveredquantity=" + deliveredquantity
				+ ", externaLean=" + externaLean + ", inspectionCompleted=" + inspectionCompleted + ", description="
				+ description + ", ceo=" + ceo + ", approver=" + approver + ", productDescription=" + productDescription
				+ ", BarCode=" + BarCode + ", count=" + count + ", companyName=" + companyName + "]";
	}



	

	

	
}
