package org.rnt.statics.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DeliveryStaticsInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911313782L;
	private String searchBaseYear;
	private String searchCompYear;
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
