package org.rnt.production.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.entity.vo.WorkactErrorVO;
import org.rnt.com.entity.vo.WorkactPerformanceVO;
import org.rnt.com.vo.SearchDefaultVO;

public class ProductionComParamVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316475218901093782L;
	private String workactMstSeq;
	private String workactSeq;
	private String prodSeq;
	private String operCd;
	private String itemCd;
	private String itemNm;
	private String operNm;
	private String operSkipYn;
	// search
	private String searchProdSeq;
	private String searchUpProdSeq;
	private String searchPoCalldt;
	private String dateSearchYn="N";

	private String searchWorkactSeq;
	private String searchInspTypeCd;
	private String searchInspSmeCd;
	private int searchInspDaySeq;


	private List<WorkactPerformanceVO> workactPerformanceList;
	private List<WorkactErrorVO> workactErrorList;


    public String getSearchWorkactSeq() {
		return searchWorkactSeq;
	}
	public void setSearchWorkactSeq(String searchWorkactSeq) {
		this.searchWorkactSeq = searchWorkactSeq;
	}
	public String getSearchInspTypeCd() {
		return searchInspTypeCd;
	}
	public void setSearchInspTypeCd(String searchInspTypeCd) {
		this.searchInspTypeCd = searchInspTypeCd;
	}
	public String getSearchInspSmeCd() {
		return searchInspSmeCd;
	}
	public void setSearchInspSmeCd(String searchInspSmeCd) {
		this.searchInspSmeCd = searchInspSmeCd;
	}
	public int getSearchInspDaySeq() {
		return searchInspDaySeq;
	}
	public void setSearchInspDaySeq(int searchInspDaySeq) {
		this.searchInspDaySeq = searchInspDaySeq;
	}
	public String getDateSearchYn() {
        return dateSearchYn;
    }
    public void setDateSearchYn(String dateSearchYn) {
        this.dateSearchYn = dateSearchYn;
    }
    public String getWorkactMstSeq() {
        return workactMstSeq;
    }
    public void setWorkactMstSeq(String workactMstSeq) {
        this.workactMstSeq = workactMstSeq;
    }
    public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getProdSeq() {
        return prodSeq;
    }
    public void setProdSeq(String prodSeq) {
        this.prodSeq = prodSeq;
    }
    public String getOperCd() {
        return operCd;
    }
    public void setOperCd(String operCd) {
        this.operCd = operCd;
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
    public String getOperNm() {
        return operNm;
    }
    public void setOperNm(String operNm) {
        this.operNm = operNm;
    }
    public String getOperSkipYn() {
		return operSkipYn;
	}
	public void setOperSkipYn(String operSkipYn) {
		this.operSkipYn = operSkipYn;
	}
	public String getSearchProdSeq() {
        return searchProdSeq;
    }
    public void setSearchProdSeq(String searchProdSeq) {
        this.searchProdSeq = searchProdSeq;
    }
    public String getSearchUpProdSeq() {
        return searchUpProdSeq;
    }
    public void setSearchUpProdSeq(String searchUpProdSeq) {
        this.searchUpProdSeq = searchUpProdSeq;
    }
    public String getSearchPoCalldt() {
        return searchPoCalldt;
    }
    public void setSearchPoCalldt(String searchPoCalldt) {
        this.searchPoCalldt = searchPoCalldt;
    }
	public List<WorkactPerformanceVO> getWorkactPerformanceList() {
		return workactPerformanceList;
	}
	public void setWorkactPerformanceList(List<WorkactPerformanceVO> workactPerformanceList) {
		this.workactPerformanceList = workactPerformanceList;
	}
	public List<WorkactErrorVO> getWorkactErrorList() {
		return workactErrorList;
	}
	public void setWorkactErrorList(List<WorkactErrorVO> workactErrorList) {
		this.workactErrorList = workactErrorList;
	}
}
