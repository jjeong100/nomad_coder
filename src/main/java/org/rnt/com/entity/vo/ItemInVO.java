package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemInVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 6062938182606080284L;
    private String factoryCd;
    private String iteminSeq;
    private String iteminDt;
    private String mqcSeq;
    private String qmCheckdt;
    private String prodSeq;
    private String prodPoNo;
    private String prodQmNo;
    private String custCd;
    private String custNm;
    private String itemCd;
    private String itemNm;
    private String itemInTypeCd;
    private String itemInTypeNm;
    private Double poQty;
    private Double actokQty;
    private Double qmActokQty;
    private Double inokQty;
    private Double outsideQty;
    private Double stockQty;
    private Double bulkBoxByQty;
    private String workshopCd;
    private String workshopNm;
    private String lotid;
    private String matLotid;
    private Double outQty;
    private String box1Qty;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    // add
    private String searchType;
    private String searchMqcSeq;
    private String searchFromQmCheckdt;
    private String searchToQmCheckdt;
    private String searchFromIteminDt;
    private String searchToIteminDt;
    private String searchProdPoNo;
    private String searchItemNm;
    private String searchCustNm;



	public Double getOutQty() {
		return outQty;
	}
	public void setOutQty(Double outQty) {
		this.outQty = outQty;
	}
	public String getSearchMqcSeq() {
        return searchMqcSeq;
    }
    public void setSearchMqcSeq(String searchMqcSeq) {
        this.searchMqcSeq = searchMqcSeq;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getIteminSeq() {
		return iteminSeq;
	}
	public void setIteminSeq(String iteminSeq) {
		this.iteminSeq = iteminSeq;
	}
	public String getIteminDt() {
		return iteminDt;
	}
	public void setIteminDt(String iteminDt) {
		this.iteminDt = iteminDt;
	}
	public String getMqcSeq() {
		return mqcSeq;
	}
	public void setMqcSeq(String mqcSeq) {
		this.mqcSeq = mqcSeq;
	}
	public String getQmCheckdt() {
		return qmCheckdt;
	}
	public void setQmCheckdt(String qmCheckdt) {
		this.qmCheckdt = qmCheckdt;
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
	public String getProdQmNo() {
		return prodQmNo;
	}
	public void setProdQmNo(String prodQmNo) {
		this.prodQmNo = prodQmNo;
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
	public String getItemInTypeCd() {
		return itemInTypeCd;
	}
	public void setItemInTypeCd(String itemInTypeCd) {
		this.itemInTypeCd = itemInTypeCd;
	}
	public String getItemInTypeNm() {
		return itemInTypeNm;
	}
	public void setItemInTypeNm(String itemInTypeNm) {
		this.itemInTypeNm = itemInTypeNm;
	}
	public Double getPoQty() {
		return poQty;
	}
	public void setPoQty(Double poQty) {
		this.poQty = poQty;
	}
	public Double getActokQty() {
		return actokQty;
	}
	public void setActokQty(Double actokQty) {
		this.actokQty = actokQty;
	}
	public Double getQmActokQty() {
		return qmActokQty;
	}
	public void setQmActokQty(Double qmActokQty) {
		this.qmActokQty = qmActokQty;
	}
	public Double getInokQty() {
		return inokQty;
	}
	public void setInokQty(Double inokQty) {
		this.inokQty = inokQty;
	}
	public Double getOutsideQty() {
		return outsideQty;
	}
	public void setOutsideQty(Double outsideQty) {
		this.outsideQty = outsideQty;
	}
	public Double getStockQty() {
		return stockQty;
	}
	public void setStockQty(Double stockQty) {
		this.stockQty = stockQty;
	}
	public Double getBulkBoxByQty() {
		return bulkBoxByQty;
	}
	public void setBulkBoxByQty(Double bulkBoxByQty) {
		this.bulkBoxByQty = bulkBoxByQty;
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
	public String getLotid() {
		return lotid;
	}
	public void setLotid(String lotid) {
		this.lotid = lotid;
	}
	public String getMatLotid() {
		return matLotid;
	}
	public void setMatLotid(String matLotid) {
		this.matLotid = matLotid;
	}
	public String getBox1Qty() {
		return box1Qty;
	}
	public void setBox1Qty(String box1Qty) {
		this.box1Qty = box1Qty;
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
	public String getSearchFromIteminDt() {
		return searchFromIteminDt;
	}
	public void setSearchFromIteminDt(String searchFromIteminDt) {
		this.searchFromIteminDt = searchFromIteminDt;
	}
	public String getSearchToIteminDt() {
		return searchToIteminDt;
	}
	public void setSearchToIteminDt(String searchToIteminDt) {
		this.searchToIteminDt = searchToIteminDt;
	}
	public String getSearchProdPoNo() {
		return searchProdPoNo;
	}
	public void setSearchProdPoNo(String searchProdPoNo) {
		this.searchProdPoNo = searchProdPoNo;
	}
	public String getSearchItemNm() {
		return searchItemNm;
	}
	public void setSearchItemNm(String searchItemNm) {
		this.searchItemNm = searchItemNm;
	}
	public String getSearchCustNm() {
		return searchCustNm;
	}
	public void setSearchCustNm(String searchCustNm) {
		this.searchCustNm = searchCustNm;
	}

}
