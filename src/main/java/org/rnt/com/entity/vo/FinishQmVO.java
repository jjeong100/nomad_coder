package org.rnt.com.entity.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class FinishQmVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 5981335704640832478L;
	private String factoryCd;
	private String mqcSeq;
	private String prodQmNo;
	private String prodSeq;
	private String workactSeq;
	private String prodWaNo;
	private String prodPoNo;
	private String poCalldt;
	private String itemCd;
	private String itemNm;
	private String operCd;
	private String operNm;
	private String operSeq;
	private Double poQty;
	private Double prodActokQty;
	private Double checkQty;
	private Double actokQty;
	private Double actbadQty;
	private String badCd;
	private String badNm;
	private String qmStateCd;
	private String qmStateNm;
	private String qmCheckdt;
	private String qmCheckid;
	private String qmCheckNm;
	private String prodStdt;
	private String qmRem;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	// add
	private String workedDt;
	private String searchFromQmCheckdt;
	private String searchToQmCheckdt;
	private String searchFromPoCalldt;
    private String searchToPoCalldt;
	private String searchItemCd;
	private String searchType;
	private String searchProdPoNo;
	private String searchItemNm;
	private Double qmStockQty;
	private Double remActokQty;
	private Double useCheckQty;
	private String searchFromDate;
	private String searchToDate;
	private String searchQmStateCd;
	private Integer inokQty;

	private List<FinishQmBadVO> objList;


    public String getProdStdt() {
		return prodStdt;
	}
	public void setProdStdt(String prodStdt) {
		this.prodStdt = prodStdt;
	}
	public String getSearchItemNm() {
        return searchItemNm;
    }
    public void setSearchItemNm(String searchItemNm) {
        this.searchItemNm = searchItemNm;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getMqcSeq() {
        return mqcSeq;
    }
    public void setMqcSeq(String mqcSeq) {
        this.mqcSeq = mqcSeq;
    }
    public String getProdQmNo() {
		return prodQmNo;
	}
	public void setProdQmNo(String prodQmNo) {
		this.prodQmNo = prodQmNo;
	}
	public String getProdSeq() {
        return prodSeq;
    }
    public void setProdSeq(String prodSeq) {
        this.prodSeq = prodSeq;
    }
    public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getProdWaNo() {
		return prodWaNo;
	}
	public void setProdWaNo(String prodWaNo) {
		this.prodWaNo = prodWaNo;
	}
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
    public String getOperCd() {
        return operCd;
    }
    public void setOperCd(String operCd) {
        this.operCd = operCd;
    }
    public String getOperNm() {
        return operNm;
    }
    public void setOperNm(String operNm) {
        this.operNm = operNm;
    }
    public String getOperSeq() {
        return operSeq;
    }
    public void setOperSeq(String operSeq) {
        this.operSeq = operSeq;
    }
    public Double getPoQty() {
        return poQty;
    }
    public void setPoQty(Double poQty) {
        this.poQty = poQty;
    }
    public Double getProdActokQty() {
        return prodActokQty;
    }
    public void setProdActokQty(Double prodActokQty) {
        this.prodActokQty = prodActokQty;
    }
    public Double getCheckQty() {
        return checkQty;
    }
    public void setCheckQty(Double checkQty) {
        this.checkQty = checkQty;
    }
    public Double getActokQty() {
        return actokQty;
    }
    public void setActokQty(Double actokQty) {
        this.actokQty = actokQty;
    }
    public Double getActbadQty() {
        return actbadQty;
    }
    public void setActbadQty(Double actbadQty) {
        this.actbadQty = actbadQty;
    }
    public String getBadCd() {
        return badCd;
    }
    public void setBadCd(String badCd) {
        this.badCd = badCd;
    }
    public String getBadNm() {
        return badNm;
    }
    public void setBadNm(String badNm) {
        this.badNm = badNm;
    }
    public String getQmStateCd() {
        return qmStateCd;
    }
    public void setQmStateCd(String qmStateCd) {
        this.qmStateCd = qmStateCd;
    }
    public String getQmStateNm() {
        return qmStateNm;
    }
    public void setQmStateNm(String qmStateNm) {
        this.qmStateNm = qmStateNm;
    }
    public String getQmCheckdt() {
        return qmCheckdt;
    }
    public void setQmCheckdt(String qmCheckdt) {
        this.qmCheckdt = qmCheckdt;
    }
    public String getQmCheckid() {
        return qmCheckid;
    }
    public void setQmCheckid(String qmCheckid) {
        this.qmCheckid = qmCheckid;
    }
    public String getQmCheckNm() {
        return qmCheckNm;
    }
    public void setQmCheckNm(String qmCheckNm) {
        this.qmCheckNm = qmCheckNm;
    }
    public String getQmRem() {
        return qmRem;
    }
    public void setQmRem(String qmRem) {
        this.qmRem = qmRem;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public java.util.Date getWriteDt() {
        return writeDt;
    }
    public void setWriteDt(java.util.Date writeDt) {
        this.writeDt = writeDt;
    }
    public String getWriteId() {
        return writeId;
    }
    public void setWriteId(String writeId) {
        this.writeId = writeId;
    }
    public java.util.Date getUpdateDt() {
        return updateDt;
    }
    public void setUpdateDt(java.util.Date updateDt) {
        this.updateDt = updateDt;
    }
    public String getUpdateId() {
        return updateId;
    }
    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }
    public String getWorkedDt() {
        return workedDt;
    }
    public void setWorkedDt(String workedDt) {
        this.workedDt = workedDt;
    }
    public String getSearchFromQmCheckdt() {
        return searchFromQmCheckdt;
    }
    public void setSearchFromQmCheckdt(String searchFromQmCheckdt) {
        this.searchFromQmCheckdt = searchFromQmCheckdt;
    }
    public String getSearchToQmCheckdt() {
        return searchToQmCheckdt;
    }
    public void setSearchToQmCheckdt(String searchToQmCheckdt) {
        this.searchToQmCheckdt = searchToQmCheckdt;
    }
    public String getSearchFromPoCalldt() {
        return searchFromPoCalldt;
    }
    public void setSearchFromPoCalldt(String searchFromPoCalldt) {
        this.searchFromPoCalldt = searchFromPoCalldt;
    }
    public String getSearchToPoCalldt() {
        return searchToPoCalldt;
    }
    public void setSearchToPoCalldt(String searchToPoCalldt) {
        this.searchToPoCalldt = searchToPoCalldt;
    }
    public String getSearchItemCd() {
        return searchItemCd;
    }
    public void setSearchItemCd(String searchItemCd) {
        this.searchItemCd = searchItemCd;
    }
    public String getSearchType() {
        return searchType;
    }
    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    public String getSearchProdPoNo() {
        return searchProdPoNo;
    }
    public void setSearchProdPoNo(String searchProdPoNo) {
        this.searchProdPoNo = searchProdPoNo;
    }
    public Double getQmStockQty() {
        return qmStockQty;
    }
    public void setQmStockQty(Double qmStockQty) {
        this.qmStockQty = qmStockQty;
    }
    public Double getRemActokQty() {
        return remActokQty;
    }
    public void setRemActokQty(Double remActokQty) {
        this.remActokQty = remActokQty;
    }
    public Double getUseCheckQty() {
        return useCheckQty;
    }
    public void setUseCheckQty(Double useCheckQty) {
        this.useCheckQty = useCheckQty;
    }
	public List<FinishQmBadVO> getObjList() {
		return objList;
	}
	public void setObjList(List<FinishQmBadVO> objList) {
		this.objList = objList;
	}
	public String getSearchFromDate() {
		return searchFromDate;
	}
	public void setSearchFromDate(String searchFromDate) {
		this.searchFromDate = searchFromDate;
	}
	public String getSearchToDate() {
		return searchToDate;
	}
	public void setSearchToDate(String searchToDate) {
		this.searchToDate = searchToDate;
	}
	public String getSearchQmStateCd() {
		return searchQmStateCd;
	}
	public void setSearchQmStateCd(String searchQmStateCd) {
		this.searchQmStateCd = searchQmStateCd;
	}
	public Integer getInokQty() {
		return inokQty;
	}
	public void setInokQty(Integer inokQty) {
		this.inokQty = inokQty;
	}
}
