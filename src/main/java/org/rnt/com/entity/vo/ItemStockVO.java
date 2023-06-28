package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemStockVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 9072318193468654161L;
	private String sbDt;        // 수불 일자
	private String workshopCd;  // 자재 창고 코드
	private String workshopNm;  // 자재 창고 명
	private String baseQty;     // 기초재고
	private String itemCd;
	private String itemNm;
	private String itemInQty;
	private String itemInCanQty;
	private String itemOutQty;
	private String itemOutWaitQty;
	private String itemOutCanQty;
	private String itemModifyQty;
	private String itemDisuseQty;
	private String stockQty;

	private String searchWorkshopCd;
	private String searchItemCd;

	public String getItemOutWaitQty() {
		return itemOutWaitQty;
	}
	public void setItemOutWaitQty(String itemOutWaitQty) {
		this.itemOutWaitQty = itemOutWaitQty;
	}
	public String getItemDisuseQty() {
		return itemDisuseQty;
	}
	public void setItemDisuseQty(String itemDisuseQty) {
		this.itemDisuseQty = itemDisuseQty;
	}
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
	public String getBaseQty() {
		return baseQty;
	}
	public void setBaseQty(String baseQty) {
		this.baseQty = baseQty;
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
	public String getItemInQty() {
		return itemInQty;
	}
	public void setItemInQty(String itemInQty) {
		this.itemInQty = itemInQty;
	}
	public String getItemInCanQty() {
		return itemInCanQty;
	}
	public void setItemInCanQty(String itemInCanQty) {
		this.itemInCanQty = itemInCanQty;
	}
	public String getItemOutQty() {
		return itemOutQty;
	}
	public void setItemOutQty(String itemOutQty) {
		this.itemOutQty = itemOutQty;
	}
	public String getItemOutCanQty() {
		return itemOutCanQty;
	}
	public void setItemOutCanQty(String itemOutCanQty) {
		this.itemOutCanQty = itemOutCanQty;
	}
	public String getItemModifyQty() {
		return itemModifyQty;
	}
	public void setItemModifyQty(String itemModifyQty) {
		this.itemModifyQty = itemModifyQty;
	}
	public String getStockQty() {
		return stockQty;
	}
	public void setStockQty(String stockQty) {
		this.stockQty = stockQty;
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
