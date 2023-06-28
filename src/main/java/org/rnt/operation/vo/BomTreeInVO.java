package org.rnt.operation.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class BomTreeInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 1316275218901013782L;
	private String itemCd;
	private String viewItemNm;
	private String operSeq;
	private String operUpcdSeq;
	private String operCd;
	private String searchItemCd;
	
    public String getViewItemNm() {
        return viewItemNm;
    }

    public void setViewItemNm(String viewItemNm) {
        this.viewItemNm = viewItemNm;
    }

    public String getItemCd() {
        return itemCd;
    }

    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }

    public String getOperSeq() {
        return operSeq;
    }

    public void setOperSeq(String operSeq) {
        this.operSeq = operSeq;
    }

    public String getOperUpcdSeq() {
        return operUpcdSeq;
    }

    public void setOperUpcdSeq(String operUpcdSeq) {
        this.operUpcdSeq = operUpcdSeq;
    }

    public String getOperCd() {
        return operCd;
    }

    public void setOperCd(String operCd) {
        this.operCd = operCd;
    }

    public String getSearchItemCd() {
        return searchItemCd;
    }

    public void setSearchItemCd(String searchItemCd) {
        this.searchItemCd = searchItemCd;
    }
	
	
}
