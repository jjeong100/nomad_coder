package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemOutDtlVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 514542688897288905L;
    private String factoryCd;
    private String itemoutSeq;
    private String itemoutdSeq;
    private String prodSeq;
    private String prodPoNo;
    private String itemCd;
    private String itemNm;
    private String custNm;
    private Double outsideQty;
    private String lotOutId;
    private String lotOdtlId;
    private String lotOdtlWrdt;
    private String lotOdtlSabun;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    private String searchItemoutSeq;
    
    private String itemNo;
    private String itemCustLotid;

    public String getItemCustLotid() {
    	return this.itemCustLotid;
    }
    
    public void setItemCustLotid(String itemCustLotid) {
    	this.itemCustLotid = itemCustLotid;
    }
    
    public String getItemNo() {
        return itemNo;
    }
    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }
    public String getCustNm() {
        return custNm;
    }
    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }
    public String getSearchItemoutSeq() {
        return searchItemoutSeq;
    }
    public void setSearchItemoutSeq(String searchItemoutSeq) {
        this.searchItemoutSeq = searchItemoutSeq;
    }
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
    public String getItemoutdSeq() {
        return itemoutdSeq;
    }
    public void setItemoutdSeq(String itemoutdSeq) {
        this.itemoutdSeq = itemoutdSeq;
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
    public Double getOutsideQty() {
        return outsideQty;
    }
    public void setOutsideQty(Double outsideQty) {
        this.outsideQty = outsideQty;
    }
    public String getLotOutId() {
        return lotOutId;
    }
    public void setLotOutId(String lotOutId) {
        this.lotOutId = lotOutId;
    }
    public String getLotOdtlId() {
        return lotOdtlId;
    }
    public void setLotOdtlId(String lotOdtlId) {
        this.lotOdtlId = lotOdtlId;
    }
    public String getLotOdtlWrdt() {
        return lotOdtlWrdt;
    }
    public void setLotOdtlWrdt(String lotOdtlWrdt) {
        this.lotOdtlWrdt = lotOdtlWrdt;
    }
    public String getLotOdtlSabun() {
        return lotOdtlSabun;
    }
    public void setLotOdtlSabun(String lotOdtlSabun) {
        this.lotOdtlSabun = lotOdtlSabun;
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
    
}
