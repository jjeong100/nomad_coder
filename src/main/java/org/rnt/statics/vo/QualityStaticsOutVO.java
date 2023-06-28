package org.rnt.statics.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class QualityStaticsOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375378911013712L;
	private String month;
	private Double baseYearRate;
	private Double compYearRate;
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
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
