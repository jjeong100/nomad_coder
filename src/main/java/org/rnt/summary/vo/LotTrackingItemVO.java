package org.rnt.summary.vo;
import java.io.Serializable;

public class LotTrackingItemVO extends LotTrackingVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String itemCd;
	private String itemNo;
	private String itemNm;
	private String itemKind;
	private String custNm;
	private String poQty;
	private String actokQty;
	private String workedDt;
	private String inokQty;
	private String outsideQty;
	private String remainQty;
	
	public String getInokQty() {
        return inokQty;
    }

    public void setInokQty(String inokQty) {
        this.inokQty = inokQty;
    }

    public String getOutsideQty() {
        return outsideQty;
    }

    public void setOutsideQty(String outsideQty) {
        this.outsideQty = outsideQty;
    }

    public String getRemainQty() {
        return remainQty;
    }

    public void setRemainQty(String remainQty) {
        this.remainQty = remainQty;
    }

    public String getItemCd() {
		return itemCd;
	}

	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}

	public String getItemKind() {
		return itemKind;
	}

	public void setItemKind(String itemKind) {
		this.itemKind = itemKind;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
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

	public String getWorkedDt() {
		return workedDt;
	}

	public void setWorkedDt(String workedDt) {
		this.workedDt = workedDt;
	}
	
}
