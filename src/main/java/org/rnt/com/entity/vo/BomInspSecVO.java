package org.rnt.com.entity.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class BomInspSecVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = 4581030923796133477L;
	
	private String factoryCd;
	private String bomSecSeq;
	private String bomSeq;
	private String secVal;
	private String secNm;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	
	private List<BomInspSecVO> objList;
	
	private String searchItemCd;
	private String searchOperSeq;
	private String searchProdSeq;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getBomSecSeq() {
		return bomSecSeq;
	}
	public void setBomSecSeq(String bomSecSeq) {
		this.bomSecSeq = bomSecSeq;
	}
	public String getBomSeq() {
		return bomSeq;
	}
	public void setBomSeq(String bomSeq) {
		this.bomSeq = bomSeq;
	}
	public String getSecVal() {
		return secVal;
	}
	public void setSecVal(String secVal) {
		this.secVal = secVal;
	}
	public String getSecNm() {
		return secNm;
	}
	public void setSecNm(String secNm) {
		this.secNm = secNm;
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
	public String getSearchOperSeq() {
		return searchOperSeq;
	}
	public void setSearchOperSeq(String searchOperSeq) {
		this.searchOperSeq = searchOperSeq;
	}
	public List<BomInspSecVO> getObjList() {
		return objList;
	}
	public void setObjList(List<BomInspSecVO> objList) {
		this.objList = objList;
	}
	public String getSearchProdSeq() {
		return searchProdSeq;
	}
	public void setSearchProdSeq(String searchProdSeq) {
		this.searchProdSeq = searchProdSeq;
	}
}
