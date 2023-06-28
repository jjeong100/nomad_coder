package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class BomVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 3696807687620411431L;
	private String factoryCd;
	private String bomSeq;
	private String bomVer;
	private String bomStdt;
	private String outcustYn;
	private String custCd;
	private String operCd;
	private String operNm;
	private String custNm;
	private String operSeq;
	private String operUpcd;
	private String operUpcdSeq;
	private String operTopcd;
	private String operTopcdSeq;
	private String bomLevel;
	private String bomTypeCd;
	private String itemCd;
	private String itemLenVal;
	private String itemLenNm;
	private String matCd;
	private String matNm;
	private String matCustNm;
	private String matTypeNm;
	private Integer demandQty;
	private String confirmYn;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	// add
	private String searchItemCd;
	private String searchItemNm;
	private String itemNm;
	private String searchOperSeq;
	private String searchBomTypeCd;
	
	
	private String bomHisSeq;
	private String bomBigo;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getBomSeq() {
		return bomSeq;
	}
	public void setBomSeq(String bomSeq) {
		this.bomSeq = bomSeq;
	}
	public String getBomVer() {
		return bomVer;
	}
	public void setBomVer(String bomVer) {
		this.bomVer = bomVer;
	}
	public String getBomStdt() {
		return bomStdt;
	}
	public void setBomStdt(String bomStdt) {
		this.bomStdt = bomStdt;
	}
	public String getOutcustYn() {
		return outcustYn;
	}
	public void setOutcustYn(String outcustYn) {
		this.outcustYn = outcustYn;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getOperSeq() {
		return operSeq;
	}
	public void setOperSeq(String operSeq) {
		this.operSeq = operSeq;
	}
	public String getOperUpcd() {
		return operUpcd;
	}
	public void setOperUpcd(String operUpcd) {
		this.operUpcd = operUpcd;
	}
	public String getOperUpcdSeq() {
		return operUpcdSeq;
	}
	public void setOperUpcdSeq(String operUpcdSeq) {
		this.operUpcdSeq = operUpcdSeq;
	}
	public String getOperTopcd() {
		return operTopcd;
	}
	public void setOperTopcd(String operTopcd) {
		this.operTopcd = operTopcd;
	}
	public String getOperTopcdSeq() {
		return operTopcdSeq;
	}
	public void setOperTopcdSeq(String operTopcdSeq) {
		this.operTopcdSeq = operTopcdSeq;
	}
	public String getBomLevel() {
		return bomLevel;
	}
	public void setBomLevel(String bomLevel) {
		this.bomLevel = bomLevel;
	}
	public String getBomTypeCd() {
		return bomTypeCd;
	}
	public void setBomTypeCd(String bomTypeCd) {
		this.bomTypeCd = bomTypeCd;
	}
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	public String getItemLenVal() {
		return itemLenVal;
	}
	public void setItemLenVal(String itemLenVal) {
		this.itemLenVal = itemLenVal;
	}
	public String getItemLenNm() {
		return itemLenNm;
	}
	public void setItemLenNm(String itemLenNm) {
		this.itemLenNm = itemLenNm;
	}
	public String getMatCd() {
		return matCd;
	}
	public void setMatCd(String matCd) {
		this.matCd = matCd;
	}
	public String getMatNm() {
		return matNm;
	}
	public void setMatNm(String matNm) {
		this.matNm = matNm;
	}
	public String getMatCustNm() {
		return matCustNm;
	}
	public void setMatCustNm(String matCustNm) {
		this.matCustNm = matCustNm;
	}
	public String getMatTypeNm() {
		return matTypeNm;
	}
	public void setMatTypeNm(String matTypeNm) {
		this.matTypeNm = matTypeNm;
	}
	public Integer getDemandQty() {
		return demandQty;
	}
	public void setDemandQty(Integer demandQty) {
		this.demandQty = demandQty;
	}
	public String getConfirmYn() {
		return confirmYn;
	}
	public void setConfirmYn(String confirmYn) {
		this.confirmYn = confirmYn;
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
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
	public String getSearchBomTypeCd() {
		return searchBomTypeCd;
	}
	public void setSearchBomTypeCd(String searchBomTypeCd) {
		this.searchBomTypeCd = searchBomTypeCd;
	}
	public String getBomHisSeq() {
		return bomHisSeq;
	}
	public void setBomHisSeq(String bomHisSeq) {
		this.bomHisSeq = bomHisSeq;
	}
	public String getBomBigo() {
		return bomBigo;
	}
	public void setBomBigo(String bomBigo) {
		this.bomBigo = bomBigo;
	}
	public String getItemNm() {
		return itemNm;
	}
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	public String getSearchOperSeq() {
		return searchOperSeq;
	}
	public void setSearchOperSeq(String searchOperSeq) {
		this.searchOperSeq = searchOperSeq;
	}
	public String getSearchItemNm() {
		return searchItemNm;
	}
	public void setSearchItemNm(String searchItemNm) {
		this.searchItemNm = searchItemNm;
	}
	
}
