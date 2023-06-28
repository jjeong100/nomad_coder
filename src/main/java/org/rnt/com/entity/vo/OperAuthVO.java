package org.rnt.com.entity.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class OperAuthVO extends SearchDefaultVO implements Serializable {

	private static final long serialVersionUID = -6204902839701441744L;
	
	private String factoryCd;
	private String operAuthCd;
	private String operAuthNm;
	private String operCd;
	private String operNm;
	private String operChkYn;
	private int sortOrd;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	
	private String searchOperAuthNm;
	
	private List<OperAuthVO> operAuthDtlList;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getOperAuthCd() {
		return operAuthCd;
	}
	public void setOperAuthCd(String operAuthCd) {
		this.operAuthCd = operAuthCd;
	}
	public String getOperAuthNm() {
		return operAuthNm;
	}
	public void setOperAuthNm(String operAuthNm) {
		this.operAuthNm = operAuthNm;
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
	public String getOperChkYn() {
		return operChkYn;
	}
	public void setOperChkYn(String operChkYn) {
		this.operChkYn = operChkYn;
	}
	public int getSortOrd() {
		return sortOrd;
	}
	public void setSortOrd(int sortOrd) {
		this.sortOrd = sortOrd;
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
	public String getSearchOperAuthNm() {
		return searchOperAuthNm;
	}
	public void setSearchOperAuthNm(String searchOperAuthNm) {
		this.searchOperAuthNm = searchOperAuthNm;
	}
	public List<OperAuthVO> getOperAuthDtlList() {
		return operAuthDtlList;
	}
	public void setOperAuthDtlList(List<OperAuthVO> operAuthDtlList) {
		this.operAuthDtlList = operAuthDtlList;
	}
	
}
