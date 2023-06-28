package org.rnt.statics.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class EquipStaticsOutVO2 extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013712L;
	private Double baseYearTotRate;
	private Double compYearTotRate;
	public Double getBaseYearTotRate() {
		return baseYearTotRate;
	}
	public void setBaseYearTotRate(Double baseYearTotRate) {
		this.baseYearTotRate = baseYearTotRate;
	}
	public Double getCompYearTotRate() {
		return compYearTotRate;
	}
	public void setCompYearTotRate(Double compYearTotRate) {
		this.compYearTotRate = compYearTotRate;
	}
    
}
