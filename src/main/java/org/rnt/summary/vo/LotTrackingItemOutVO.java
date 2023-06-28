package org.rnt.summary.vo;
import java.io.Serializable;

public class LotTrackingItemOutVO extends LotTrackingVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String itemoutDt;
	private String custNm;
	private String outQty;
	private String boxCnt;
	private String box1Qty;
	private String sabunNm;
	
	public String getItemoutDt() {
		return itemoutDt;
	}
	public void setItemoutDt(String itemoutDt) {
		this.itemoutDt = itemoutDt;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getOutQty() {
		return outQty;
	}
	public void setOutQty(String outQty) {
		this.outQty = outQty;
	}
	public String getBoxCnt() {
		return boxCnt;
	}
	public void setBoxCnt(String boxCnt) {
		this.boxCnt = boxCnt;
	}
	public String getBox1Qty() {
		return box1Qty;
	}
	public void setBox1Qty(String box1Qty) {
		this.box1Qty = box1Qty;
	}
	public String getSabunNm() {
		return sabunNm;
	}
	public void setSabunNm(String sabunNm) {
		this.sabunNm = sabunNm;
	}
	
}
