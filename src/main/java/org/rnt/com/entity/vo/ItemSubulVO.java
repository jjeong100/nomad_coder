package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemSubulVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 9072318193468654161L;
	private String sbDt;        // 수불 일자
	private String workshopCd;  // 자재 창고 코드
	private String workshopNm;  // 자재 창고 명
	private String itemCd;
	private String itemNm;
	private String gubun;
	private String lotId;
	private String qty;
	
	private String searchWorkshopCd;
	private String searchItemCd;
	public String getSbDt() {
		return sbDt;
	}
	public void setSbDt(String sbDt) {
		this.sbDt = sbDt;
	}
	public String getWorkshopCd() {
		return workshopCd;
	}
	public void setWorkshopCd(String workshopCd) {
		this.workshopCd = workshopCd;
	}
	public String getWorkshopNm() {
		return workshopNm;
	}
	public void setWorkshopNm(String workshopNm) {
		this.workshopNm = workshopNm;
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
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getLotId() {
		return lotId;
	}
	public void setLotId(String lotId) {
		this.lotId = lotId;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getSearchWorkshopCd() {
		return searchWorkshopCd;
	}
	public void setSearchWorkshopCd(String searchWorkshopCd) {
		this.searchWorkshopCd = searchWorkshopCd;
	}
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
	
	
}
