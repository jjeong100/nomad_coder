package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkerMonthSumVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String ym;
	private String sabunId;
	private String loginName;
	private String itemCd;
	private String itemNm;
	private String actokQty;
	private String actbadQty;
	
	private String searchItemNm;
	private String searchItemCd;
	private String searchLoginName;
	public String getYm() {
		return ym;
	}
	public void setYm(String ym) {
		this.ym = ym;
	}
	public String getSabunId() {
		return sabunId;
	}
	public void setSabunId(String sabunId) {
		this.sabunId = sabunId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
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
	public String getActokQty() {
		return actokQty;
	}
	public void setActokQty(String actokQty) {
		this.actokQty = actokQty;
	}
	public String getActbadQty() {
		return actbadQty;
	}
	public void setActbadQty(String actbadQty) {
		this.actbadQty = actbadQty;
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
	public String getSearchLoginName() {
		return searchLoginName;
	}
	public void setSearchLoginName(String searchLoginName) {
		this.searchLoginName = searchLoginName;
	}
	
}