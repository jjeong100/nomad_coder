package org.rnt.com.entity.vo;
import java.io.Serializable;

import org.rnt.com.vo.SearchDefaultVO;

public class WorkactErrorVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 7994683236235562641L;
	private String factoryCd;
	private String workactSeq;
	private String workactBadSeq;
	private String badCd;
	private String badNm;
	private Integer badQty;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getWorkactBadSeq() {
		return workactBadSeq;
	}
	public void setWorkactBadSeq(String workactBadSeq) {
		this.workactBadSeq = workactBadSeq;
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
	public Integer getBadQty() {
		return badQty;
	}
	public void setBadQty(Integer badQty) {
		this.badQty = badQty;
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
