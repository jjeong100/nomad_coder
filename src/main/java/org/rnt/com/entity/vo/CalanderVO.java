package org.rnt.com.entity.vo;
import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.rnt.com.vo.SearchDefaultVO;

public class CalanderVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 3996629268910064918L;
	private String factoryCd;
	private String yyymmdd;
	private String dayNm;
	private int day;
	private String yweekCd;
	private String mweekCd;
	private String workYn;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	
	private String content;

	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getYyymmdd() {
		return yyymmdd;
	}
	public void setYyymmdd(String yyymmdd) {
		this.yyymmdd = yyymmdd;
	}
	public String getDayNm() {
		return dayNm;
	}
	public void setDayNm(String dayNm) {
		this.dayNm = dayNm;
	}
	public String getYweekCd() {
		return yweekCd;
	}
	public void setYweekCd(String yweekCd) {
		this.yweekCd = yweekCd;
	}
	public String getMweekCd() {
		return mweekCd;
	}
	public void setMweekCd(String mweekCd) {
		this.mweekCd = mweekCd;
	}
	public String getWorkYn() {
		return workYn;
	}
	public void setWorkYn(String workYn) {
		this.workYn = workYn;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
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
	
	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
