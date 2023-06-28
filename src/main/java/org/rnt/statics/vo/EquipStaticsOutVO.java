package org.rnt.statics.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class EquipStaticsOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338912013712L;
	private String equipCd;
	private Double baseYearRate;
	private Double compYearRate;
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public Double getBaseYearRate() {
		return baseYearRate;
	}
	public void setBaseYearRate(Double baseYearRate) {
		this.baseYearRate = baseYearRate;
	}
	public Double getCompYearRate() {
		return compYearRate;
	}
	public void setCompYearRate(Double compYearRate) {
		this.compYearRate = compYearRate;
	}
    
    
}
