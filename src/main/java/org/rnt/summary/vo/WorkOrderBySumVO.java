package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkOrderBySumVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = -7777263359378185049L;
	
	private String prodPoNo;
	private String poCalldt;
	private String itemCd;
	private String itemNm;
	private String poQty;
	private String actokQty;
	private String checkQty;
	private String inokQty;
	private String outQty;
	
	private String searchItemNm;
	private String searchItemCd;
	
	public String getProdPoNo() {
		return prodPoNo;
	}
	public void setProdPoNo(String prodPoNo) {
		this.prodPoNo = prodPoNo;
	}
	public String getPoCalldt() {
		return poCalldt;
	}
	public void setPoCalldt(String poCalldt) {
		this.poCalldt = poCalldt;
	}
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	public String getItemNm() {
		return itemNm;
	}
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	public String getPoQty() {
		return poQty;
	}
	public void setPoQty(String poQty) {
		this.poQty = poQty;
	}
	public String getActokQty() {
		return actokQty;
	}
	public void setActokQty(String actokQty) {
		this.actokQty = actokQty;
	}
	public String getCheckQty() {
		return checkQty;
	}
	public void setCheckQty(String checkQty) {
		this.checkQty = checkQty;
	}
	public String getInokQty() {
		return inokQty;
	}
	public void setInokQty(String inokQty) {
		this.inokQty = inokQty;
	}
	public String getOutQty() {
		return outQty;
	}
	public void setOutQty(String outQty) {
		this.outQty = outQty;
	}
	public String getSearchItemNm() {
		return searchItemNm;
	}
	public void setSearchItemNm(String searchItemNm) {
		this.searchItemNm = searchItemNm;
	}
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
	
}
