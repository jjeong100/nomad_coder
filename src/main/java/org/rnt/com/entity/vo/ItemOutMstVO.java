package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemOutMstVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 9072318193468654161L;
    private String factoryCd;
    private String itemoutSeq;
    private String itemoutDt;
    private String prodSeq;
    private String prodPoNo;
    private String custCd;
    private String custNm;
    private String itemCd;
    private String itemNm;
    private String itemOutTypeCd;
    private String itemOutTypeNm;
    private Integer outQty;
    private String lotid;
    private String lotOutId;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    
    private String searchType;
    private String iteminSeq;
    private String mqcSeq;
    private String iteminDt;
    private Integer inokQty;
    private Integer iteminStockQty;
    
    private Integer totOutQty;
    private Integer storkQty;
    private String searchLotid;
    
    
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
	public String getItemoutSeq() {
		return itemoutSeq;
	}
	public void setItemoutSeq(String itemoutSeq) {
		this.itemoutSeq = itemoutSeq;
	}
	public String getItemoutDt() {
		return itemoutDt;
	}
	public void setItemoutDt(String itemoutDt) {
		this.itemoutDt = itemoutDt;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getProdPoNo() {
		return prodPoNo;
	}
	public void setProdPoNo(String prodPoNo) {
		this.prodPoNo = prodPoNo;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
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
	public String getItemOutTypeCd() {
		return itemOutTypeCd;
	}
	public void setItemOutTypeCd(String itemOutTypeCd) {
		this.itemOutTypeCd = itemOutTypeCd;
	}
	public String getItemOutTypeNm() {
		return itemOutTypeNm;
	}
	public void setItemOutTypeNm(String itemOutTypeNm) {
		this.itemOutTypeNm = itemOutTypeNm;
	}
	public Integer getOutQty() {
		return outQty;
	}
	public void setOutQty(Integer outQty) {
		this.outQty = outQty;
	}
	public String getLotid() {
		return lotid;
	}
	public void setLotid(String lotid) {
		this.lotid = lotid;
	}
	public String getLotOutId() {
		return lotOutId;
	}
	public void setLotOutId(String lotOutId) {
		this.lotOutId = lotOutId;
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
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getIteminSeq() {
		return iteminSeq;
	}
	public void setIteminSeq(String iteminSeq) {
		this.iteminSeq = iteminSeq;
	}
	public String getMqcSeq() {
		return mqcSeq;
	}
	public void setMqcSeq(String mqcSeq) {
		this.mqcSeq = mqcSeq;
	}
	public String getIteminDt() {
		return iteminDt;
	}
	public void setIteminDt(String iteminDt) {
		this.iteminDt = iteminDt;
	}
	public Integer getInokQty() {
		return inokQty;
	}
	public void setInokQty(Integer inokQty) {
		this.inokQty = inokQty;
	}
	public Integer getIteminStockQty() {
		return iteminStockQty;
	}
	public void setIteminStockQty(Integer iteminStockQty) {
		this.iteminStockQty = iteminStockQty;
	}
	public Integer getTotOutQty() {
		return totOutQty;
	}
	public void setTotOutQty(Integer totOutQty) {
		this.totOutQty = totOutQty;
	}
	public Integer getStorkQty() {
		return storkQty;
	}
	public void setStorkQty(Integer storkQty) {
		this.storkQty = storkQty;
	}
	public String getSearchLotid() {
		return searchLotid;
	}
	public void setSearchLotid(String searchLotid) {
		this.searchLotid = searchLotid;
	}
}
