package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ProductionStatusVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 2939793863802637561L;
	private String factoryCd;
	private String plcHisSeq;
	private String plcCd;
	private String equipCd;
	private String plcStatusCd;
	private String prodSeq;
	private int workCnt;
	private int errCnt;
	private int nowWorkCnt;
	private int nowErrCnt;
	private java.util.Date writeDt;
	private String writeDate;
	private String workDt;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getPlcHisSeq() {
		return plcHisSeq;
	}
	public void setPlcHisSeq(String plcHisSeq) {
		this.plcHisSeq = plcHisSeq;
	}
	public String getPlcCd() {
		return plcCd;
	}
	public void setPlcCd(String plcCd) {
		this.plcCd = plcCd;
	}
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public String getPlcStatusCd() {
		return plcStatusCd;
	}
	public void setPlcStatusCd(String plcStatusCd) {
		this.plcStatusCd = plcStatusCd;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public int getWorkCnt() {
		return workCnt;
	}
	public void setWorkCnt(int workCnt) {
		this.workCnt = workCnt;
	}
	public int getErrCnt() {
		return errCnt;
	}
	public void setErrCnt(int errCnt) {
		this.errCnt = errCnt;
	}
	public int getNowWorkCnt() {
		return nowWorkCnt;
	}
	public void setNowWorkCnt(int nowWorkCnt) {
		this.nowWorkCnt = nowWorkCnt;
	}
	public int getNowErrCnt() {
		return nowErrCnt;
	}
	public void setNowErrCnt(int nowErrCnt) {
		this.nowErrCnt = nowErrCnt;
	}
	public java.util.Date getWriteDt() {
		return writeDt;
	}
	public void setWriteDt(java.util.Date writeDt) {
		this.writeDt = writeDt;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getWorkDt() {
		return workDt;
	}
	public void setWorkDt(String workDt) {
		this.workDt = workDt;
	}
	
}
