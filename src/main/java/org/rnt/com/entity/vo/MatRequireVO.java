package org.rnt.com.entity.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class MatRequireVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 4645174063934754380L;
	private String factoryCd;
	private String opmatSeq;
	private String bomSeq;
	private String bomStdt;
	private Integer bomLevel;
	private String itemCd;
	private String itemNm;
	private String matCd;
	private String matNm;
	private String matTypeCd;
	private String matTypeNm;
	private String outCustYn;
	private String prodSeq;
	private String prodPoNo;
	private String operCd;
	private String operNm;
	private String operSeq;
	private Double demandQty;
	private Double confirmQty;
	private Double remainQty;
	private Double nonProductQty;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	private Integer poQty;
	private List<MatRequireVO> objList;

	private String poCalldt;
	private String searchProdSeq;
	private String searchItemCd;
	private String searchMatCd;
	private String searchBomTypeCd;
	private String searchOperSeq;
	private Integer searchPoQty;
	private Double matOutQty;
	private String lotid;


	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getOpmatSeq() {
		return opmatSeq;
	}
	public void setOpmatSeq(String opmatSeq) {
		this.opmatSeq = opmatSeq;
	}
	public String getBomSeq() {
		return bomSeq;
	}
	public void setBomSeq(String bomSeq) {
		this.bomSeq = bomSeq;
	}
	public String getBomStdt() {
		return bomStdt;
	}
	public void setBomStdt(String bomStdt) {
		this.bomStdt = bomStdt;
	}
	public Integer getBomLevel() {
		return bomLevel;
	}
	public void setBomLevel(Integer bomLevel) {
		this.bomLevel = bomLevel;
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
	public String getMatTypeCd() {
		return matTypeCd;
	}
	public void setMatTypeCd(String matTypeCd) {
		this.matTypeCd = matTypeCd;
	}
	public String getMatTypeNm() {
		return matTypeNm;
	}
	public void setMatTypeNm(String matTypeNm) {
		this.matTypeNm = matTypeNm;
	}
	public String getOutCustYn() {
		return outCustYn;
	}
	public void setOutCustYn(String outCustYn) {
		this.outCustYn = outCustYn;
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
	public Double getDemandQty() {
		return demandQty;
	}
	public void setDemandQty(Double demandQty) {
		this.demandQty = demandQty;
	}
	public Double getConfirmQty() {
		return confirmQty;
	}
	public void setConfirmQty(Double confirmQty) {
		this.confirmQty = confirmQty;
	}
	public Double getRemainQty() {
		return remainQty;
	}
	public void setRemainQty(Double remainQty) {
		this.remainQty = remainQty;
	}
	public Double getNonProductQty() {
		return nonProductQty;
	}
	public void setNonProductQty(Double nonProductQty) {
		this.nonProductQty = nonProductQty;
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
	public Integer getPoQty() {
		return poQty;
	}
	public void setPoQty(Integer poQty) {
		this.poQty = poQty;
	}
	public List<MatRequireVO> getObjList() {
		return objList;
	}
	public void setObjList(List<MatRequireVO> objList) {
		this.objList = objList;
	}
	public String getPoCalldt() {
		return poCalldt;
	}
	public void setPoCalldt(String poCalldt) {
		this.poCalldt = poCalldt;
	}
	public String getSearchProdSeq() {
		return searchProdSeq;
	}
	public void setSearchProdSeq(String searchProdSeq) {
		this.searchProdSeq = searchProdSeq;
	}
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
	public String getSearchMatCd() {
		return searchMatCd;
	}
	public void setSearchMatCd(String searchMatCd) {
		this.searchMatCd = searchMatCd;
	}
	public String getSearchBomTypeCd() {
		return searchBomTypeCd;
	}
	public void setSearchBomTypeCd(String searchBomTypeCd) {
		this.searchBomTypeCd = searchBomTypeCd;
	}
	public String getSearchOperSeq() {
		return searchOperSeq;
	}
	public void setSearchOperSeq(String searchOperSeq) {
		this.searchOperSeq = searchOperSeq;
	}
	public Integer getSearchPoQty() {
		return searchPoQty;
	}
	public void setSearchPoQty(Integer searchPoQty) {
		this.searchPoQty = searchPoQty;
	}
	public Double getMatOutQty() {
		return matOutQty;
	}
	public void setMatOutQty(Double matOutQty) {
		this.matOutQty = matOutQty;
	}
	public String getLotid() {
		return lotid;
	}
	public void setLotid(String lotid) {
		this.lotid = lotid;
	}

}
