package org.rnt.statics.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class QualityStaticsInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911213782L;
	private String searchBaseYear;
	private String searchCompYear;
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
	public String getSearchBaseYear() {
        return searchBaseYear;
    }
    public void setSearchBaseYear(String searchBaseYear) {
        this.searchBaseYear = searchBaseYear;
    }
    public String getSearchCompYear() {
        return searchCompYear;
    }
    public void setSearchCompYear(String searchCompYear) {
        this.searchCompYear = searchCompYear;
    }
}
