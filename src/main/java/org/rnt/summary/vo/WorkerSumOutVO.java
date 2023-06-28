package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkerSumOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216275318711013782L;
	private String ymd;
	private String sabunId;
	private String sabunNm;
	private String itemCd;
	private String itemNm;
	private String actokQty;
	private String actbadQty;
	private String badRate;
	
	public String getYmd() {
		return ymd;
	}
	public void setYmd(String ymd) {
		this.ymd = ymd;
	}
	public String getSabunId() {
		return sabunId;
	}
	public void setSabunId(String sabunId) {
		this.sabunId = sabunId;
	}
	public String getSabunNm() {
		return sabunNm;
	}
	public void setSabunNm(String sabunNm) {
		this.sabunNm = sabunNm;
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
	public String getBadRate() {
		return badRate;
	}
	public void setBadRate(String badRate) {
		this.badRate = badRate;
	}
	
}
