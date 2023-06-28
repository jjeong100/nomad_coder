package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkactInfoVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = 1872741992471261451L;
	private String factoryCd;
	private String measureSeq;
	private String prodSeq;
	private String operSeq;
	private String workactSeq;
	private String temperatureVal;
	private String huminityVal;
	private String pressVal;
	private String conTime;
	private String inspDt;
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
	public String getMeasureSeq() {
		return measureSeq;
	}
	public void setMeasureSeq(String measureSeq) {
		this.measureSeq = measureSeq;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getOperSeq() {
		return operSeq;
	}
	public void setOperSeq(String operSeq) {
		this.operSeq = operSeq;
	}
	public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getTemperatureVal() {
		return temperatureVal;
	}
	public void setTemperatureVal(String temperatureVal) {
		this.temperatureVal = temperatureVal;
	}
	public String getHuminityVal() {
		return huminityVal;
	}
	public void setHuminityVal(String huminityVal) {
		this.huminityVal = huminityVal;
	}
	public String getPressVal() {
		return pressVal;
	}
	public void setPressVal(String pressVal) {
		this.pressVal = pressVal;
	}
	public String getConTime() {
		return conTime;
	}
	public void setConTime(String conTime) {
		this.conTime = conTime;
	}
	public String getInspDt() {
		return inspDt;
	}
	public void setInspDt(String inspDt) {
		this.inspDt = inspDt;
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
