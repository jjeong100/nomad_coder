package org.rnt.com.entity.vo;
import java.io.Serializable;

import org.rnt.com.vo.SearchDefaultVO;

public class FinishQmBadVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = 6363401647302478214L;
	
	private String factoryCd;
	private String mqcSeq;
	private String mqcBadSeq;
	private String badCd;
	private String badNm;
	private String badQty;
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
	public String getMqcSeq() {
		return mqcSeq;
	}
	public void setMqcSeq(String mqcSeq) {
		this.mqcSeq = mqcSeq;
	}
	public String getMqcBadSeq() {
		return mqcBadSeq;
	}
	public void setMqcBadSeq(String mqcBadSeq) {
		this.mqcBadSeq = mqcBadSeq;
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
	public String getBadQty() {
		return badQty;
	}
	public void setBadQty(String badQty) {
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
